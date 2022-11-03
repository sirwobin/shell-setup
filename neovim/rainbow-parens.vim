
let g:rainbow_active = 1

let g:rainbow_conf = {
\       'guifgs': ['red','steelblue1','seagreen2','yellow','magenta1','lightgreen','darkorange','darkslategray1'],
\       'ctermfgs': ['darkred','darkcyan','darkgreen','red','yellow','darkmagenta','gray','brown'],
\	'guis': [''],
\	'cterms': [''],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'markdown': {
\			'parentheses_options': 'containedin=markdownCode contained',
\		},
\		'clojure': {
\			'guifgs': ['red','steelblue1','seagreen2','yellow','magenta1','lightgreen','darkorange','darkslategray1'],
\               },
\		'haskell': {
\			'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
\		},
\		'vim': {
\			'parentheses_options': 'containedin=vimFuncBody',
\		},
\		'perl': {
\			'syn_name_prefix': 'perlBlockFoldRainbow',
\		},
\		'stylus': {
\			'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
\		},
\		'css': 0,
\	}
\}
