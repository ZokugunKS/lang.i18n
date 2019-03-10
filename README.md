[@zokugun/lang.i18n](https://github.com/ZokugunKS/lang.i18n)
==========================================================================

[![kaoscript](https://img.shields.io/badge/language-kaoscript-orange.svg)](https://github.com/kaoscript/kaoscript)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)
[![NPM Version](https://img.shields.io/npm/v/@zokugun/lang.i18n.svg?colorB=green)](https://www.npmjs.com/package/@zokugun/lang.i18n)
[![Dependency Status](https://badges.depfu.com/badges/75bfc2de208bfb5854ca2d3cc61330a7/overview.svg)](https://depfu.com/github/ZokugunKS/lang.i18n)
[![Build Status](https://travis-ci.org/ZokugunKS/lang.i18n.svg?branch=master)](https://travis-ci.org/ZokugunKS/lang.i18n)
[![CircleCI](https://circleci.com/gh/ZokugunKS/lang.i18n/tree/master.svg?style=shield)](https://circleci.com/gh/ZokugunKS/lang.i18n/tree/master)
[![Coverage Status](https://img.shields.io/coveralls/ZokugunKS/lang.i18n/master.svg)](https://coveralls.io/github/ZokugunKS/lang.i18n)

Provides internationalization tools

Getting Started
---------------

### In Node.js

With [node](http://nodejs.org) previously installed:

	npm install @zokugun/lang.i18n

Use it with `kaoscript`:

```kaoscript
import '@zokugun/lang.i18n'
import '@zokugun/lang.i18n.number.fr'(i18n)

i18n.culture('fr')

console.log(i18n.format(3.141592, 'N3'))
```

License
-------

[MIT](http://www.opensource.org/licenses/mit-license.php) &copy; Baptiste Augrain