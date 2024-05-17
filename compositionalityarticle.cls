%%
%% This is file `compositionalityarticle.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% compositionalityarticle.dtx  (with options: `package')
%% 
%% =============================================================================
%%
%% compositionality <VERSION> (<DATE>)
%%
%% =============================================================================
\RequirePackage{expl3}[2023/05/11]
\RequirePackage{l3keys2e}
\RequirePackage{xparse}
\RequirePackage{lmodern}
\ProvidesExplClass
{compositionality}
{<DATE>}
{<VERSION>}
{The Compositionality article class}
\keys_define:nn { shrimp }
{
  accepted  .tl_set:N  = \l_shrimp_accepted_tl,
  volume    .tl_set:N  = \l_shrimp_volume_tl,
  issue     .tl_set:N  = \l_shrimp_issue_tl,
  published .bool_set:N = \l_shrimp_published_bool,
  published .default:n  = false,
}

\ProcessKeysOptions { shrimp }
\tl_const:Nn \l_shrimp_doi
  {
    10.32408/compositionality-
    \tl_use:N \l_shrimp_volume_tl
    -
    \tl_use:N \l_shrimp_issue_tl
  }
\LoadClass{article}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{geometry}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{xkeyval}
\RequirePackage{hyperref}
\PassOptionsToPackage{hyperpageref}{backref}
%\RequirePackage{backref}
\def\backrefpagesname{}
\geometry{
  margin=3cm,
}
\hypersetup{
  colorlinks=true,
  allcolors=shrimp,
  backref=page
}
\definecolor{shrimp}{RGB}{255,90,95}
\titleformat{\section}[hang]
  {\normalfont\Large\sffamily}{\thesection}{1em}{}
\titleformat{\subsection}[hang]
  {\normalfont\large\sffamily}{\thesubsection}{1em}{}
\titleformat{\subsubsection}[hang]
  {\normalfont\normalsize\sffamily}{\thesubsubsection}{1em}{}
\titleformat{\paragraph}[runin]
  {\normalfont\normalsize\sffamily}{}{1em}{}[.]
\bool_if:nTF \l_shrimp_published_bool
  {
    \tl_const:Nn \l_shrimp_rhead_content
    {
      \color{shrimp} \sffamily\footnotesize
      Volume ~
      \tl_use:N \l_shrimp_volume_tl
      , ~ Issue ~
      \tl_use:N \l_shrimp_issue_tl \kern1em
      ISSN ~ 2631-4444
    }
  }
  {
    \tl_const:Nn \l_shrimp_rhead_content \c_empty_tl
  }

\bool_if:nTF \l_shrimp_published_bool
  {
  \tl_const:Nn \l_shrimp_lfoot_content
    {
      \color{shrimp} \sffamily\footnotesize
      Accepted ~ in ~ Compositionality ~ on ~
      \tl_use:N \l_shrimp_accepted_tl
      . ~ doi:
      \tl_use:N \l_shrimp_doi
    }
  }
  {
    \tl_const:Nn \l_shrimp_lfoot_content \c_empty_tl
  }
\lhead{}
\chead{}
\rhead{\ifnum\value{page}>1\else\l_shrimp_rhead_content\fi}
\lfoot{\ifnum\value{page}>1\else\l_shrimp_lfoot_content\fi}
\cfoot{}
\rfoot{\color{shrimp}\sffamily\thepage}
\let\headrule\relax
\let\footrulewidth\headrulewidth
\pagestyle{fancy}
\fancypagestyle{plain}{}


\seq_new:N \g__shrimp_authors_seq
\seq_new:N \g__shrimp_affiliation_seq
\seq_new:N \g__shrimp_email_seq
\seq_new:N \g__shrimp_orcid_seq
\seq_new:N \g__shrimp_webpage_seq
\seq_new:N \g__shrimp_thanks_seq

\RenewDocumentCommand{\author}{m}{
  \seq_gput_right:Nn \g__shrimp_authors_seq {#1}
}

\NewDocumentCommand{\affiliation}{m}{
  \seq_put_right:Nn \g__shrimp_affiliation_seq {#1}
}

\NewDocumentCommand{\email}{m}{
  \seq_put_right:Nn \g__shrimp_email_seq {#1}
}

\NewDocumentCommand{\orcid}{m}{
  \seq_put_right:Nn \g__shrimp_orcid_seq {#1}
}

\NewDocumentCommand{\homepage}{m}{
  \seq_put_right:Nn \g__shrimp_webpage_seq {#1}
}

\RenewDocumentCommand{\thanks}{m}{
  \seq_put_right:Nn \g__shrimp_thanks_seq {#1}
}

\cs_new:Nn \__shrimp_print_title_authors: {
  \group_begin:
  \sffamily\large
  \int_step_inline:nn { \seq_count:N \g__shrimp_authors_seq } {
    \seq_item:Nn \g__shrimp_authors_seq { ##1 }
    \textsuperscript { \int_to_arabic:n { ##1 } }
    \int_compare:nNnTF { ##1 + 1 } = { \seq_count:N \g__shrimp_authors_seq } { , ~ and ~ } { }
    \int_compare:nNnTF { ##1 + 1 } < { \seq_count:N \g__shrimp_authors_seq } { , ~ } { }
  }
  \group_end:
}

\cs_new:Nn \__shrimp_print_title_affiliations: {
  \group_begin:
  \sffamily\small\color{gray}
  \int_step_inline:nn { \seq_count:N \g__shrimp_authors_seq } {
    \textsuperscript { \int_to_arabic:n { ##1 } }
    \seq_item:Nn \g__shrimp_affiliation_seq { ##1 }\smallskip\newline
  }
  \group_end:
}

\cs_new:Nn \__shrimp_print_title_footnotes: {
  \group_begin:
  \let\thefootnote\relax
  \int_step_inline:nn { \seq_count:N \g__shrimp_authors_seq } {

    \seq_clear:N \l_tmpa_seq

    \tl_set:Nx \l_tmpa_tl { \seq_item:Nn \g__shrimp_email_seq { ##1 } }
    \tl_if_empty:NTF \l_tmpa_tl {} {
      \seq_put_right:Nx \l_tmpa_seq {
        \exp_not:N \href { mailto: \tl_use:N \l_tmpa_tl } { \tl_use:N \l_tmpa_tl }
      }
    }

    \tl_set:Nx \l_tmpa_tl { \seq_item:Nn \g__shrimp_webpage_seq { ##1 } }
    \tl_if_empty:NTF \l_tmpa_tl {} {
      \seq_put_right:Nx \l_tmpa_seq {
        \exp_not:N \href { \tl_use:N \l_tmpa_tl } { \tl_use:N \l_tmpa_tl }
      }
    }

    \tl_set:Nx \l_tmpa_tl { \seq_item:Nn \g__shrimp_orcid_seq { ##1 } }
    \tl_if_empty:NTF \l_tmpa_tl {} {
      \seq_put_right:Nx \l_tmpa_seq {
        \exp_not:N \href
          { https://orcid.org/\tl_use:N \l_tmpa_tl }
          {
            \lower0.3ex\hbox{\includegraphics[height=2ex]{ORCIDiD_iconvector.pdf}}\thinspace
            \tl_use:N \l_tmpa_tl
          }
      }
    }

    \footnotetext{
      \sffamily
      \seq_item:Nn \g__shrimp_authors_seq { ##1 }:~
      \seq_use:Nn \l_tmpa_seq { ,~ }
      \seq_if_empty:NF \l_tmpa_seq {} {.}
      \seq_item:Nn \g__shrimp_thanks_seq { ##1 }
    }
  }
  \group_end:
}

\newcommand*{\acknowledgmentsname}{Acknowledgments}
\newcommand{\acknowledgments}[1]{%
\section*{\acknowledgmentsname}%
#1%
}

\renewcommand{\maketitle}{
  \global \@topnum \z@%\newpage\null
    \noindent{\normalfont\huge\sffamily\color{shrimp}\@title} \par\bigskip
    \noindent\__shrimp_print_title_authors:
    \par\bigskip
    \noindent\__shrimp_print_title_affiliations:
    \par
    \noindent\__shrimp_print_title_footnotes:
    \par
}

\AtBeginDocument{\renewenvironment{abstract}
{\small\quotation\noindent\ignorespaces}
{\endquotation}}
