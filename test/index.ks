#![bin]

extern {
	beforeEach:	func
	describe:	func
	it:			func
	console
}

import {
	'@zokugun/lang/src/dictionary/merge'
	'chai'		for expect
	'..'
}

describe('i18n', func() {
	beforeEach(func() { // {{{
		i18n.reset()
    }) // }}}

	it('get', func() { // {{{
		const value = i18n.getCulture()

		expect(value).to.be.an('object')
		expect(value.name).to.equal('und')
	}) // }}}

	it('set', func() { // {{{
		expect(i18n.getCulture('fr')).to.eql({
			name: 'und'
		})
	}) // }}}

	it('addCultureData - en-US,en-GB', func() { // {{{
		i18n.addCultureData('en-GB', {})

		i18n.addCultureData('en-US', {})

		expect(i18n.getCulture('en-GB')).to.eql({
			name: 'en-GB'
		})

		let value = i18n.getCulture()

		expect(value).to.be.an('object')
		expect(value.name).to.equal('und')

		expect(i18n.getCulture('en-US')).to.eql({
			name: 'en-US'
		})

		value = i18n.getCulture()

		expect(value).to.be.an('object')
		expect(value.name).to.equal('und')

		i18n.setCulture('en-GB')

		value = i18n.getCulture()

		expect(value).to.be.an('object')
		expect(value.name).to.equal('en-GB')
	}) // }}}

	it('addCultureData - fr-FR', func() { // {{{
		i18n.addCultureData('fr-FR', {})

		expect(i18n.getCulture('fr')).to.eql({
			name: 'fr'
		})
	}) // }}}

	it('getCulture - en-US,en', func() { // {{{
		expect(i18n.getCulture('en-US', 'en')).to.eql({
			name: 'und'
		})
	}) // }}}

	it('getCulture - fr', func() { // {{{
		expect(i18n.getCulture('fr')).to.eql({
			name: 'und'
		})
	}) // }}}

	it('isCulture', func() { // {{{
		expect(i18n.isCulture('fr')).to.be.true
		expect(i18n.isCulture('en-US')).to.be.true
		expect(i18n.isCulture('xxx')).to.be.false
	}) // }}}

	it('addExtension - number', func() { // {{{
		i18n.addExtension('number', {
			decimalSeparator: '.'
			groupSeparator: ','
			listSeparator: ';'
			percentSymbol: '%'
			plusSymbol: '+'
			minusSymbol: '-'
			exponentialSymbol: 'E'
			superScriptingExponent: '×'
			perMilleSymbol: '‰'
			infinitySymbol: '∞'
			nanSymbol: 'NaN'
			timeSeparator: ':'
        }, (...data) => Dictionary.merge(...data))

		expect(i18n.getCulture().number).to.eql({
			decimalSeparator: '.'
			groupSeparator: ','
			listSeparator: ';'
			percentSymbol: '%'
			plusSymbol: '+'
			minusSymbol: '-'
			exponentialSymbol: 'E'
			superScriptingExponent: '×'
			perMilleSymbol: '‰'
			infinitySymbol: '∞'
			nanSymbol: 'NaN'
			timeSeparator: ':'
		})
	}) // }}}

	it('getExtension - date', func() { // {{{
		expect(i18n.getCulture().date).to.not.exist
	}) // }}}

	it('addExtension - addCulture', func() { // {{{
		i18n.addExtension('number', {
			decimalSeparator: '.'
			groupSeparator: ','
			listSeparator: ';'
			percentSymbol: '%'
			plusSymbol: '+'
			minusSymbol: '-'
			exponentialSymbol: 'E'
			superScriptingExponent: '×'
			perMilleSymbol: '‰'
			infinitySymbol: '∞'
			nanSymbol: 'NaN'
			timeSeparator: ':'
        }, (...data) => Dictionary.merge({}, ...data))

		i18n.addCultureData('en-GB', {})

		i18n.addCultureData('en-US', {})

		i18n.addCultureData('fr-FR', 'number', {
			decimalSeparator: ','
			groupSeparator: ' '
			listSeparator: ';'
			percentSymbol: '%'
			plusSymbol: '+'
			minusSymbol: '-'
			exponentialSymbol: 'E'
			superScriptingExponent: '×'
			perMilleSymbol: '‰'
			infinitySymbol: '∞'
			nanSymbol: 'NaN'
			timeSeparator: ':'
		})

		expect(i18n.getCulture('en-GB').number).to.eql({
			decimalSeparator: '.'
			groupSeparator: ','
			listSeparator: ';'
			percentSymbol: '%'
			plusSymbol: '+'
			minusSymbol: '-'
			exponentialSymbol: 'E'
			superScriptingExponent: '×'
			perMilleSymbol: '‰'
			infinitySymbol: '∞'
			nanSymbol: 'NaN'
			timeSeparator: ':'
		})

		expect(i18n.getCulture('fr-FR').number).to.eql({
			decimalSeparator: ','
			groupSeparator: ' '
			listSeparator: ';'
			percentSymbol: '%'
			plusSymbol: '+'
			minusSymbol: '-'
			exponentialSymbol: 'E'
			superScriptingExponent: '×'
			perMilleSymbol: '‰'
			infinitySymbol: '∞'
			nanSymbol: 'NaN'
			timeSeparator: ':'
		})
	}) // }}}

	it('format', func() { // {{{
		expect(i18n.format(3.14)).to.equal('3.14')

		class Foo {
			format() => 'foo'
		}

		expect(i18n.format(new Foo())).to.equal('foo')

		class Bar {
			format(...args) => 'bar' + args.length
		}

		expect(i18n.format(new Bar(), 7, 8, 9)).to.equal('bar3')
	}) // }}}
})