---
title: LaTex
author: Claudio Corsi
tags: [ LaTex ]
permalink: /notes/latex/
debug: true
sidebar: notes-latex
---

This page will contain different notes of the use of the LaTex software system that is used to produce documents. This
also includes how to use Latex within a web page using MathJax.  The main non-web page LaTex tool that I use is 
<a href="https://www.overleaf.com" target="_blank">Overleaf.com</a>.  I am sure that there are other websites that one
can use to be able to write documents using LaTex.  I currently just know of the one above since this has provided me
with all that I need.

This page will be divided into different LaTex packages and what they offer.  Each section will include a table that
contains the different commands and their resulting outputs.  Note that not all of these outputs can be produced within
a web page so the ones that can will be stated as such.

Let us then look at some of the different LaTex packages.

## Some LaTex Commands

LaTex contains several different commands that I currently don't know which packages they are associated with that I will
be using throughout my web site.  Thus, I will be creating a general list of these commands such that I have somewhere that
I can reference them from.

|:----|:----|:----|:---|:---|
| **Command** | **Output** | **Example** | **Description** |
| \int | $$\int$$ | \int_{a}^{b} f(x) dx => $$\int_{a}^{b} f(x) dx$$ | Produces the mathematical integral symbol |
| \sum | $$\sum$$ | \sum_{n=1}^{\infty}\frac{1}{n} => $$\sum_{n=1}^{\infty}\frac{1}{n}$$ | Produces the mathematical sum symbol |
| \infty | $$\infty$$ |  | Generates the infinity symbol |
| \text{*word* or *phrase*} | | y=mx+b\text{, m is the slope and b is the intersection} => $$y=mx+b\text{, m is the slope and b is the intersection}$$ | Adds text passed to the command |
| \textrm{*word* or *phrase*} | | y=mx+b\textrm{, m is the slope and b is the intersection} => $$y=mx+b\textrm{, m is the slope and b is the intersection}$$ | Adds text passed to the command |
| \partial | $$\partial$$ | \partial_s f(x) = \frac{\partial}{\partial x_0} f(x)\quad \text{for $x= x_0 + I x_1$.} => $$\partial_s f(x) = \frac{\partial}{\partial x_0} f(x)\quad \text{for $x= x_0 + I x_1$.}$$ | Generates the partial derivative symbol |

## ams Latex Package Commands

The following LaTex commands are part of the American Mathematical Society distribution.  It entails the many of the
fundemental symbols used within Mathematics.

|:----|:----|:----|:---|:---|
| **Command** | **Output** | **Example** | **Description** |
| \approxeq | $$\approxeq$$ | | Produces the mathematical approximately equal sign |
| \backepsilon |  $$\backepsilon$$ | | |
| \backprime | $$\backprime$$ | | |
| \backsim | $$\backsim$$ | | |
| \backsimeq | $$\backsimeq$$ | | |
| \barwedge | $$\barwedge$$ | | |
| \Bbbk | $$\Bbbk$$ | | |
| \because | $$\because$$ | | |
| \beth | $$\beth$$ | | |
| \between | $$\between$$ | | |
| \bigstar | $$\bigstar$$ | | |
| \binom{n}{k} | $$\binom{n}{k}$$ | \binom{9}{5} => $$\binom{9}{5}$$ | Generates the binominal coefficients |
| \blacklozenge | $$\blacklozenge$$ | | |
| \blacksquare | $$\blacksquare$$ | | |
| \blacktriangle | $$\blacktriangle$$ | | |
| \blacktriangledown | $$\blacktriangledown$$ | | |
| \blacktriangleleft | $$\blacktriangleleft$$ | | |
| \blacktriangleright | $$\blacktriangleright$$ | | |
| \Box | $$\Box$$ | | |
| \boxdot | $$\boxdot$$ | | |
| \boxed{a} | $$\boxed{a}$$ | \boxed{\eta \leq C(\delta(\eta) +\Lambda_M(0,\delta))} => $$\boxed{\eta \leq C(\delta(\eta) +\Lambda_M(0,\delta))}$$ | Places the defined entries within the {} within a box |
| \boxminus | $$\boxminus$$ | | |
| \boxplus | $$\boxplus$$ | | |
| \boxtimes | $$\boxtimes$$ | | |
| \bumpeq | $$\bumpeq$$ | | |
| \Bumpeq | $$\Bumpeq$$ | | |
| \Cap | $$\Cap$$ | | |
| \centerdot | $$\centerdot$$ | | |
| \cfrac{a}{b} | $$\cfrac{a}{b}$$ | \cfrac{1}{\sqrt{2}+ \cfrac{1}{\sqrt{2}+ \cfrac{1}{\sqrt{2}+\dotsb }}} => $$\cfrac{1}{\sqrt{2}+ \cfrac{1}{\sqrt{2}+ \cfrac{1}{\sqrt{2}+\dotsb }}}$$ | Generates a fraction with the first {} as the numerator and the second {} as the denominator |
| \checkmark | $$\checkmark$$ | | |
| \circeq | $$\circeq$$ | | |
| \circlearrowleft | $$\circlearrowleft$$ | | |
| \circlearrowright | $$\circlearrowright$$ | | |
| \circledast | $$\circledast$$ | | |
| \circledcirc | $$\circledcirc$$ | | |
| \circleddash | $$\circleddash$$ | | |
| \circledR | $$\circledR$$ | | |
| \circledS | $$\circledS$$ | | |
| \complement | $$\complement$$ | | |
| \Cup | $$\Cup$$ | | |
| \curlyeqprec | $$\curlyeqprec$$ | | |
| \curlyeqsucc | $$\curlyeqsucc$$ | | |
| \curlyvee | $$\curlyvee$$ | | |
| \curlywedge | $$\curlywedge$$ | | |
| \curvearrowleft | $$\curvearrowleft$$ | | |
| \curvearrowright | $$\curvearrowright$$ | | |
| \daleth | $$\daleth$$ | | |
| \dashleftarrow | $$\dashleftarrow$$ | | |
| \dashrightarrow | $$\dashrightarrow$$ | | |
| \dbinom{n}{k} | $$\dbinom{n}{k}$$ | \dbinom{n}{k} => $$\dbinom{n}{k}$$ | Generates the binominal coefficients |
| \ddddot{1} | $$\ddddot{1}$$
| \dddot{1} | $$\dddot{1}$$
| \DeclareMathOperator{\Lim}{Lim} | $$\DeclareMathOperator{\Lim}{Lim}$$ | \DeclareMathOperator{\Lim}{Lim} \Lim => $$\DeclareMathOperator{\Lim}{Lim} \Lim$$ | Used to define a personalize operator that will be displayed in Roman font instead of italics where the first parameter is the name of the new command and the second is the command text to be inserted |
| \dfrac{n}{d} | $$\dfrac{n}{d}$$ | \dfrac{1}{2} => $$\dfrac{1}{2}$$ | |
| \diagdown | $$\diagdown$$ | | |
| \diagup | $$\diagup$$ | | |
| \Diamond | $$\Diamond$$ | | |
| \digamma | $$\digamma$$ | | |
| \divideontimes | $$\divideontimes$$ | | |
| \Doteq | $$\Doteq$$ | | |
| \doteqdot | $$\doteqdot$$ | | |
| \dotplus | $$\dotplus$$ | | |
| \doublebarwedge | $$\doublebarwedge$$ | | |
| \doublecap | $$\doublecap$$ | | |
| \doublecup | $$\doublecup$$ | | |
| \downdownarrows | $$\downdownarrows$$ | | |
| \downharpoonleft | $$\downharpoonleft$$ | | |
| \downharpoonright | $$\downharpoonright$$ | | |
| \eqcirc | $$\eqcirc$$ | | |
| eqref{*label*} | | | Used to reference another part of the document |
| \eqsim | $$\eqsim$$ | | |
| \eqslantgtr | $$\eqslantgtr$$ | | |
| \eqslantless | $$\eqslantless$$ | | |
| \eth | $$\eth$$ | | |
| \fallingdotseq | $$\fallingdotseq$$ | | |
| \Finv | $$\Finv$$ | | |
| \frac{1}{3} | $$\frac{1}{3}$$
| \Game | $$\Game$$ | | |
| \genfrac{}{}{}{}{1}{2} | $$\genfrac{}{}{}{}{1}{2}$$ | | TODO: get more documentation on this command |
| \geqq | $$\geqq$$ | | |
| \geqslant | $$\geqslant$$ | | |
| \ggg | $$\ggg$$ | | |
| \gggtr | $$\gggtr$$ | | |
| \gimel | $$\gimel$$ | | |
| \gnapprox | $$\gnapprox$$ | | |
| \gneq | $$\gneq$$ | | |
| \gneqq | $$\gneqq$$ | | |
| \gnsim | $$\gnsim$$ | | |
| \gtrapprox | $$\gtrapprox$$ | | |
| \gtrdot | $$\gtrdot$$ | | |
| \gtreqless | $$\gtreqless$$ | | |
| \gtreqqless | $$\gtreqqless$$ | | |
| \gtrless | $$\gtrless$$ | | |
| \gtrsim | $$\gtrsim$$ | | |
| \gvertneqq | $$\gvertneqq$$ | | |
| \hslash | $$\hslash$$ | | |
| \idotsint | $$\idotsint$$ | | |
| \iiiint | $$\iiiint$$ | | |
| \impliedby | $$\impliedby$$ | | |
| \implies | $$\implies$$ | | |
| \injlim | $$\injlim$$ | | |
| \intercal | $$\intercal$$ | | |
| \Join | $$\Join$$ | | |
| \leadsto | $$\leadsto$$ | | |
| \leftarrowtail | $$\leftarrowtail$$ | | |
| \leftleftarrows | $$\leftleftarrows$$ | | |
| \leftrightarrows | $$\leftrightarrows$$ | | |
| \leftrightharpoons | $$\leftrightharpoons$$ | | |
| \leftrightsquigarrow | $$\leftrightsquigarrow$$ | | |
| \leftthreetimes | $$\leftthreetimes$$ | | |
| \leqq | $$\leqq$$ | | |
| \leqslant | $$\leqslant$$ | | |
| \lessapprox | $$\lessapprox$$ | | |
| \lessdot | $$\lessdot$$ | | |
| \lesseqgtr | $$\lesseqgtr$$ | | |
| \lesseqqgtr | $$\lesseqqgtr$$ | | |
| \lessgtr | $$\lessgtr$$ | | |
| \lesssim | $$\lesssim$$ | | |
| \lhd | $$\lhd$$ | | |
| \llcorner | $$\llcorner$$ | | |
| \Lleftarrow | $$\Lleftarrow$$ | | |
| \lll | $$\lll$$ | | |
| \llless | $$\llless$$ | | |
| \lnapprox | $$\lnapprox$$ | | |
| \lneq | $$\lneq$$ | | |
| \lneqq | $$\lneqq$$ | | |
| \lnsim | $$\lnsim$$ | | |
| \looparrowleft | $$\looparrowleft$$ | | |
| \looparrowright | $$\looparrowright$$ | | |
| \lozenge | $$\lozenge$$ | | |
| \lrcorner | $$\lrcorner$$ | | |
| \Lsh | $$\Lsh$$ | | |
| \ltimes | $$\ltimes$$ | | |
| \lvert | $$\lvert$$ | | |
| \lVert | $$\lVert$$ | | |
| \lvertneqq | $$\lvertneqq$$ | | |
| \maltese | $$\maltese$$ | | |
| \mathring{1} | $$\mathring{1}$$ | | |
| \measuredangle | $$\measuredangle$$ | | |
| \mho | $$\mho$$ | | |
| \multimap | $$\multimap$$ | | |
| \ncong | $$\ncong$$ | | |
| \negmedspace{*entry*} | | \negmedspace{abcd} => $$\negmedspace{abcd}$$ | |
| \negthickspace{*entry*} | | \negthickspace{abcd} => $$\negthickspace{abcd}$$ | |
| \nexists | $$\nexists$$ | | |
| \ngeq | $$\ngeq$$ | | |
| \ngeqq | $$\ngeqq$$ | | |
| \ngeqslant | $$\ngeqslant$$ | | |
| \ngtr | $$\ngtr$$ | | |
| \nleftarrow | $$\nleftarrow$$ | | |
| \nLeftarrow | $$\nLeftarrow$$ | | |
| \nleftrightarrow | $$\nleftrightarrow$$ | | |
| \nleq | $$\nleq$$ | | |
| \nleqq | $$\nleqq$$ | | |
| \nleqslant | $$\nleqslant$$ | | |
| \nless | $$\nless$$ | | |
| \nmid | $$\nmid$$ | | |
| \nobreakspace | "$$\nobreakspace$$" | | Used to create a space |
| \notag | $$\notag$$ | | Tell Latex not to number that particular line |
| \nparallel | $$\nparallel$$ | | |
| \nprec | $$\nprec$$ | | |
| \npreceq | $$\npreceq$$ | | |
| \nrightarrow | $$\nrightarrow$$ | | |
| \nRightarrow | $$\nRightarrow$$ | | |
| \nshortmid | $$\nshortmid$$ | | |
| \nshortparallel | $$\nshortparallel$$ | | |
| \nsim | $$\nsim$$ | | |
| \nsubseteq | $$\nsubseteq$$ | | |
| \nsubseteqq | $$\nsubseteqq$$ | | |
| \nsucc | $$\nsucc$$ | | |
| \nsucceq | $$\nsucceq$$ | | |
| \nsupseteq | $$\nsupseteq$$ | | |
| \nsubseteqq | $$\nsubseteqq$$ | | |
| \nsucc | $$\nsucc$$ | | |
| \nsucceq | $$\nsucceq$$ | | |
| \nsupseteq | $$\nsupseteq$$ | | |
| \nsupseteqq | $$\nsupseteqq$$ | | |
| \ntriangleleft | $$\ntriangleleft$$ | | |
| \ntrianglelefteq | $$\ntrianglelefteq$$ | | |
| \ntriangleright | $$\ntriangleright$$ | | |
| \ntrianglerighteq | $$\ntrianglerighteq$$ | | |
| \nvdash | $$\nvdash$$ | | |
| \nvDash | $$\nvDash$$ | | |
| \nVdash | $$\nVdash$$ | | |
| \nVDash | $$\nVDash$$ | | |
| \operatorname{abc} | $$\operatorname{abc}$$
| \pitchfork | $$\pitchfork$$ | | |
| \precapprox | $$\precapprox$$ | | |
| \preccurlyeq | $$\preccurlyeq$$ | | |
| \precnapprox | $$\precnapprox$$ | | |
| \precneqq | $$\precneqq$$ | | |
| \precnsim | $$\precnsim$$ | | |
| \precsim | $$\precsim$$ | | |
| \projlim | $$\projlim$$ | | Used to create a projlim symbol |
| \restriction | $$\restriction$$ | | |
| \rhd | $$\rhd$$ | | |
| \rightarrowtail | $$\rightarrowtail$$ | | |
| \rightleftarrows | $$\rightleftarrows$$ | | |
| \rightleftharpoons | $$\rightleftharpoons$$ | | |
| \rightrightarrows | $$\rightrightarrows$$ | | |
| \rightsquigarrow | $$\rightsquigarrow$$ | | |
| \rightthreetimes | $$\rightthreetimes$$ | | |
| \risingdotseq | $$\risingdotseq$$ | | |
| \Rrightarrow | $$\Rrightarrow$$ | | |
| \Rsh | $$\Rsh$$ | | |
| \rtimes | $$\rtimes$$ | | |
| \rvert | $$\rvert$$ | | |
| \rVert | $$\rVert$$ | | |
| \shortmid | $$\shortmid$$ | | |
| \shortparallel | $$\shortparallel$$ | | |
| \shoveleft{\mid} | | \\ begin{multline}\\shoveright{a+b+c+d}\\\\\shoveleft{e+f+g+h}\\ end{multline} => $$\begin{multline}\shoveright{a+b+c+d}\\\\\shoveleft{e+f+g+h}\end{multline}$$ | Used for forces flush left typesetting in a \multline or \multline environment |
| \shoveright{\mid} | | \\ begin{multline}a+b+c+d\\\\\shoveright{e+f+g+h}\\ end{multline} => $$\begin{multline}a+b+c+d\\\\\shoveright{e+f+g+h}\end{multline}$$ | Used for forces flush right typesetting in a \multline or \multline environment |
| \equation{} | | \begin{equation}a=b\\c=d\end{equation} => $$\begin{equation}a=b\\c=d\end{equation}$$ | |
| \sideset{_*^*}{_*^*}\prod | $$\sideset{_*^*}{_*^*}\prod $$
| \sideset{}{’} \sum_{n<k,\;\text{$n$ odd}} nE_n | $$\sideset{}{’} \sum_{n<k,\;\text{$n$ odd}} nE_n$$
| \sideset{}{*} A | $$\sideset{}{*} A$$
| \SkipLimits | $$\SkipLimits$$ | | |
| \smallfrown | $$\smallfrown$$ | | |
| \smallsetminus | $$\smallsetminus$$ | | |
| \smallsmile | $$\smallsmile$$ | | |
| \sphericalangle | $$\sphericalangle$$ | | |
| \sqsubset | $$\sqsubset$$ | | |
| \sqsupset | $$\sqsupset$$ | | |
| \square | $$\square$$ | | |
| \Subset | $$\Subset$$ | | |
| \subseteqq | $$\subseteqq$$ | | |
| \subsetneq | $$\subsetneq$$ | | |
| \subsetneqq | $$\subsetneqq$$ | | |
| \sum_{\substack{ 0\le i\le m\\ 0<j<n}} P(i,j) | $$\sum_{\substack{ 0\le i\le m\\ 0<j<n}} P(i,j)$$
| \succapprox | $$\succapprox$$ | | |
| \succcurlyeq | $$\succcurlyeq$$ | | |
| \succnapprox | $$\succnapprox$$ | | |
| \succneqq | $$\succneqq$$ | | |
| \succnsim | $$\succnsim$$ | | |
| \succsim | $$\succsim$$ | | |
| \Supset | $$\Supset$$ | | |
| \supseteqq | $$\supseteqq$$ | | |
| \supsetneq | $$\supsetneq$$ | | |
| \supsetneqq | $$\supsetneqq$$ | | |
| \tag{$*$} | $$\tag{$*$}$$
| \tbinom{k}{n} | $$\tbinom{k}{n}$$
| \tfrac{k}{n} | $$\tfrac{k}{n}$$
| \therefore | $$\therefore$$ | | |
| \thickapprox | $$\thickapprox$$ | | |
| \thicksim | $$\thicksim$$ | | |
| \triangledown | $$\triangledown$$ | | |
| \trianglelefteq | $$\trianglelefteq$$ | | |
| \triangleq | $$\triangleq$$ | | |
| \trianglerighteq | $$\trianglerighteq$$ | | |
| \twoheadleftarrow | $$\twoheadleftarrow$$ | | |
| \twoheadrightarrow | $$\twoheadrightarrow$$ | | |
| \ulcorner | $$\ulcorner$$ | | |
| \unlhd | $$\unlhd$$ | | |
| \unrhd | $$\unrhd$$ | | |
| \upharpoonleft | $$\upharpoonleft$$ | | |
| \upharpoonright | $$\upharpoonright$$ | | |
| \upuparrows | $$\upuparrows$$ | | |
| \urcorner | $$\urcorner$$ | | |
| \varDelta | $$\varDelta$$ | | |
| \varGamma | $$\varGamma$$ | | |
| \varinjlim | $$\varinjlim$$ | | |
| \varinjlim | $$\varinjlim$$ | | |
| \varkappa | $$\varkappa$$ | | |
| \varLambda | $$\varLambda$$ | | |
| \varliminf | $$\varliminf$$ | | |
| \varlimsup | $$\varlimsup$$ | | |
| \varnothing | $$\varnothing$$ | | |
| \varOmega | $$\varOmega$$ | | |
| \varPhi | $$\varPhi$$ | | |
| \varPi | $$\varPi$$ | | |
| \varprojlim | $$\varprojlim$$ | | |
| \varpropto | $$\varpropto$$ | | |
| \varPsi | $$\varPsi$$ | | |
| \varSigma | $$\varSigma$$ | | |
| \varsubsetneq | $$\varsubsetneq$$ | | |
| \varsubsetneqq | $$\varsubsetneqq$$ | | |
| \varsupsetneq | $$\varsupsetneq$$ | | |
| \varsupsetneqq | $$\varsupsetneqq$$ | | |
| \varTheta | $$\varTheta$$ | | |
| \vartriangle | $$\vartriangle$$
| \vartriangleleft | $$\vartriangleleft$$ | | |
| \vartriangleright | $$\vartriangleright$$ | | |
| \varUpsilon | $$\varUpsilon$$ | | |
| \varXi | $$\varXi$$ | | |
| \vDash | $$\vDash$$ | | |
| \Vdash | $$\Vdash$$ | | |
| \veebar | $$\veebar$$ | | |
| \Vvdash | $$\Vvdash$$ | | |
| \xleftarrow{n+\mu-1} | $$\xleftarrow{n+\mu-1}$$
| \xrightarrow{n+\mu-1} | $$\xrightarrow{n+\mu-1}$$
| \yen | $$\yen$$ | | |
