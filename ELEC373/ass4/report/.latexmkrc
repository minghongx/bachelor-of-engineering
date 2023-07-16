# PDF generate method
# - 4: $lualatex
# - 5: $xelatex
$pdf_mode = 4;

# Add common patterns for tex engines.
set_tex_cmds("--synctex=1 --interaction=nonstopmode --file-line-error --shell-escape %O %S");
# $lualatex = "lualatex [...]";
# $xelatex = "xelatex [...]";

# The Biber processing program
$biber =  "biber %O %S";

# When the source file uses bbl files for bibliography, run bibtex or biber as needed to regenerate the bbl files
$bibtex_use = 2;

$out_dir = ".build";

@default_files = ("main.tex");
@default_excluded_files = ();

# Files to clean.
$clean_ext = 'bbl glo gls hd loa run.xml thm xdv';

# Always try to embed fonts, ignoring licensing flags, etc.
$xdvipdfmx = 'xdvipdfmx -E -o %D %O %S';
