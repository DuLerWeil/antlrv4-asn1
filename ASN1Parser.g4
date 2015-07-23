parser grammar ASN1Parser;

/**
 * Section 12.2.1
 *
 * Bug: This rule accepts Ab12-ab12 but not Ab12-ab12-ab12; needs another rule.
 */
typereference : RULE_TYPE_REFERENCE ;

/**
 * Section 12.3
 *
 * Bug: This rule accepts abcdef-abcdef but not ab12-ab12 but not ab12-ab12-ab12; needs another rule.
 */
identifier : RULE_IDENTIFIER ;

/**
 * Section 12.4
 */
valuereference : identifier ;

/**
 * Section 12.5
 */
modulereference : typereference ;

/**
 * Section 12.6
 */
comment : RULE_SINGLE_COMMENT | RULE_BLOCK_COMMENT ;

/**
 * Section 12.7
 */
empty : ; // NO-OP

/**
 * Section 12.8
 */
number : DIG_0_TO_9 | NUMBER ;

/**
 * Section 12.9
 * TODO
 */
realnumber : ;

/**
 * Section 12.10
 */
bstring : BSTRING ;

/**
 * Section 12.12
 */
hstring : HSTRING ;

/**
 * Section 12.14
 */
cstring : CSTRING ;

/**
 * Section 12.16
 */
simplestring : CSTRING ;

/**
 * Section 12.17
 * TODO
 */
tstring : ;

/**
 * Section 12.19
 */
psname : typereference ;

/**
 * Section 12.25
 */
encodingreference : RULE_ENCODING_REFERENCE ;

/**
 * Refer to Section 13.1
 */
 moduleDefinition
    :
    moduleIdentifier
    RW_DEFINITIONS
    encodingReferenceDefault
    tagDefault
    extensionDefault
    ASSIGNMENT
    RW_BEGIN
    moduleBody
    encodingControlSections
    RW_END
    ;

moduleIdentifier
    :
    modulereference
    definitiveIdentification
    ;

definitiveIdentification
    :
    definitiveOid |
    definitiveOidAndIri |
    empty
    ;

definitiveOid : L_BRACE definitiveObjIdComponentList R_BRACE ;

definitiveOidAndIri
    :
    definitiveOid
    iriValue
    ;

definitiveObjIdComponentList
    :
    definitiveObjIdComponent |
    definitiveObjIdComponent
    definitiveObjIdComponentList
    ;

definitiveObjIdComponent
    :
    nameForm |
    definitiveNumberForm |
    definitiveNameAndNumberForm
    ;

definitiveNumberForm
    :
    number
    ;

definitiveNameAndNumberForm : identifier ( L_PARAN definitiveNumberForm R_PARAN ) ;

encodingReferenceDefault
    :
    encodingreference RW_INSTRUCTIONS |
    empty
    ;

tagDefault
    :
    RW_EXPLICIT RW_TAGS |
    RW_IMPLICIT RW_TAGS |
    RW_AUTOMATIC RW_TAGS |
    empty
    ;

extensionDefault
    :
    RW_EXTENSIBILITY RW_IMPLIED |
    empty
    ;

moduleBody
    :
    exports imports assignmentList |
    empty
    ;

exports
    :
    RW_EXPORTS symbolsExported SEMICOLON |
    RW_EXPORTS RW_ALL SEMICOLON |
    empty
    ;

symbolsExported
    :
    symbolList |
    empty
    ;

imports
    :
    RW_IMPORTS symbolsImported SEMICOLON |
    empty
    ;

symbolsImported
    :
    symbolsFromModuleList
    |
    empty
    ;

symbolsFromModuleList
    :
    symbolsFromModule |
    symbolsFromModuleList symbolsFromModule
    ;

symbolsFromModule
    :
    symbolList RW_FROM globalModuleReference
    ;

globalModuleReference
    :
    modulereference assignedIdentifier
    ;

assignedIdentifier
    :
    objectIdentifierValue |
    definedValue |
    empty
    ;

symbolList
    :
    symbol |
    symbolList RW_COMMA symbol
    ;

symbol
    :
    reference //|
//    parameterizedReference
    ;

reference
    :
    typereference |
    valuereference //| XXX: Research other ITU specifications. Not sure this is needed.
//    objectclassreference |
//    objectreference |
//    objectsetreference
    ;

assignmentList
    :
    assignment |
    assignmentList assignment
    ;

assignment
    :
    typeAssignment |
    valueAssignment |
//    xmlValueAssignment |
    valueSetTypeAssignment //|
//    objectClassAssignment | XXX: Research other ITU specs (x.681/x683) not sure this is needed
//    objectAssignment |
//    objectSetAssignment |
//    parameterizedAssignment
    ;

/**
 * Refer to Section 14.1
 */
definedType :
    externalTypeReference |
    typereference
//    parameterizedType | // XXX: research
//    parameterizedValueSetType
    ;

definedValue :
    externalValueReference |
    valuereference |
//    parameterizedValue // XXX: Research
    ;

nonParameterizedTypeName
    :
    externalTypeReference |
    typereference
//    | xmlasn1typename
    ;

/**
 * Section 14.6
 */
externalTypeReference
    :
    modulereference '.' typereference
    ;

externalValueReference
    :
    modulereference '.' valuereference
    ;

/**
 * Section 15.3
 */
 absoluteReference
    :
    AT moduleIdentifier DOT itemSpec
    ;

itemSpec
    :
    typereference |
    itemId DOT componentId
    ;

itemId
    :
    itemSpec
    ;

componentId
    :
    identifier |
    number |
    '*'
    ;

/**
 * Section 16.1
 */
 typeAssignment
    :
    typereference ASSIGNMENT type
    ;

/**
 * Section 16.2
 */
 valueAssignment
    :
    valuereference type ASSIGNMENT value
    ;

/**
 * Section 16.6
 */
valueSetTypeAssignment
    :
    typereference type ASSIGNMENT valueSet
    ;

/**
 * Section 16.7
 */
 valueSet
    :
    L_BRACE elementSetSpecs R_BRACE
    ;

/**
 * Section 16.8 TODO
 */


/**
 * Definition of Types and Values
 * A type is specified by the notation 'Type'; a Type can be a BuiltIn, Referenced or Constrained.
 *
 * Refer to Section 17.1
 */
 type
    :
    builtInType |
    referencedType |
    constrainedType
    ;

 /**
  * The built-in types of ASN.1 are specified by the notation builtInType.
  *
  * Refer to Section 17.2
  */
 builtInType
    :
    bitStringType |
    booleanType |
    characterStringType |
    choiceType |
    dateType |
    dateTimeType |
    durationType |
    embeddedPdvType |
    enumeratedType |
    externalType |
    instanceOfType |
    integerType |
    iriType |
    nullType |
    objectClassFieldType |
    objectIdentifierType |
    octetStringType |
    realType |
    relativeIriType |
    relativeOidType |
    sequenceType |
    sequenceOfType |
    setType |
    setOfType |
    prefixedType |
    timeType |
    timeOfDayType
    ;

/**
 * The referenced types of ASN.1 are specified by the notation referencedType
 *
 * Refer to Section 17.3
 */
referencedType
    :
    definedType |
    usefulType |
    selectionType |
    typeFromObjectType |
    valueSetFromObjectsType
    ;

/**
 * Section 17.5
 */
namedType
    :
    identifier type
    ;

/**
 * Section 17.7
 */
value
    :
    builtinValue |
    referencedValue |
    objectClassFieldValue
    ;

/**
 * Section 17.9
 */
builtInValue
    :
    bitStringValue |
    booleanValue |
    characterStringValue |
    choiceValue |
    embeddedPdvValue |
    enumeratedValue |
    externalValue |
    instanceOfValue |
    integerValue |
    iriValue |
    nullValue |
    objectIdentifierValue |
    octetStringValue |
    realValue |
    relativeIriValue |
    relativeOidValue |
    sequenceValue |
    sequenceOfValue |
    setValue |
    setOfValue |
    prefixedValue |
    timeValue
    ;

/**
 * Section 17.11
 */
referencedValue
    :
    definedValue |
    valueFromObject
    ;

/**
 * Section 17.13
 */
namedValue
    :
    identifier value
    ;

/**
 * Section 18.1
 */
booleanType
    :
    RW_BOOLEAN
    ;

/**
 * Section 18.3
 */
booleanValue
    :
    RW_TRUE | RW_FALSE
    ;

/**
 * 19.1
 */
integerType
    :
    RW_INTEGER |
    RW_INTEGER L_BRACE namedNumberList R_BRACE
    ;

namedNumberList
    :
    namedNumber |
    namedNumberList COMMA namedNumber
    ;

namedNumber
    :
    identifier L_PARAN signedNumber R_PARAN |
    identifier L_PARAN definedValue R_PARAN
    ;

signedNumber
    :
    number |
    HYPHEN number
    ;

/**
 * Section 19.9
 */
integerValue
    :
    signedNumber |
    identifier
    ;

/**
 * Section 20.1
 */
enumeratedType
    :
    RW_ENUMERATED L_BRACE enumerations R_BRACE
    ;

enumerations
    :
    rootEnumeration |
    rootEnumeration COMMA ELLIPSIS exceptionSpec |
    rootEnumeration COMMA ELLIPSIS COMMA additionalEnumeration
    ;

rootEnumeration
    :
    enumeration
    ;

additionalEnumeration
    :
    enumeration
    ;

enumeration
    :
    enumerationItem | enumerationItem COMMA enumeration
    ;

enumerationItem
    :
    identifier | namedNumber
    ;

/**
 * Section 20.8
 */
enumeratedValue
    :
    identifier
    ;

/**
 * Section 21.1
 */
realType
    :
    RW_REAL
    ;

/**
 * Section 21.6
 */
realValue
    :
    numericRealValue |
    specialRealValue
    ;

numericRealValue
    :
    realnumber |
    HYPHEN realnumber |
    sequenceValue
    ;

specialRealValue
    :
    RW_PLUS_INFINITY |
    RW_MINUS_INFINITY |
    RW_NOT_A_NUMBER
    ;


/**
 * Section 22.1
 */
bitStringType
    :
    RW_BIT RW_STRING |
    RW_BIT RW_STRING L_BRACE namedBitList R_BRACE
    ;

namedBitList
    : namedBit |
    namedBitList COMMA namedBit
    ;
namedBit
    :
    identifier L_BRACE number R_BRACE |
    identifier L_BRACE definedValue R_BRACE
    ;

/**
 * Section 22.9
 */
bitStringValue
    :
    bstring |
    hstring |
    L_BRACE identifierList R_BRACE |
    L_BRACE R_BRACE |
    RW_CONTAINING value
    ;

identifierList
    :
    identifier |
    identifierList COMMA identifier
    ;

/**
 * Section 23.1
 */
octetStringType
    :
    RW_OCTET RW_STRING
    ;

/**
 * 23.3
 */
octetStringValue
    :
    bstring |
    hstring |
    RW_CONTAINING value
    ;

/**
 * 24.1
 */
nullType
    :
    RW_NULL
    ;

/**
 * 24.3
 */
nullValue
    :
    RW_NULL
    ;

/**
 * 25.1
 */
sequenceType
    :
    RW_SEQUENCE L_BRACE R_BRACE |
    RW_SEQUENCE L_BRACE extensionAndExpression optionalExtensionMarket R_BRACE |
    RW_SEQUENCE L_BRACE componentTypeLists R_BRACE
    ;

extensionAndException
    :
    ELLIPSIS exceptionSpec
    ;

optionalExtensionMarket
    :
    COMMA ELLIPSIS exceptionSpec
    ;

optionalExtensionMarker
    :
    COMMA ELLIPSIS |
    empty
    ;

componentTypeLists
    :
    rootComponentTypeList |
    rootComponentTypeList COMMA extensionAndException extensionAdditions optionalExtensionMarker |
    rootComponentTypeList COMMA extensionAndException extensionAdditions extensionEndMarket COMMA rootComponentTypeList |
    extensionAndException extensionAdditions optionalExtensionMarker
    ;

rootComponentTypeList
    :
    componentTypeList
    ;

extensionEndMarker
    :
    COMMA ELLIPSIS
    ;

extensionAdditions
    :
    COMMA extensionAdditionList |
    empty
    ;

extensionAdditionList
    :
    extensionAddition |
    extensionAdditionList COMMA extensionAddition
    ;

extensionAddition
    :
    componentType |
    extensionAdditionGroup
    ;

extensionAdditionGroup
    :
    LEFT_VERSION_BRACKETS versionNumber componentTypeList RIGHT_VERSION_BRACKETS
    ;

versionNumber
    :
    empty |
    number COLON
    ;

componentTypeList
    :
    namedType |
    namedType RW_OPTIONAL |
    namedType RW_DEFAULT value |
    RW_COMPONENTS RW_OF type
    ;

componentType
    :
    namedType |
    namedType RW_OPTIONAL |
    namedType RW_DEFAULT value |
    RW_COMPONENTS RW_OF type
    ;

/**
 * 25.18
 */
sequenceValue
    :
    L_BRACE componentValueList R_BRACE |
    L_BRACE R_BRACE
    ;

componentValueList
    :
    namedValue |
    componentValueList COMMA namedValue
    ;

/**
 * 26.3
 */
sequenceOfValue
    :
    L_BRACE valueList R_BRACE |
    L_BRACE namedValueList R_BRACE |
    L_BRACE R_BRACE
    ;

valueList
    :
    value |
    valueList COMMA value
    ;

namedValueList
    :
    namedValue |
    namedValueList COMMA namedValue
    ;

/**
 * 27.1
 */
setType
    :
    RW_SET L_BRACE R_BRACE |
    RW_SET L_BRACE extensionAndException optionalExtensionMarker R_BRACE |
    RW_SET L_BRACE componentTypeLists R_BRACE
    ;

/**
 * 27.7
 */
setValue
    :
    L_BRACE componentValueList R_BRACE |
    L_BRACE R_BRACE
    ;

/**
 * 28.1
 */
setOfType
    :
    RW_SET RW_OF type |
    RW_SET RW_OF namedType
    ;

/**
 * 28.3
 */
setOfValue
    :
    L_BRACE valueList R_BRACE |
    L_BRACE namedValueList R_BRACE |
    L_BRACE R_BRACE
    ;

/**
 * 29.1
 */
choiceType
    :
    RW_CHOICE L_BRACE alternativeTypeLists R_BRACE
    ;

alternativeTypeLists
    :
    rootAlternativeTypeList |
    rootAlternativeTypeList COMMA extensionAndException extensionAdditionAlternatives optionalExtensionMarker
    ;

rootAlternativeTypeList
    :
    COMMA extensionAdditionAlternativesList |
    empty
    ;

extensionAdditionAlternativesList
    :
    extensionAdditionAlternative |
    extensionAdditionAlternativesList COMMA extensionAdditionAlternative
    ;

extensionAdditionAlternative
    :
    extensionAdditionAlternativesGroup |
    namedType
    ;

extensionAdditionAlternativesGroup
    :
    LEFT_VERSION_BRACKETS versionNumber alternativeTypeList RIGHT_VERSION_BRACKETS
    ;

alternativeTypeList
    :
    namedType |
    alternativeTypeList COMMA namedType
    ;

/**
 * 29.11
 */
choiceValue
    :
    identifier COLON value
    ;

/**
 * 30.1
 */
selectionType
    :
    identifier LT type
    ;

/**
 * 31.1.5
 */
prefixedType
    :
    taggedType |
    encodingPrefixedType
    ;

/**
 * 31.1.6
 */
prefixedValue
    :
    value
    ;

/**
 * 31.2
 */
taggedType
    :
    tag type |
    tag RW_IMPLICIT type |
    tag RW_EXPLITIC type
    ;

tag
    :
    L_BRACKET encodingReference clazz classNumber R_BRACKET
    ;

encodingReference
    :
    encodingreference COLON |
    empty
    ;

classNumber
    :
    number |
    definedValue
    ;

clazz
    :
    RW_UNIVERSAL |
    RW_APPLICATION |
    RW_PRIVATE |
    empty
    ;

/**
 * 31.3.1
 */
encodingPrefixedType
    :
    encodingPrefix type
    ;

encodingPrefixx
    :
    L_BRACKET encodingReference encodingInstruction R_BRACKET
    ;

/**
 * 32.3
 */
objectIdentifierValue
    :
    L_BRACE objIdComponentsList R_BRACE |
    L_BRACE definedValue objIdComponentsList R_BRACE
    ;

objIdComponentsList
    :
    objIdComponents |
    objIdComponents objIdComponentsList
    ;

objIdComponents
    :
    nameForm |
    numberForm |
    nameAndNumberForm |
    definedValue
    ;

nameForm
    :
    identifier
    ;

numberForm
    :
    number | definedValue
    ;

nameAndNumberForm
    :
    identifier L_PARAN numberForm R_PARAN
    ;

/**
 * 33.1
 */
relativeOidType
    :
    RW_RELATIVE_OID
    ;

/**
 * 33.3
 */
relativeOidValue
    :
    L_BRACE relativeOidComponentsList R_BRACE
    ;

relativeOidComponentsList
        :
        relativeOidComponents |
        relativeOidComponents relativeOidComponentsList
        ;

relativeOidComponents
    :
    numberForm |
    namedAndNumberForm |
    definedValue
    ;

/**
 * 34.1
 */
iriType
    :
    RW_OID_IRI
    ;

iriValue
    :
    QUOT firstArcIdentifier subsequentArcIdentifier QUOT
    ;

firstArcIdentifier
    :
    SOLIDUS arcIdentifier
    ;

subsequentArcIdentifier
    :
    SOLIDUS arcIdentifier subsequentArcIdentifier |
    empty
    ;

arcIdentifier
    :
    integerUnicodeLabel |
    nonIntegerUnicodeLabel
    ;

/**
 * 35.1
 */
relativeIriType
    :
    RW_RELATIVE_OID_IRI
    ;

/**
 * 35.3
 */
relativeIriValue
    :
    SOLIDUS firstRelativeArcIdentifier subsequentArcIdentifier SOLIDUS
    ;

firstRelativeArcIdentifier
    :
    arcIdentifier
    ;

/**
 * 36.1
 */
embeddedPdvType
    :
    RW_EMBEDDED_PDV
    ;

/**
 * 36.8
 */
embeddedPdvValue
    :
    sequenceValue
    ;

/**
 * 37.1
 */
externalType
    :
    RW_EXTERNAL
    ;

/**
 * 37.7
 */
externalValue
    :
    sequenceValue
    ;

/**
 * 38.1.1
 */
timeType
    :
    RW_TIME
    ;

timeValue
    :
    tstring
    ;

/**
 * 38.4.1
 */
dateType
    :
    RW_DATE
    ;

/**
 * 38.4.2
 */
timeOfDateType
    :
    RW_TIME_OF_DAY
    ;

/**
 * 38.4.3
 */
dateTimeType
    :
    RW_DATE_TIME
    ;

/**
 * 38.4.4
 */
durationType
    :
    RW_DURATION
    ;

/**
 * 40.1
 */
characterStringType
    :
    restrictedCharacterStringValue |
    unrestrictedCharacterStringValue
    ;

/**
 * 40.3
 */
characterStringValue
    :
    restrictedCharacterStringValue |
    unrestrictedCharacterStringValue
    ;

/**
 * 41
 */
restrictedCharacterStringType
    :
    bmpString |
    generalString |
    graphicString |
    ia5String |
    iso646String |
    numericString |
    printableString |
    teletexString |
    t61String |
    universalString |
    utf8String |
    videotexString |
    visibleString
    ;

/**
 * 41.8
 */
restrictedCharacterStringValue
    :
    cstring |
    characterStringList |
    quadruple |
    tuple
    ;

characterStringList
    :
    L_BRACE charSyms L_BRACE
    ;

charSyms
    :
    charsDefn |
    charSyms COMMA charsDefn
    ;

quadruple
    :
    L_BRACE group COMMA plane COMMA row COMMA cell R_BRACE
    ;

group
    :
    number
    ;

plane
    :
    number
    ;

row
    :
    number
    ;

cell
    :
    number
    ;

tuple
    :
    L_BRACE tableColumn COMMA tableRow R_BRACE
    ;

tableColumn
    :
    number
    ;

tableRow
    :
    number
    ;

/**
 * The constrainedType notation allows a constraint to be applied to a parent type, either
 * to restrict values to some subtype of the parent, or to specify that component relations
 * apply to values of the parent type, and values of some other component in the same set or
 * sequence value.
 *
 * Refer to Section 49.1
 */
constrainedType
    :
    type /* constraint */ //|
    /*typeWithConstraint */
    ;
