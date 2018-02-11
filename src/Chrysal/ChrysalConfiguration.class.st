Class {
	#name : #ChrysalConfiguration,
	#superclass : #CTEnvironment,
	#category : #Chrysal
}

{ #category : #'instance creation' }
ChrysalConfiguration class >> newFromStream: aStream [
	| stonDictionary conf |
	stonDictionary := (STON fromStream: aStream).
	conf := self new. 
	stonDictionary associations do: [ :aBinding |
		conf setConvertedValueOf: aBinding
		].
	^ conf

]

{ #category : #conversion }
ChrysalConfiguration >> setConvertedValueOf: aBinding [
	"Set the converted value of aBinding value in the correct property of the receiver. 
	aBinding should be property and a raw value as written in the configuration"

	| setter converted |
	setter := aBinding key capitalized , ':'.
	converted := self perform: (#convert , setter) asSymbol with: aBinding value.
	converted ifNil: [ self error: 'aBinding is not correctly spelt ' , aBinding ].
	self perform: setter uncapitalized asSymbol with: converted
]