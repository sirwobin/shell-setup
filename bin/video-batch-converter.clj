#!/usr/bin/env nix-shell
#! nix-shell -i bb -p babashka ffmpeg

(require '[babashka.process :refer [sh process alive? parse-args destroy-tree]])
(require '[babashka.pods :as pods])
(pods/load-pod 'org.babashka/lanterna "0.0.1-SNAPSHOT" {#_#_:force true #_#_:transport :socket})
(require '[pod.babashka.lanterna.terminal :as terminal])

(def scr-state (atom {:max-rows    0
                      :max-cols    0
                      :current-row 1}))

(defn handle-screen-resize [cols rows]
  (swap! scr-state assoc :max-cols cols :max-rows rows))

(def scr (terminal/get-terminal {:resize-listener handle-screen-resize}))

(defn update-status! [& text]
  (terminal/put-string (apply str text) 0 (:current-row @scr-state)))

(defn next-screen-row! []
  (swap! scr-state update :current-row inc))

; TODO read from edn file
(def src->dst {"xVR2TjA00rnM91yd.mp4" "aa.mp4"
               "HuU9NKpaSM7eOYpt.mp4" "bb.mp4"
               "gGSaenXMC_EbqkLh.mp4" "cc.mp4"})

(defn parse-progress-report [lines]
  (reduce (fn [result line]
            (let [[k v] (->> line
                             (re-matches #"^(\w+)=\s*(\S+).*")
                             rest)]
              (assoc result (keyword k) (try (Integer/parseInt v) (catch Exception _ v)))))
          {}
          lines))

(defn -main [& args]
  (terminal/in-terminal scr
    (->> (terminal/get-size scr)
         (apply handle-screen-resize))
    (terminal/clear scr)
    (terminal/put-string (str "Screen state is " (pr-str @scr-state)) 0 0)

    (doseq [[src dst] src->dst]
      (let [frame-count    (-> (sh "ffprobe -v error -select_streams v:0 -count_packets -show_entries stream=nb_read_packets -of csv=p=0" src)
                               :out
                               str/trim-newline
                               Integer/parseInt)
            ffmpeg-process (process {:shutdown destroy-tree} "ffmpeg" "-i" src "-vcodec" "h264" "-acodec" "mp2" "-progress" "pipe:1" dst)]
        (with-open [out-rdr  (-> ffmpeg-process :out io/reader)
                    line-rdr (line-seq out-rdr)]
          (update-status! src " -> " dst " starting conversion.  " frame-count " frames in total.")
          (loop [percent-progress-str "0.0%"
                 next-progress-lines  (take 12 line-rdr)]
            (let [{:keys [frame progress] :as progress-report} (parse-progress-report next-progress-lines)
                  new-percent-progress-str                     (format "%.01f" (double (* (/ frame frame-count) 100)))]
              (cond
                (= progress "end")
                (update-status! src " -> " dst " " new-percent-progress-str " (process ended normally with exit code " (:exit @ffmpeg-process) ")")
                    
                (not (alive? ffmpeg-process))
                (update-status! src " -> " dst " " new-percent-progress-str " (process exited before end with exit code " (:exit @ffmpeg-process) ")")

                (not= percent-progress-str new-percent-progress-str)
                (do
                  (update-status! src " -> " dst " " new-percent-progress-str)
                  (recur new-percent-progress-str (take 12 line-rdr)))
                  
                :else
                (recur new-percent-progress-str (take 12 line-rdr))))))
        (next-screen-row!)))
    (update-status! "done.")))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))

