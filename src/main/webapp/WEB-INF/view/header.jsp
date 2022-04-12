<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-180084260-1"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'UA-180084260-1');
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CalcLogic</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/img/bluemarine_favicon.ico" type="image/vnd.microsoft.icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
    <script src="${pageContext.request.contextPath}/static/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.2.1.min.js"></script>
    <!--  <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script> -->
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/desplegar.js"></script>

    <style>
mjx-chtml {display: inline-block; line-height: 0; text-indent: 0; text-align: left; text-transform: none; font-style: normal; font-weight: normal; font-size: 100%; font-size-adjust: none; letter-spacing: normal; word-wrap: normal; word-spacing: normal; white-space: nowrap; float: none; direction: ltr; max-width: none; max-height: none; min-width: 0; min-height: 0; border: 0; margin: 0; padding: 1px 0}
.MJXc-display {display: block; text-align: center; margin: 1em 0; padding: 0}
.mjx-chtml[tabindex]:focus, body :focus .mjx-chtml[tabindex] {display: inline-table}
.mjx-full-width {text-align: center; display: table-cell!important; width: 10000em}
.mjx-math {display: inline-block; border-collapse: separate; border-spacing: 0}
.mjx-math * {display: inline-block; -webkit-box-sizing: content-box!important; -moz-box-sizing: content-box!important; box-sizing: content-box!important; text-align: left}
.mjx-numerator {display: block; text-align: center}
.mjx-denominator {display: block; text-align: center}
.MJXc-stacked {height: 0; position: relative}
.MJXc-stacked > * {position: absolute}
.MJXc-bevelled > * {display: inline-block}
.mjx-stack {display: inline-block}
.mjx-op {display: block}
.mjx-under {display: table-cell}
.mjx-over {display: block}
.mjx-over > * {padding-left: 0px!important; padding-right: 0px!important}
.mjx-under > * {padding-left: 0px!important; padding-right: 0px!important}
.mjx-stack > .mjx-sup {display: block}
.mjx-stack > .mjx-sub {display: block}
.mjx-prestack > .mjx-presup {display: block}
.mjx-prestack > .mjx-presub {display: block}
.mjx-delim-h > .mjx-char {display: inline-block}
.mjx-surd {vertical-align: top}
.mjx-surd + .mjx-box {display: inline-flex}
.mjx-mphantom * {visibility: hidden}
.mjx-merror {background-color: #FFFF88; color: #CC0000; border: 1px solid #CC0000; padding: 2px 3px; font-style: normal; font-size: 90%}
.mjx-annotation-xml {line-height: normal}
.mjx-menclose > svg {fill: none; stroke: currentColor; overflow: visible}
.mjx-mtr {display: table-row}
.mjx-mlabeledtr {display: table-row}
.mjx-mtd {display: table-cell; text-align: center}
.mjx-label {display: table-row}
.mjx-box {display: inline-block}
.mjx-block {display: block}
.mjx-span {display: inline}
.mjx-char {display: block; white-space: pre}
.mjx-itable {display: inline-table; width: auto}
.mjx-row {display: table-row}
.mjx-cell {display: table-cell}
.mjx-table {display: table; width: 100%}
.mjx-line {display: block; height: 0}
.mjx-strut {width: 0; padding-top: 1em}
.mjx-vsize {width: 0}
.MJXc-space1 {margin-left: .167em}
.MJXc-space2 {margin-left: .222em}
.MJXc-space3 {margin-left: .278em}
.mjx-test.mjx-test-display {display: table!important}
.mjx-test.mjx-test-inline {display: inline!important; margin-right: -1px}
.mjx-test.mjx-test-default {display: block!important; clear: both}
.mjx-ex-box {display: inline-block!important; position: absolute; overflow: hidden; min-height: 0; max-height: none; padding: 0; border: 0; margin: 0; width: 1px; height: 60ex}
.mjx-test-inline .mjx-left-box {display: inline-block; width: 0; float: left}
.mjx-test-inline .mjx-right-box {display: inline-block; width: 0; float: right}
.mjx-test-display .mjx-right-box {display: table-cell!important; width: 10000em!important; min-width: 0; max-width: none; padding: 0; border: 0; margin: 0}
.MJXc-TeX-unknown-R {font-family: monospace; font-style: normal; font-weight: normal}
.MJXc-TeX-unknown-I {font-family: monospace; font-style: italic; font-weight: normal}
.MJXc-TeX-unknown-B {font-family: monospace; font-style: normal; font-weight: bold}
.MJXc-TeX-unknown-BI {font-family: monospace; font-style: italic; font-weight: bold}
.MJXc-TeX-ams-R {font-family: MJXc-TeX-ams-R,MJXc-TeX-ams-Rw}
.MJXc-TeX-cal-B {font-family: MJXc-TeX-cal-B,MJXc-TeX-cal-Bx,MJXc-TeX-cal-Bw}
.MJXc-TeX-frak-R {font-family: MJXc-TeX-frak-R,MJXc-TeX-frak-Rw}
.MJXc-TeX-frak-B {font-family: MJXc-TeX-frak-B,MJXc-TeX-frak-Bx,MJXc-TeX-frak-Bw}
.MJXc-TeX-math-BI {font-family: MJXc-TeX-math-BI,MJXc-TeX-math-BIx,MJXc-TeX-math-BIw}
.MJXc-TeX-sans-R {font-family: MJXc-TeX-sans-R,MJXc-TeX-sans-Rw}
.MJXc-TeX-sans-B {font-family: MJXc-TeX-sans-B,MJXc-TeX-sans-Bx,MJXc-TeX-sans-Bw}
.MJXc-TeX-sans-I {font-family: MJXc-TeX-sans-I,MJXc-TeX-sans-Ix,MJXc-TeX-sans-Iw}
.MJXc-TeX-script-R {font-family: MJXc-TeX-script-R,MJXc-TeX-script-Rw}
.MJXc-TeX-type-R {font-family: MJXc-TeX-type-R,MJXc-TeX-type-Rw}
.MJXc-TeX-cal-R {font-family: MJXc-TeX-cal-R,MJXc-TeX-cal-Rw}
.MJXc-TeX-main-B {font-family: MJXc-TeX-main-B,MJXc-TeX-main-Bx,MJXc-TeX-main-Bw}
.MJXc-TeX-main-I {font-family: MJXc-TeX-main-I,MJXc-TeX-main-Ix,MJXc-TeX-main-Iw}
.MJXc-TeX-main-R {font-family: MJXc-TeX-main-R,MJXc-TeX-main-Rw}
.MJXc-TeX-math-I {font-family: MJXc-TeX-math-I,MJXc-TeX-math-Ix,MJXc-TeX-math-Iw}
.MJXc-TeX-size1-R {font-family: MJXc-TeX-size1-R,MJXc-TeX-size1-Rw}
.MJXc-TeX-size2-R {font-family: MJXc-TeX-size2-R,MJXc-TeX-size2-Rw}
.MJXc-TeX-size3-R {font-family: MJXc-TeX-size3-R,MJXc-TeX-size3-Rw}
.MJXc-TeX-size4-R {font-family: MJXc-TeX-size4-R,MJXc-TeX-size4-Rw}
.MJXc-TeX-vec-R {font-family: MJXc-TeX-vec-R,MJXc-TeX-vec-Rw}
.MJXc-TeX-vec-B {font-family: MJXc-TeX-vec-B,MJXc-TeX-vec-Bx,MJXc-TeX-vec-Bw}
@font-face {font-family: MJXc-TeX-ams-R; src: local('MathJax_AMS'), local('MathJax_AMS-Regular')}
@font-face {font-family: MJXc-TeX-ams-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_AMS-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_AMS-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_AMS-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-cal-B; src: local('MathJax_Caligraphic Bold'), local('MathJax_Caligraphic-Bold')}
@font-face {font-family: MJXc-TeX-cal-Bx; src: local('MathJax_Caligraphic'); font-weight: bold}
@font-face {font-family: MJXc-TeX-cal-Bw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Caligraphic-Bold.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Caligraphic-Bold.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Caligraphic-Bold.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-frak-R; src: local('MathJax_Fraktur'), local('MathJax_Fraktur-Regular')}
@font-face {font-family: MJXc-TeX-frak-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Fraktur-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Fraktur-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Fraktur-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-frak-B; src: local('MathJax_Fraktur Bold'), local('MathJax_Fraktur-Bold')}
@font-face {font-family: MJXc-TeX-frak-Bx; src: local('MathJax_Fraktur'); font-weight: bold}
@font-face {font-family: MJXc-TeX-frak-Bw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Fraktur-Bold.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Fraktur-Bold.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Fraktur-Bold.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-math-BI; src: local('MathJax_Math BoldItalic'), local('MathJax_Math-BoldItalic')}
@font-face {font-family: MJXc-TeX-math-BIx; src: local('MathJax_Math'); font-weight: bold; font-style: italic}
@font-face {font-family: MJXc-TeX-math-BIw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Math-BoldItalic.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Math-BoldItalic.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Math-BoldItalic.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-sans-R; src: local('MathJax_SansSerif'), local('MathJax_SansSerif-Regular')}
@font-face {font-family: MJXc-TeX-sans-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_SansSerif-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_SansSerif-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_SansSerif-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-sans-B; src: local('MathJax_SansSerif Bold'), local('MathJax_SansSerif-Bold')}
@font-face {font-family: MJXc-TeX-sans-Bx; src: local('MathJax_SansSerif'); font-weight: bold}
@font-face {font-family: MJXc-TeX-sans-Bw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_SansSerif-Bold.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_SansSerif-Bold.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_SansSerif-Bold.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-sans-I; src: local('MathJax_SansSerif Italic'), local('MathJax_SansSerif-Italic')}
@font-face {font-family: MJXc-TeX-sans-Ix; src: local('MathJax_SansSerif'); font-style: italic}
@font-face {font-family: MJXc-TeX-sans-Iw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_SansSerif-Italic.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_SansSerif-Italic.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_SansSerif-Italic.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-script-R; src: local('MathJax_Script'), local('MathJax_Script-Regular')}
@font-face {font-family: MJXc-TeX-script-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Script-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Script-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Script-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-type-R; src: local('MathJax_Typewriter'), local('MathJax_Typewriter-Regular')}
@font-face {font-family: MJXc-TeX-type-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Typewriter-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Typewriter-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Typewriter-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-cal-R; src: local('MathJax_Caligraphic'), local('MathJax_Caligraphic-Regular')}
@font-face {font-family: MJXc-TeX-cal-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Caligraphic-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Caligraphic-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Caligraphic-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-main-B; src: local('MathJax_Main Bold'), local('MathJax_Main-Bold')}
@font-face {font-family: MJXc-TeX-main-Bx; src: local('MathJax_Main'); font-weight: bold}
@font-face {font-family: MJXc-TeX-main-Bw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Main-Bold.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Main-Bold.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Main-Bold.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-main-I; src: local('MathJax_Main Italic'), local('MathJax_Main-Italic')}
@font-face {font-family: MJXc-TeX-main-Ix; src: local('MathJax_Main'); font-style: italic}
@font-face {font-family: MJXc-TeX-main-Iw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Main-Italic.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Main-Italic.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Main-Italic.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-main-R; src: local('MathJax_Main'), local('MathJax_Main-Regular')}
@font-face {font-family: MJXc-TeX-main-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Main-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Main-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Main-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-math-I; src: local('MathJax_Math Italic'), local('MathJax_Math-Italic')}
@font-face {font-family: MJXc-TeX-math-Ix; src: local('MathJax_Math'); font-style: italic}
@font-face {font-family: MJXc-TeX-math-Iw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Math-Italic.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Math-Italic.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Math-Italic.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-size1-R; src: local('MathJax_Size1'), local('MathJax_Size1-Regular')}
@font-face {font-family: MJXc-TeX-size1-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Size1-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Size1-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Size1-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-size2-R; src: local('MathJax_Size2'), local('MathJax_Size2-Regular')}
@font-face {font-family: MJXc-TeX-size2-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Size2-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Size2-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Size2-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-size3-R; src: local('MathJax_Size3'), local('MathJax_Size3-Regular')}
@font-face {font-family: MJXc-TeX-size3-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Size3-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Size3-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Size3-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-size4-R; src: local('MathJax_Size4'), local('MathJax_Size4-Regular')}
@font-face {font-family: MJXc-TeX-size4-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Size4-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Size4-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Size4-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-vec-R; src: local('MathJax_Vector'), local('MathJax_Vector-Regular')}
@font-face {font-family: MJXc-TeX-vec-Rw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Vector-Regular.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Vector-Regular.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Vector-Regular.otf') format('opentype')}
@font-face {font-family: MJXc-TeX-vec-B; src: local('MathJax_Vector Bold'), local('MathJax_Vector-Bold')}
@font-face {font-family: MJXc-TeX-vec-Bx; src: local('MathJax_Vector'); font-weight: bold}
@font-face {font-family: MJXc-TeX-vec-Bw; src /*1*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/eot/MathJax_Vector-Bold.eot'); src /*2*/: url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/woff/MathJax_Vector-Bold.woff') format('woff'), url('https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/fonts/HTML-CSS/TeX/otf/MathJax_Vector-Bold.otf') format('opentype')}
    </style>

    <c:choose>
        <c:when test='${!perfilMenu.equals("active")}'> <!-- Here we exclude the views which we don't want to import these configurations-->
            <script type="text/x-mathjax-config">
                MathJax.Hub.Config({
                    //extensions: ["tex2jax.js","[MathJax]/extensions/TeX/forminput.js"], // For version 2.3
                    extensions: ["tex2jax.js","[Contrib]/forminput/forminput.js"], // For version 2.7.7
                    jax: ["input/TeX","output/HTML-CSS"],
                    tex2jax: {inlineMath: [ ['$','$'], ["\\(","\\)"] ],processEscapes: true,},
                    TeX: {extensions: ["AMSmath.js","AMSsymbols.js"]}
                });
            </script>
            <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/latest.js?config=TeX-MML-AM_CHTML"></script>
           <!--  <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/mathjax-MathJax-v2.3-248-g60e0a8c/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script> -->
            <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/ClickOnAlias.js"></script>
            <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/inferAjax.js"></script>
            <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/limpiar.js"></script>
        </c:when>
    </c:choose>
    <c:choose>
        <c:when test='${misTeoremasMenu.equals("active")}'>
            <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/buscarSoluciones.js"></script>
            <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/expandMeta.js"></script>
            <c:choose>
                <c:when test="${showCategorias.size() == 0}">
                    <script>
                        $(document).ready(function(){$("#exampleModal").modal('show');});
                    </script>
                </c:when>
            </c:choose>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css">
        </c:when>
    </c:choose>
    <!--<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >-->
</head>