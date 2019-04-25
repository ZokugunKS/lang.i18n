#![bin]

extern {
	beforeEach:	func
	describe:	func
	it:			func
}

import {
	'@zokugun/lang/src/object/merge'
	'chai'		for expect
	'..'
}

describe('i18n', func() {
	beforeEach(func() { // {{{
		i18n.reset()
    }) // }}}

	it('get', func() { // {{{
		const value = i18n.culture()

		expect(value).to.be.an('object')
		expect(value.name).to.equal('en')
	}) // }}}

	it('set', func() { // {{{
		expect(i18n.culture('fr')).to.equal('en')
	}) // }}}

	it('addCulture - en-US,en-GB', func() { // {{{
		i18n.addCulture({
			name: 'en-GB'
		})

		i18n.addCulture({
			name: 'en-US'
		})

		expect(i18n.culture('en-GB')).to.equal('en-GB')

		let value = i18n.culture()

		expect(value).to.be.an('object')
		expect(value.name).to.equal('en-GB')

		expect(i18n.culture('en-US')).to.equal('en-US')

		value = i18n.culture()

		expect(value).to.be.an('object')
		expect(value.name).to.equal('en-US')
	}) // }}}

	it('addCulture - fr-FR', func() { // {{{
		i18n.addCulture({
			name: 'fr-FR'
		})

		expect(i18n.culture('fr')).to.equal('fr')
	}) // }}}

	it('getCulture - en-US,en', func() { // {{{
		expect(i18n.getCulture('en-US', 'en')).to.eql({
			name: 'en'
		})
	}) // }}}

	it('getCulture - fr', func() { // {{{
		expect(i18n.getCulture('fr')).to.eql({
			name: 'en'
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
        }, (...data) => Object.merge(...data))

		expect(i18n.getExtension('number')).to.eql({
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
		expect(() => i18n.getExtension('date')).to.throw()
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
        }, (...data) => Object.merge({}, ...data))

		i18n.addCulture({
			name: 'en-GB'
		})

		i18n.addCulture({
			name: 'en-US'
		})

		i18n.addCulture({
			name: 'fr-FR'
			number: {
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
			}
		})

		expect(i18n.getExtension('number', 'en-GB')).to.eql({
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

		expect(i18n.getExtension('number', 'fr-FR')).to.eql({
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