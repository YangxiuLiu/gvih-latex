% ============================================================
% GVIH 简化文档类 - 编译方式: XeLaTeX → Biber → XeLaTeX → XeLaTeX
% ============================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{base}[2026/06/05 GVIH Document Class (Simplified)]

%% ---- 基类与页面 ----
\LoadClass[twoside, a4paper, 10pt]{article}
\RequirePackage[left=2.5cm, right=2.5cm, top=2.5cm, bottom=2.5cm]{geometry}

%% ---- 字体 ----
\RequirePackage{fontspec}
\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Courier New}

%% ---- ORCID & 颜色 ----
\RequirePackage{fontawesome5}
\RequirePackage{xcolor}
\definecolor{orcidcolor}{HTML}{A6CE39}

%% ---- 字号变量 ----
\newcommand{\@titlefontsize}{16pt}
\newcommand{\@bodyfontsize}{10pt}
\newcommand{\@tablefontsize}{8pt}

%% ---- 总标题 ----
\def\mytitletext{}
\newcommand{\settitle}[1]{\def\mytitletext{#1}}
\newcommand{\printtitle}{%
  \begin{center}%
  \sffamily\fontsize{\@titlefontsize}{20pt}\bfseries\selectfont
  \mytitletext%
  \end{center}%
}

%% ---- 作者信息 ----
\def\gauthorcontent{}
\def\gaffilcontent{}
\def\gcorrelemail{}
\def\gpaperdate{}
\newcommand{\authorsinfo}[1]{\def\gauthorcontent{#1}}
\newcommand{\authorsunit}[1]{\def\gaffilcontent{#1}}
\newcommand{\corremail}[1]{\def\gcorrelemail{#1}}
\newcommand{\publishdate}[1]{\def\gpaperdate{#1}}
\newcommand{\printauthors}{%
  \par\vspace{0.5cm}%
  \begin{center}%
    \sffamily\bfseries\fontsize{10pt}{10pt}\selectfont\gauthorcontent%
    \par\vspace{0.3cm}%
    \normalfont\itshape\fontsize{9pt}{11pt}\selectfont\gaffilcontent%
    \par\vspace{0.15cm}%
    \ifx\gcorrelemail\empty\else%
      \fontsize{8pt}{9pt}\selectfont\gcorrelemail%
      \par\vspace{0.1cm}%
    \fi%
    \ifx\gpaperdate\empty\else%
      \fontsize{8pt}{9pt}\selectfont\textit{\gpaperdate}%
    \fi%
  \end{center}%
  \par\vspace{1.0cm}%
}

%% ---- 摘要与关键词 ----
\renewenvironment{abstract}{%
  \begin{center}\begin{minipage}{0.75\textwidth}
  \fontsize{9pt}{11pt}\selectfont\setlength{\parindent}{2em}
}{\end{minipage}\end{center}\vskip 0.5cm}

\newenvironment{keywords}{%
  \begin{center}\begin{minipage}{0.75\textwidth}
  \fontsize{9pt}{11pt}\selectfont\textbf{Keywords:}\ \ignorespaces
}{\end{minipage}\end{center}\vskip 1.5cm}

%% ---- 双栏正文 ----
\RequirePackage{multicol}
\setlength{\columnsep}{0.8cm}
\setlength{\baselineskip}{13pt}
\setlength{\parindent}{2em}

%% ---- 章节标题 ----
\RequirePackage{indentfirst}
\RequirePackage{titlesec}
\titleformat{\section}
  {\sffamily\bfseries\fontsize{12pt}{15pt}\selectfont}
  {\thesection}{0.5em}{}
\titleformat{\subsection}
  {\sffamily\bfseries\fontsize{10pt}{13pt}\selectfont}
  {\thesubsection}{0.5em}{}
\titlespacing*{\section}{0pt}{1em}{0.5em}
\titlespacing*{\subsection}{0pt}{0.8em}{0.3em}

%% ---- 图表 ----
\RequirePackage{graphicx}
\RequirePackage{caption}
\captionsetup{labelsep=period, font={sf, small}}

%% ---- 图片 ----
\newcommand{\singlefigure}[4][0.9]{%
  \begin{center}
    \begin{minipage}{\linewidth}
      \centering
      \includegraphics[width=#1\linewidth]{#2}
      \captionof{figure}{\textit{#3}}\label{#4}
    \end{minipage}
  \end{center}}

\newcommand{\widefigure}[5][tb]{%
  \begin{figure*}[#1]\centering
    \begin{minipage}{\textwidth}
      \centering
      \includegraphics[width=#2\textwidth]{#3}
      \caption{\textit{#4}}\label{#5}
    \end{minipage}
  \end{figure*}}

%% ---- 表格 ----
\RequirePackage{amsmath}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage{pgffor}
\RequirePackage{pgfmath}

\newcommand{\tablefont}{\fontsize{\@tablefontsize}{9pt}\selectfont}

% 构建列规范：输入比例列表如 {0.3,0.3,0.4}
% 输出如 >{\hsize=0.3\hsize}X>{\hsize=0.3\hsize}X>{\hsize=0.4\hsize}X
\def\buildcolspec#1{%
  \gdef\colspec{}%
  \foreach \r in {#1} {%
    \pgfmathsetmacro{\colwidth}{\r}%
    \xdef\colspec{\colspec >{\noexpand\hsize=\colwidth\noexpand\hsize}X}%
  }%
}

% 辅助宏：展开 \colspec 后调用 tabularx
\def\dotabularx#1#2{%
  \begin{tabularx}{#1}{#2}%
}

% 双栏表格
% #1=位置, #2=序号, #3=列宽比例, #4=标题, #5=表头, #6=内容
\newcommand{\widetable}[6][tb]{%
  \begin{table*}[#1]\centering
    \tablefont
    \renewcommand{\arraystretch}{1.3}%
    \captionsetup{skip=1pt}%
    \caption*{\bfseries #2. #4}%
    \buildcolspec{#3}%
    \begingroup
    \edef\x{\endgroup\noexpand\begin{tabularx}{\textwidth}{\colspec}}%
    \x
      \toprule
      #5 \\
      \midrule
      #6 \\
      \bottomrule
    \end{tabularx}
  \end{table*}%
}

% 单栏表格
% #1=序号, #2=列宽比例, #3=标题, #4=表头, #5=内容
\newcommand{\singletable}[5]{%
  \begin{table}[htbp]\centering
    \tablefont
    \renewcommand{\arraystretch}{1.3}%
    \captionsetup{skip=1pt}%
    \caption*{\bfseries #1. #3}%
    \buildcolspec{#2}%
    \begingroup
    \edef\x{\endgroup\noexpand\begin{tabularx}{\columnwidth}{\colspec}}%
    \x
      \toprule
      #4 \\
      \midrule
      #5 \\
      \bottomrule
    \end{tabularx}
  \end{table}%
}

%% ---- 公式 ----
\RequirePackage{breqn}
\newcommand{\singleequation}[2]{\begin{dmath}#1\label{#2}\end{dmath}}
\newcommand{\wideequation}[3][tb]{%
  \begin{figure*}[#1!]\centering
    \begin{minipage}{\textwidth}
      \begin{dmath}#2\label{#3}\end{dmath}
    \end{minipage}
  \end{figure*}}

%% ---- 语言支持 ----
\RequirePackage[english]{babel}

%% ---- 参考文献 ----
\RequirePackage[backend=biber, style=numeric, sorting=none]{biblatex}
\AtEveryBibitem{\clearfield{urldate}}
\renewbibmacro*{url+urldate}{\printfield{url}}

%% ---- Hyperref ----
\RequirePackage[colorlinks=true, citecolor=blue, linkcolor=blue, urlcolor=blue]{hyperref}

%% ---- ORCID link ----
\newcommand{\orcidlink}[1]{\href{https://orcid.org/#1}{\textcolor{orcidcolor}{\faOrcid}}}
\endinput

