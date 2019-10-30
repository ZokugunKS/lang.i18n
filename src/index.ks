/**
 * index.ks
 * Version 0.3.0
 * July 11th, 2012
 *
 * Copyright (c) 2012 Baptiste Augrain
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 **/
require|import '@zokugun/lang/src/dictionary/clone'

let $cultures = {
	'und': {
		name: 'und'
	}
}
let $extensions = {}
let $properties = {}
let $regions = {}

let $current = $cultures['und']

func addCultureData(name: String, extensionName: String = null, data): Void { // {{{
	const names = name.split('-')

	const language = names[0]
	const region = names.length == 1 ? null : names[1]

	let culture = $cultures[name]
	if !?culture {
		culture = {
			name
		}

		$cultures[name] = culture

		if region == null {
			$regions[language] = []
		}
		else {
			if !?$cultures[language] {
				$cultures[language] = {
					name: language
				}

				$regions[language] = []
			}

			$regions[language].push(name)
		}
	}

	if const extension = $extensions[extensionName] {
		if region == null {
			culture[extensionName] = extension.merge(extension.defaults, data)
		}
		else {
			culture[extensionName] = extension.merge(extension.defaults, $cultures[language][extensionName], data)
		}
	}
	else {
		if region == null {
			for const extension, name of $extensions {
				culture[name] = extension.merge(extension.defaults, data[name])
			}
		}
		else {
			for const extension, name of $extensions {
				culture[name] = extension.merge(extension.defaults, $cultures[language][name], data[name])
			}
		}
	}
} // }}}

func addExtension(name, defaults, merge): Void { // {{{
	$extensions[name] = {
		defaults
		merge
	}

	for const culture of $cultures {
		culture[name] = Dictionary.clone(defaults)
	}
} // }}}

func addProperty(name, defaultValue, setter): Void { // {{{
	$properties[name] = {
		defaultValue
		setter
		value: defaultValue
	}
} // }}}

func format(value = '', ...args): String { // {{{
	if value.format is Function {
		return value.format(...args)
	}
	else {
		return value.toString()
	}
} // }}}

func getCulture(): Dictionary => $current
func getCulture(...selectors): Dictionary { // {{{
	let culture

	while selectors.length > 0 {
		if culture ?= $cultures[selectors.shift()] {
			return culture
		}
	}

	return $current
} // }}}

func getProperty(name): Any { // {{{
	return $properties[name].value
} // }}}

func isCulture(value): Boolean => value is String && ((value.length == 2 && /[a-z]{2}/.test(value)) || (value.length == 5 && /[a-z]{2}\-[A-Z]{2}/.test(value)))

func reset(): Void { // {{{
	$cultures = {
		'und': {
			name: 'und'
		}
	}

	$extensions = {}
	$properties = {}
	$regions = {}

	$current = $cultures['und']
} // }}}

func setCulture(selector): String { // {{{
	if next ?= $cultures[selector] {
		$current = next
	}
	else {
		$current = $cultures['und']
	}

	for const property of $properties {
		property.value = property.setter(property.value, $current)
	}

	return $current.name
} // }}}

func setProperty(name, value): Void { // {{{
	$properties[name].value = $properties[name].setter(value, $current)
} // }}}

 export namespace i18n {
	 export {
		 addCultureData
		 addExtension
		 addProperty
		 format
		 getCulture
		 getProperty
		 isCulture
		 reset
		 setCulture
		 setProperty
	 }
 }