Class {
	#name : #ChDPlayground100x100,
	#superclass : #ChDDesign,
	#instVars : [
		'area',
		'ports',
		'sequences',
		'scopes'
	],
	#category : #'ChipDesigner-Levels'
}

{ #category : #'instance creation' }
ChDPlayground100x100 class >> designName [

	 ^ 'Playground 100x100'
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 class >> isRoot [ 

	^ true
]

{ #category : #'instance creation' }
ChDPlayground100x100 class >> levelName [

	 ^ self subclassResponsibility
]

{ #category : #'instance creation' }
ChDPlayground100x100 class >> levels [

	^ Array new
]

{ #category : #'instance creation' }
ChDPlayground100x100 class >> on: area [

	^ self basicNew
		area: area;
		initialize
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 class >> priority [ 

	^ 300
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 class >> selectable [

	^ true
]

{ #category : #accessing }
ChDPlayground100x100 >> area [
	^ area
]

{ #category : #accessing }
ChDPlayground100x100 >> area: anObject [
	area := anObject
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> createLabels [

	area descriptions add: ('+Vcc' -> (3@4)).
	
	1 to: 8 do: [ :i |
		area descriptions add: ((ports at: i) name -> (3@(8+((i-1)*4)))) ] .

	area descriptions add: ('+Vcc' -> (3@40)).

	area descriptions add: ('+Vcc' -> (98@4)).

	1 to: 8 do: [ :i |
		area descriptions add: ((ports at: i+8) name -> (98@(8+((i-1)*4)))) ].

	area descriptions add: ('+Vcc' -> (98@40)).
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> createScopes [

	sequences := ports with: self portPoints collect: [ :port :aPoint |
		| aSequence |
		port isInput 
			ifTrue: [ 
				aSequence := ChDSequence input name: port name.
				aSequence decodedFrom: port sequence ]
			ifFalse: [ 
				aSequence := ChDSequence output name: port name.
				aSequence expectedDecodedFrom: port expectedSequence ].
			
		aSequence forMetalAt: aPoint in: area.
		aSequence ].
	
	scopes := sequences collect: [ :each | ChDSequenceMorph on: each ]
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> initialize [ 

	super initialize.
		
	self initializeArea.

	ports := self portsDefinition.
	ports do: [ :each | each isInput: (each expectedSequence = 0) ].

	self createScopes.

	self initializeSimulation.
	
	self createLabels.
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> initializeArea [

	area decodedFromZipString: 'H4sIAAAAAAAAADMwMDAzgRFurkDC0sTIwMDZ0MjAEExYGALFnCwwxQxA6lxBXDDhCFeHJgZWZwbiggkjuDo0MWfnkW/vyLd35Ns78u0lzV5woTXsCXMzAGEKgrSqBQAA'
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> initializeSimulation [

	area simulation preStepBlock: [ :aSimulation |
	
		sequences do: [ :aSequence | aSequence resetRegion ].	
				
		aSimulation time > 0 ifTrue: [
			sequences with: ports do: [ :sequence :port | 
				port isInput ifTrue: [ 
					sequence updateRegionAt: aSimulation time ] ] ].

		"set Vcc after inputs so they can  overwrite them"
		aSimulation time > 0 ifTrue: [ 
			(area atX: 3 y: 3) metalRegion hasVcc: true.
			(area atX: 3 y: 40) metalRegion hasVcc: true.
			(area atX: 98 y: 3) metalRegion hasVcc: true.
			(area atX: 98 y: 40) metalRegion hasVcc: true. ]
	].
	
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> instructions [

	^ 'intro.png'
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> portPoints [

	^ ((1 to: 8) collect: [ :i | 3@(8+((i-1)*4))]),
	((1 to: 8) collect: [ :i | 98@(8+((i-1)*4))])

]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A0'
			sequence: 1895286724122662508214109177388798933309665208831355630489573082672101741663618047.
		ChipDesignerClassicLevelPort 
			name: 'A1'
			sequence: 1807484548951638332871050064150417808546271801152871425639336334841190810623.
		ChipDesignerClassicLevelPort 
			name: 'A2'
			sequence: 1807484547269931066782991785428060059785466597904927945672633562124766938111.
		ChipDesignerClassicLevelPort 
			name: 'A3'
			sequence: 1895286724120940438332946554699648321487632970982088488659496892968870214733134848.			
		ChipDesignerClassicLevelPort 
			name: 'A4'
			sequence: 1895286724122662508214109177388798933309665208831355630489573082672101741663618047.			
		ChipDesignerClassicLevelPort 
			name: 'A5'
			sequence: 1895286724122662508214109177388798933309665208831355630489573082672101741663618047.			
		ChipDesignerClassicLevelPort 
			name: 'A6'
			sequence: 1895286724122662508214109177388798933309665208831355630489573082672101741663618047.			
		ChipDesignerClassicLevelPort 
			name: 'A7'
			sequence: 1895286724122662508214109177388798933309665208831355630489573082672101741663618047.			

		ChipDesignerClassicLevelPort 
			name: 'Y0'
			expectedSequence: 0.	 
		ChipDesignerClassicLevelPort 
			name: 'Y1'
			expectedSequence: 0.	 
		ChipDesignerClassicLevelPort 
			name: 'Y2'
			expectedSequence: 0.	 
		ChipDesignerClassicLevelPort 
			name: 'Y3'
			expectedSequence: 0.	 
		ChipDesignerClassicLevelPort 
			name: 'Y4'
			expectedSequence: 0.	 
		ChipDesignerClassicLevelPort 
			name: 'Y5'
			expectedSequence: 0.	 
		ChipDesignerClassicLevelPort 
			name: 'Y6'
			expectedSequence: 0.	 
		ChipDesignerClassicLevelPort 
			name: 'Y7'
			expectedSequence: 0.	 
		}


]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> reinitialize [ 

	self initializeSimulation.
	
	self createLabels.
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> scopes [ 

	^ scopes
]