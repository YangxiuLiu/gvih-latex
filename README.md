# GVIH LaTeX 双列模板

## 1. 简介
gvih 是一个最轻量的双列 LaTeX 模板，整体不到 300 行代码，用于整理并发表双栏 sci 论文。

## 2. 核心文件

```
├── base.cls       模板格式定义
├── main.tex       需要你编辑的论文正文
├── ref.bib        参考文献数据库
├── start.sh       一键编译脚本
├── figures/       图片目录
└── main.pdf       最终输出结果（运行 start.sh 后生成）
```

## 3. 执行

### 3.1 一键执行
在命令行中执行
```bash
bash start.sh  #自动执行所有内容，生成最终.pdf 文件
```
### 3.2 手动执行编译
在命令行中执行
```bash
xelatex main.tex   # 第一次编译，在 main.pdf 中生成正文结果
biber main         # 第二次编译，读取参考文献 bib 文件，生成 main.aux 文件
xelatex main.tex   # 第三次编译，在 main.pdf 中生成参考文献列表
xelatex main.tex   # 第四次编译，在 main.pdf 中生成正文中的文献引用编号
```
### 3.3 编译器可视化工具执行
在 overleaf、shoptex 等 latex 可视化编辑器中，依次执行`XeLaTeX → Biber → XeLaTeX → XeLaTeX`四个编译器。


## 4. 文件准备
* `main.tex` — 论文正文文件，需要你编辑，具体编辑方式参看下方第5 部分
* `ref.bib` — 参考文献数据库文件。可以下载软件如 Zotero、EndNote 等，将所有文献选中，然后导出为 bib 文件格式。
* `figures/` — 图片目录，用于存放论文中的图片文件。


## 5. 写作指南

### 5.1 总标题

```latex
\settitle{论文标题}
```
### 5.2 作者信息

```latex
% 第一行的作者部分，每个作者用逗号分割，orcidlink表示 orcid 图标格式，textsuperscript表示上标格式
\authorsinfo{Yangxiu Liu\orcidlink{0000-0003-4759-1955\textsuperscript{1*}，
John Doe\orcidlink{0000-0003-4759-1956\textsuperscript{2}}
% 第二行的机构部分，每个作者都用逗号分隔，textsuperscript表示上标格式
\authorsunit{Beijing Esoul AI Information Technology Company Limited\textsuperscript{1}}
% 第三行的通讯作者邮箱，textsuperscript表示上标格式
\corremail{email: liuyangxiu@alu.cau.edu.cn\textsuperscript{1}}
```

### 5.3 摘要与关键词

```latex
\begin{abstract} ... \end{abstract}
\begin{keywords} keyword1, keyword2 \end{keywords}
```
### 5.4 章节标题

```latex
\section{一级标题}
\subsection{二级标题}
\subsubsection{三级标题}
```

### 5.5 参考文献
```latex
\cite{key}                                  % 单篇
\cite{key1,key2}                            % 多篇
```

### 5.6 图片

| 命令 | 用途 | 语法 |
|------|------|------|
| `\singlefigure` | 单栏 | `\singlefigure[宽度]{路径}{标题}{标签}` |
| `\widefigure` | 双栏 | `\widefigure[位置]{宽度}{路径}{标题}{标签}` |

**位置参数**：`t`=顶部, `b`=底部, `tb`=自动(默认)

**宽度参数**：0-1之间的数字，如0.9表示90%宽度

**路径参数**：图片文件路径，如figures/figure1.png

**标题参数**：图片标题，如Single column figure.

**标签参数**：图片标签，如fig:single，用于其他正文引用这个图片

**示例**：
```latex
\singlefigure[0.9]{figures/figure2.png}{Single column figure.}{fig:single}
\widefigure[tb]{0.9}{figures/figure1.png}{Wide figure spanning both columns.}{fig:wide}
```

### 5.7 表格

| 命令 | 用途 | 语法 |
|------|------|------|
| `\singletable` | 单栏 | `\singletable{序号}{列宽}{标题}{表头}{内容}` |
| `\widetable` | 双栏 | `\widetable[位置]{序号}{列宽}{标题}{表头}{内容}` |

**位置参数**（可选）：`t`=顶部, `b`=底部, `tb`=自动(默认)

**序号参数**：表格序号（如 "Table 1"）

**列宽参数**：指定每一列的宽度比例，逗号分隔的数字，如 "0.2,0.3,0.5"，总和应为1

**标题参数**：表格标题

**表头参数**：表格内标题行内容，使用 `&` 分隔列

**内容参数**：表格主体内容，每个单元格用 `&` 分隔，每行用 `\\` 分隔。

**示例：**
```latex
\widetable[tb]{Table 1}{0.33,0.33,0.34}{Characteristics Comparison}{\textbf{Feature} & \textbf{Y chr} & \textbf{X chr}}{%
Mutation rate & High & Medium \\
Gene density & Low & High \\
Evolution rate & Fast & Slow
}
```

### 5.8 公式

| 命令 | 用途 | 语法 |
|------|------|------|
| `\singleequation` | 单栏公式（有序号） | `\singleequation{公式}{eq:label}` |
| `\wideequation` | 双栏公式（有序号，跨栏） | `\wideequation[位置]{公式}{eq:label}` |

**位置参数**（可选）：`t`=顶部, `b`=底部, `tb`=自动(默认)

**示例：**
```latex
\singleequation{E=mc^2}{eq:emc}       % 单栏带编号
\wideequation[tb]{\frac{dx}{dt} = \mu_Y\delta_{j,Y} + T_{j-1 \rightarrow j}x_{i,j-1}}{eq:core}     % 双栏跨栏公式，默认位置
```




## 6. 常见问题
1）问；图片大小超过页面剩余位置，模板自动调整图片位置，导致页面中有大量空白？
答：调整文本内容和位置，让页面中空白位置能够容纳图片

2）问：双栏图片、双栏表格、双栏公式自动放置在下一页，如何放在当前页？
答：移动图片、表格、公式的位置到前一页所在文本的附近，此时的“下一页”就是当前页。

3）问：参考文献 bib 文件如何获得？
答：下载软件 zenodo，导入需要的文献，然后选中多个文献，右键导出，选择 bib 模式即得到 bib 文件。 

4）问：如何修改参考文献格式？
答：在 `base.cls` 文件中修改 `style=numeric` 参数，例如改为 `style=gb7714-2015` 即可换为 GB/T 7714 格式。
