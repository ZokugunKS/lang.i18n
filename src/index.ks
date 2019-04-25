/**
 * index.ks
 * Version 0.3.0
 * July 11th, 2012
 *
 * Copyright (c) 2012 Baptiste Augrain
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 **/
extern sealed class ReferenceError

import '@zokugun/lang/src/object/clone'

let $cultures = {
	'en': {
		name: 'en'
	}
}

let $extensions = {}

let $regions = {
	'en': []
}

let $current = $cultures['en']

func addCulture(data) { // {{{
	const names = data.name.split('-')
	if names.length == 1 {
		const culture = {
			name: data.name
		}

		for const name, extension of $extensions {
			culture[name] = extension.merge(extension.defaults, data[name])
		}

		$cultures[data.name] = culture
		$regions[data.name] = []
	}
	else {
		const language = names[0]

		if !?$cultures[language] {
			addCulture({
				name: language
			})
		}

		const region = $cultures[language]
		const culture = {
			name: data.name
		}

		for const name, extension of $extensions {
			culture[name] = extension.merge(extension.defaults, region[name], data[name])
		}

		$cultures[data.name] = culture
		$regions[language].push(culture.name)
	}
} // }}}

func addExtension(name, defaults, merge) { // {{{
	$extensions[name] = {
		defaults
		merge
	}

	for const :culture of $cultures {
		culture[name] = Object.clone(defaults)
	}
} // }}}

func culture() => $current
func culture(selector): String { // {{{
	if next ?= $cultures[selector] {
		$current = next
	}
	else {
		$current = $cultures['en']
	}

	return $current.name
} // }}}

func format(value = '', ...args): String { // {{{
	if value.format is Function {
		return value.format(...args)
	}
	else {
		return value.toString()
	}
} // }}}

func getCulture(...selectors) { // {{{
	let culture

	while selectors.length > 0 {
		if culture ?= $cultures[selectors.shift()] {
			return culture
		}
	}

	return $current
} // }}}

#[error(ignore(ReferenceError))]
func getExtension(name, ...selectors) { // {{{
	const culture = getCulture(...selectors)

	unless ?culture[name] {
		throw new ReferenceError(`The culture "\(culture.name)" doesn't have the extension "\(name)".`)
	}

	return culture[name]
} // }}}

func isCulture(value) => value is String && ((value.length == 2 && /[a-z]{2}/.test(value)) || (value.length == 5 && /[a-z]{2}\-[A-Z]{2}/.test(value)))

func reset() { // {{{
	$cultures = {
		'en': {
			name: 'en'
		}
	}

	$extensions = {}

	$regions = {
		'en': []
	}

	$current = $cultures['en']
} // }}}

 export namespace i18n {
	 export {
		 addCulture
		 addExtension
		 culture
		 format
		 getCulture
		 getExtension
		 isCulture
		 reset
	 }
 }