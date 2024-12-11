---
title: Integers
author: Claudio Corsi
tags: [ number theory, elementary number theory, integers ]
permalink: /math/number/elementary/integers.htm
debug: true
sidebar: math-number-elementary-integers
chapter: 1
---

This section will deal specifically with integers within the context of elementary number theory.  I will start with a
definition of what are integers.

{% assign caption="Integers" %}
{% capture body %}Integers are defined as the set
    $$\mathbb{Z} = \{...,-2,-1,0,1,2,...\}$$
{% endcapture %}

{% include definition.html content=body %}

Now that we have a definition of what integers are.  We can look at some other definitions.

{% assign caption="Least-Integer Principle" %}
{% capture body %}A nonempty set of integers that is bounded below contains a smallest element.
{% endcapture %}

{% include definition.html content=body %}

An example of such a set is $$X \colon= \{x \in \mathbb{Z} \mid x > 1\}$$.

{% assign caption="Greatest-Integer Principle" %}
{% capture body %}A nonempty set of integers that is bounded above contains a largest element.
{% endcapture %}

{% include definition.html content=body %}

An example of such a set is $$Y \colon= \{y \in \mathbb{Z} \mid y < 1\}$$.

{% assign caption=nil %}
{% capture body %}We say that <b>a</b> divides <b>b</b> (written \(a \mid b\)) if and only if there is an integer
<b>d</b> such that <b>ad</b> = <b>b</b>.
{% endcapture %}

{% include definition.html content=body %}

The above definition pertains to a combination of numbers that are divisible.  I can also start that is <b>a</b> does
not divide <b>b</b> then we can state this as $$a \nmid b$$.

Now that I have defined some elementary definitions above.  We can start by looking at proving the following.

{% capture body %}If \(a \mid b\) and \(b \mid c\) then \(a \mid c\).
{% endcapture %}

{% capture proof %}From the definition we know that there exists a <b>q</b> and <b>r</b> such that <b>aq = b</b> and <b>br = c</b>.  Thus we can then state that <b>aqr = br</b>.  We can then replace <b>qr</b> with <b>s</b> and <b>br</b> with <b>c</b>.  We then have <b>as = c</b> which implies that \(a \mid c\).
{% endcapture %}

{% include theorem.html content=body proof=proof %}

We can then use the above information to prove the following

{% capture body %}If \(d \mid a\) and \(d \mid b\), then \(d \mid (a + b)\).{% endcapture %}

{% capture proof %}From the definition, we know that there are integers <b>q</b> and  <b>r</b> such that
    $$dq = a$$ $$\text{ and }$$ $$dr = b.$$
Thus
    $$a + b = d(q + r),$$
so from the definition again, \(d \mid (a + b)\).
{% endcapture %}

{% include lemma.html content=body proof=proof %}

In the same way, we can prove

{% capture body %}If \(d \mid a_1, d \mid a_2, \dots d \mid a_n\), then \(d \mid (c_1a_1 + c_2a_2 + \dots + c_na_n)\) for any integers \(c_1,c_2, \dots c_n\).
{% endcapture %}

{% capture proof %}From the definition, there are integers \(q_1, q_2, \dots, q_n\) such that \(a_1 = dq_1, a_2 = dq_2,
\dots, a_n = dq_n\). Thus
$$c_1a_1 + c_2a_2 + \dots + c_nq_n,$$
and from the definition again, \(d \mid c_1a_1 + c_2a_2 + \dots + c_na_n\).
{% endcapture %}

{% include lemma.html content=body proof=proof %}

Let us look at an example of how we can use the above lemma.  Let us then see if it is possible to have 100 coins, made
up of <em>c</em> pennies, <em>d</em> dimes and <em>q</em> quaters, be worth $5.00.  Thus,

$$c + d + q = 100$$

$$\text{and}$$

$$c + 10d + 25q = 500$$

We can do the following:

$$c + 10d + 25q - (c + d + q) = 500 - 100$$

which gives

$$9d + 24q = 400$$

Since $$3 \mid 9$$ and $$3 \mid 24$$ the above lemma says that $$3 \mid 9d + 24q$$ which implies that $$3 \mid 400$$
which is impossible since 3 isn't a factor of 400.

{% capture body %}If \(d \mid a\) then \(d \mid ca\) for any integer <em>c</em>.{% endcapture %}

{% capture proof %}From the definition, there are integers....
{% endcapture %}

{% include lemma.html content=body proof=proof %}

{% comment %}
\approxeq = $$\approxeq$$

\backepsilon = $$\backepsilon$$

\backprime = $$\backprime$$

\backsim = $$\backsim$$

\backsimeq = $$\backsimeq$$

\barwedge = $$\barwedge$$

\Bbbk = $$\Bbbk$$

\because = $$\because$$

\beth = $$\beth$$

\between = $$\between$$

\bigstar = $$\bigstar$$

\binom{k}{1} = $$\binom{k}{1}$$

\blacklozenge = $$\blacklozenge$$

\blacksquare = $$\blacksquare$$

\blacktriangle = $$\blacktriangle$$

\blacktriangledown = $$\blacktriangledown$$

\blacktriangleleft = $$\blacktriangleleft$$

\blacktriangleright = $$\blacktriangleright$$

\Box = $$\Box$$

\boxdot = $$\boxdot$$

\boxed{\eta \leq C(\delta(\eta) +\Lambda_M(0,\delta))} = $$\boxed{\eta \leq C(\delta(\eta) +\Lambda_M(0,\delta))}$$

\boxminus = $$\boxminus$$

\boxplus = $$\boxplus$$

\boxtimes = $$\boxtimes$$

\bumpeq = $$\bumpeq$$

\Bumpeq = $$\Bumpeq$$

\Cap = $$\Cap$$

\centerdot = $$\centerdot$$

\cfrac{1}{\sqrt{2}+ \cfrac{1}{\sqrt{2}+ \cfrac{1}{\sqrt{2}+\dotsb }}} = $$\cfrac{1}{\sqrt{2}+ \cfrac{1}{\sqrt{2}+ \cfrac{1}{\sqrt{2}+\dotsb }}}$$

\checkmark = $$\checkmark$$

\circeq = $$\circeq$$

\circlearrowleft = $$\circlearrowleft$$

\circlearrowright = $$\circlearrowright$$

\circledast = $$\circledast$$

\circledcirc = $$\circledcirc$$

\circleddash = $$\circleddash$$

\circledR = $$\circledR$$

\circledS = $$\circledS$$

\complement = $$\complement$$

\Cup = $$\Cup$$

\curlyeqprec = $$\curlyeqprec$$

\curlyeqsucc = $$\curlyeqsucc$$

\curlyvee = $$\curlyvee$$

\curlywedge = $$\curlywedge$$

\curvearrowleft = $$\curvearrowleft$$

\curvearrowright = $$\curvearrowright$$

\daleth = $$\daleth$$

\dashleftarrow = $$\dashleftarrow$$

\dashrightarrow = $$\dashrightarrow$$

\dbinom{k}{n} = $$\dbinom{k}{n}$$

\ddddot{1} = $$\ddddot{1}$$

\dddot{1} = $$\dddot{1}$$

\DeclareMathOperator{\Lim}{Lim} = $$\DeclareMathOperator{\Lim}{Lim}$$

\dfrac{1}{2} = $$\dfrac{1}{2}$$

\diagdown = $$\diagdown$$

\diagup = $$\diagup$$

\Diamond = $$\Diamond$$

\digamma = $$\digamma$$

\divideontimes = $$\divideontimes$$

\Doteq = $$\Doteq$$

\doteqdot = $$\doteqdot$$

\dotplus = $$\dotplus$$

\doublebarwedge = $$\doublebarwedge$$

\doublecap = $$\doublecap$$

\doublecup = $$\doublecup$$

\downdownarrows = $$\downdownarrows$$

\downharpoonleft = $$\downharpoonleft$$

\downharpoonright = $$\downharpoonright$$

\eqcirc = $$\eqcirc$$

\eqref = $$\eqref{}$$

\eqsim = $$\eqsim$$

\eqslantgtr = $$\eqslantgtr$$

\eqslantless = $$\eqslantless$$

\eth = $$\eth$$

\fallingdotseq = $$\fallingdotseq$$

\Finv = $$\Finv$$

\frac{1}{3} = $$\frac{1}{3}$$

\Game = $$\Game$$

\genfrac{}{}{}{}{#1}{#2} = $$\genfrac{}{}{}{}{#1}{#2}$$

\geqq = $$\geqq$$

\geqslant = $$\geqslant$$

\ggg = $$\ggg$$

\gggtr = $$\gggtr$$

\gimel = $$\gimel$$

\gnapprox = $$\gnapprox$$

\gneq = $$\gneq$$

\gneqq = $$\gneqq$$

\gnsim = $$\gnsim$$

\gtrapprox = $$\gtrapprox$$

\gtrdot = $$\gtrdot$$

\gtreqless = $$\gtreqless$$

\gtreqqless = $$\gtreqqless$$

\gtrless = $$\gtrless$$

\gtrsim = $$\gtrsim$$

\gvertneqq = $$\gvertneqq$$

\hslash = $$\hslash$$

\idotsint = $$\idotsint$$

\iiiint = $$\iiiint$$

\impliedby = $$\impliedby$$

\implies = $$\implies$$

\injlim = $$\injlim$$

\intercal = $$\intercal$$

\gtreqqless = $$\gtreqqless$$

\gtrless = $$\gtrless$$

\gtrsim = $$\gtrsim$$

\gvertneqq = $$\gvertneqq$$

\hslash = $$\hslash$$

\idotsint = $$\idotsint$$

\iiiint = $$\iiiint$$

\impliedby = $$\impliedby$$

\implies = $$\implies$$

\injlim = $$\injlim$$

\intercal = $$\intercal$$

\Join = $$\Join$$

\leadsto = $$\leadsto$$

\leftarrowtail = $$\leftarrowtail$$

\leftleftarrows = $$\leftleftarrows$$

\leftrightarrows = $$\leftrightarrows$$

\leftrightharpoons = $$\leftrightharpoons$$

\leftrightsquigarrow = $$\leftrightsquigarrow$$

\Join = $$\Join$$

\leadsto = $$\leadsto$$

\leftarrowtail = $$\leftarrowtail$$

\leftleftarrows = $$\leftleftarrows$$

\leftrightarrows = $$\leftrightarrows$$

\leftrightharpoons = $$\leftrightharpoons$$

\leftrightsquigarrow = $$\leftrightsquigarrow$$

\leftthreetimes = $$\leftthreetimes$$

\leqq = $$\leqq$$

\leqslant = $$\leqslant$$

\lessapprox = $$\lessapprox$$

\lessdot = $$\lessdot$$

\lesseqgtr = $$\lesseqgtr$$

\lesseqqgtr = $$\lesseqqgtr$$

\lessgtr = $$\lessgtr$$

\lesssim = $$\lesssim$$

\lhd = $$\lhd$$

\llcorner = $$\llcorner$$

\leftthreetimes = $$\leftthreetimes$$

\leqq = $$\leqq$$

\leqslant = $$\leqslant$$

\lessapprox = $$\lessapprox$$

\lessdot = $$\lessdot$$

\lesseqgtr = $$\lesseqgtr$$

\lesseqqgtr = $$\lesseqqgtr$$

\lessgtr = $$\lessgtr$$

\lesssim = $$\lesssim$$

\lhd = $$\lhd$$

\llcorner = $$\llcorner$$

\Lleftarrow = $$\Lleftarrow$$

\lll = $$\lll$$

\llless = $$\llless$$

\lnapprox = $$\lnapprox$$

\lneq = $$\lneq$$

\lneqq = $$\lneqq$$

\lnsim = $$\lnsim$$

\looparrowleft = $$\looparrowleft$$

\looparrowright = $$\looparrowright$$

\lozenge = $$\lozenge$$

\lrcorner = $$\lrcorner$$

\Lleftarrow = $$\Lleftarrow$$

\lll = $$\lll$$

\llless = $$\llless$$

\lnapprox = $$\lnapprox$$

\lneq = $$\lneq$$

\lneqq = $$\lneqq$$

\lnsim = $$\lnsim$$

\looparrowleft = $$\looparrowleft$$

\looparrowright = $$\looparrowright$$

\lozenge = $$\lozenge$$

\lrcorner = $$\lrcorner$$

\Lsh = $$\Lsh$$

\ltimes = $$\ltimes$$

\lvert = $$\lvert$$

\lVert = $$\lVert$$

\lvertneqq = $$\lvertneqq$$

\maltese = $$\maltese$$

\mathring = $$\mathring$$

\measuredangle = $$\measuredangle$$

\mho = $$\mho$$

\multimap = $$\multimap$$

\ncong = $$\ncong$$

\negmedspace = $$\negmedspace$$

\negthickspace = $$\negthickspace$$

\nexists = $$\nexists$$

\ngeq = $$\ngeq$$

\ngeqq = $$\ngeqq$$

\ngeqslant = $$\ngeqslant$$

\ngtr = $$\ngtr$$

\nleftarrow = $$\nleftarrow$$

\nLeftarrow = $$\nLeftarrow$$

\nleftrightarrow = $$\nleftrightarrow$$

\negthickspace = $$\negthickspace$$

\nexists = $$\nexists$$

\ngeq = $$\ngeq$$

\ngeqq = $$\ngeqq$$

\ngeqslant = $$\ngeqslant$$

\ngtr = $$\ngtr$$

\nleftarrow = $$\nleftarrow$$

\nLeftarrow = $$\nLeftarrow$$

\nleftrightarrow = $$\nleftrightarrow$$

\nLeftrightarrow = $$\nLeftrightarrow$$

\nleq = $$\nleq$$

\nleqq = $$\nleqq$$

\nleqslant = $$\nleqslant$$

\nless = $$\nless$$

\nmid = $$\nmid$$

\nobreakspace = $$\nobreakspace$$

\notag = $$\notag$$

\nparallel = $$\nparallel$$

\nprec = $$\nprec$$

\npreceq = $$\npreceq$$

\nLeftrightarrow = $$\nLeftrightarrow$$

\nleq = $$\nleq$$

\nleqq = $$\nleqq$$

\nleqslant = $$\nleqslant$$

\nless = $$\nless$$

\nmid = $$\nmid$$

\nobreakspace = $$\nobreakspace$$

\notag = $$\notag$$

\nparallel = $$\nparallel$$

\nprec = $$\nprec$$

\npreceq = $$\npreceq$$

\nrightarrow = $$\nrightarrow$$

\nRightarrow = $$\nRightarrow$$

\nshortmid = $$\nshortmid$$

\nshortparallel = $$\nshortparallel$$

\nsim = $$\nsim$$

\nsubseteq = $$\nsubseteq$$

\nsubseteqq = $$\nsubseteqq$$

\nsucc = $$\nsucc$$

\nsucceq = $$\nsucceq$$

\nsupseteq = $$\nsupseteq$$

\nrightarrow = $$\nrightarrow$$

\nRightarrow = $$\nRightarrow$$

\nshortmid = $$\nshortmid$$

\nshortparallel = $$\nshortparallel$$

\nsim = $$\nsim$$

\nsubseteq = $$\nsubseteq$$

\nsubseteqq = $$\nsubseteqq$$

\nsucc = $$\nsucc$$

\nsucceq = $$\nsucceq$$

\nsupseteq = $$\nsupseteq$$

\nsupseteqq = $$\nsupseteqq$$

\ntriangleleft = $$\ntriangleleft$$

\ntrianglelefteq = $$\ntrianglelefteq$$

\ntriangleright = $$\ntriangleright$$

\ntrianglerighteq = $$\ntrianglerighteq$$

\nvdash = $$\nvdash$$

\nvDash = $$\nvDash$$

\nVdash = $$\nVdash$$

\nVDash = $$\nVDash$$

\nsupseteqq = $$\nsupseteqq$$

\ntriangleleft = $$\ntriangleleft$$

\ntrianglelefteq = $$\ntrianglelefteq$$

\ntriangleright = $$\ntriangleright$$

\ntrianglerighteq = $$\ntrianglerighteq$$

\nvdash = $$\nvdash$$

\nvDash = $$\nvDash$$

\nVdash = $$\nVdash$$

\nVDash = $$\nVDash$$

\operatorname{abc} = $$\operatorname{abc}$$

\pitchfork = $$\pitchfork$$

\precapprox = $$\precapprox$$

\preccurlyeq = $$\preccurlyeq$$

\precnapprox = $$\precnapprox$$

\precneqq = $$\precneqq$$

\precnsim = $$\precnsim$$

\precsim = $$\precsim$$

\projlim = $$\projlim$$

\operatorname = $$\operatorname$$

\pitchfork = $$\pitchfork$$

\precapprox = $$\precapprox$$

\preccurlyeq = $$\preccurlyeq$$

\precnapprox = $$\precnapprox$$

\precneqq = $$\precneqq$$

\precnsim = $$\precnsim$$

\precsim = $$\precsim$$

\projlim = $$\projlim$$

\restriction = $$\restriction$$

\rhd = $$\rhd$$

\rightarrowtail = $$\rightarrowtail$$

\rightleftarrows = $$\rightleftarrows$$

\rightleftharpoons = $$\rightleftharpoons$$

\rightrightarrows = $$\rightrightarrows$$

\rightsquigarrow = $$\rightsquigarrow$$

\restriction = $$\restriction$$

\rhd = $$\rhd$$

\rightarrowtail = $$\rightarrowtail$$

\rightleftarrows = $$\rightleftarrows$$

\rightleftharpoons = $$\rightleftharpoons$$

\rightrightarrows = $$\rightrightarrows$$

\rightsquigarrow = $$\rightsquigarrow$$

\rightthreetimes = $$\rightthreetimes$$

\risingdotseq = $$\risingdotseq$$

\Rrightarrow = $$\Rrightarrow$$

\Rsh = $$\Rsh$$

\rtimes = $$\rtimes$$

\rvert = $$\rvert$$

\rVert = $$\rVert$$

\shortmid = $$\shortmid$$

\shortparallel = $$\shortparallel$$

\shoveleft{\mid} = $$\shoveleft{\mid}$$

\shoveright{\mid} = $$\shoveright{\mid}$$

\sideset{_*^*}{_*^*}\prod = $$\sideset{_*^*}{_*^*}\prod $$

\sideset{}{’} \sum_{n<k,\;\text{$n$ odd}} nE_n = $$\sideset{}{’} \sum_{n<k,\;\text{$n$ odd}} nE_n$$

\sideset{}{*} A = $$\sideset{}{*} A$$

\SkipLimits = $$\SkipLimits$$

\smallfrown = $$\smallfrown$$

\smallsetminus = $$\smallsetminus$$

\smallsmile = $$\smallsmile$$

\sphericalangle = $$\sphericalangle$$

\sqsubset = $$\sqsubset$$

\sqsupset = $$\sqsupset$$

\square = $$\square$$

\Subset = $$\Subset$$

\subseteqq = $$\subseteqq$$

\subsetneq = $$\subsetneq$$

\subsetneqq = $$\subsetneqq$$

\sum_{\substack{ 0\le i\le m\\ 0<j<n}} P(i,j) = $$\sum_{\substack{ 0\le i\le m\\ 0<j<n}} P(i,j)$$

\succapprox = $$\succapprox$$

\succcurlyeq = $$\succcurlyeq$$

\succnapprox = $$\succnapprox$$

\succneqq = $$\succneqq$$

\succnsim = $$\succnsim$$

\succsim = $$\succsim$$

\Supset = $$\Supset$$

\supseteqq = $$\supseteqq$$

\supsetneq = $$\supsetneq$$

\supsetneqq = $$\supsetneqq$$

\tag{$*$} = $$\tag{$*$}$$

\tbinom{k}{n} = $$\tbinom{k}{n}$$

\tfrac{k}{n} = $$\tfrac{k}{n}$$

\therefore = $$\therefore$$

\thickapprox = $$\thickapprox$$

\thicksim = $$\thicksim$$

\triangledown = $$\triangledown$$

\trianglelefteq = $$\trianglelefteq$$

\triangleq = $$\triangleq$$

\trianglerighteq = $$\trianglerighteq$$

\twoheadleftarrow = $$\twoheadleftarrow$$

\twoheadrightarrow = $$\twoheadrightarrow$$

\thicksim = $$\thicksim$$

\triangledown = $$\triangledown$$

\trianglelefteq = $$\trianglelefteq$$

\triangleq = $$\triangleq$$

\trianglerighteq = $$\trianglerighteq$$

\twoheadleftarrow = $$\twoheadleftarrow$$

\twoheadrightarrow = $$\twoheadrightarrow$$

\ulcorner = $$\ulcorner$$

\unlhd = $$\unlhd$$

\unrhd = $$\unrhd$$

\upharpoonleft = $$\upharpoonleft$$

\upharpoonright = $$\upharpoonright$$

\upuparrows = $$\upuparrows$$

\urcorner = $$\urcorner$$

\varDelta = $$\varDelta$$

\varGamma = $$\varGamma$$

\varinjlim = $$\varinjlim$$

\varinjlim = $$\varinjlim$$

\varkappa = $$\varkappa$$

\varLambda = $$\varLambda$$

\varliminf = $$\varliminf$$

\varlimsup = $$\varlimsup$$

\varnothing = $$\varnothing$$

\varOmega = $$\varOmega$$

\varPhi = $$\varPhi$$

\varPi = $$\varPi$$

\varprojlim = $$\varprojlim$$

\varpropto = $$\varpropto$$

\varkappa = $$\varkappa$$

\varLambda = $$\varLambda$$

\varliminf = $$\varliminf$$

\varlimsup = $$\varlimsup$$

\varnothing = $$\varnothing$$

\varOmega = $$\varOmega$$

\varPhi = $$\varPhi$$

\varPi = $$\varPi$$

\varprojlim = $$\varprojlim$$

\varpropto = $$\varpropto$$

\varPsi = $$\varPsi$$

\varSigma = $$\varSigma$$

\varsubsetneq = $$\varsubsetneq$$

\varsubsetneqq = $$\varsubsetneqq$$

\varsupsetneq = $$\varsupsetneq$$

\varsupsetneqq = $$\varsupsetneqq$$

\varTheta = $$\varTheta$$

\vartriangle = $$\varPsi = $$\vartriangle = $$\varPsi$$

\varSigma = $$\varSigma$$

\varsubsetneq = $$\varsubsetneq$$

\varsubsetneqq = $$\varsubsetneqq$$

\varsupsetneq = $$\varsupsetneq$$

\varsupsetneqq = $$\varsupsetneqq$$

\varTheta = $$\varTheta$$

\vartriangle = $$\vartriangle$$

\vartriangleleft = $$\vartriangleleft$$

\vartriangleright = $$\vartriangleright$$

\varUpsilon = $$\varUpsilon$$

\varXi = $$\varXi$$

\vDash = $$\vDash$$

\Vdash = $$\Vdash$$

\veebar = $$\veebar$$

\Vvdash = $$\Vvdash$$

\xleftarrow{n+\mu-1} = $$\xleftarrow{n+\mu-1}$$

\xrightarrow{n+\mu-1} = $$\xrightarrow{n+\mu-1}$$

\yen = $$\yen$$
{% endcomment %}
