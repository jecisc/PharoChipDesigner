Class {
	#name : #ChDDialog,
	#superclass : #SpecVersatileDialogPresenter,
	#instVars : [
		'title'
	],
	#category : #ChipDesigner
}

{ #category : #initialization }
ChDDialog >> initialExtent [ 

	^ 800@600
]

{ #category : #initialization }
ChDDialog >> initializeDialogWindow: aDialogWindowPresenter [
	aDialogWindowPresenter initialExtent: 600@200
]

{ #category : #initialization }
ChDDialog >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	aWindow title: title.
]

{ #category : #accessing }
ChDDialog >> title [
	^ title
]

{ #category : #accessing }
ChDDialog >> title: anObject [
	title := anObject
]