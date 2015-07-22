/**
 * Abstract Syntax Notation One grammar for ANTLRv4, references within this document refer to
 * T-REX-X.680-200811 which is freely available for review.
 *
 * @author <a href="http://krslynx.com">Christopher Burke</a> - July 2015
 * For comments, improvements or questions please visit my website to contact me.
 *
 * Licensed under the Apache 2.0 License. Please see LICENSE for details.
 */
grammar ASN1;

/*
 * Parser
 */

/*
 * ASN1 Basic Types Reference, ordered by decimal/hexadecimal tag value.
 *
 * [type]                       [dec/hex]   [uncommon/implemented]
 * BOOLEAN                      [01/01]     [-/-]
 * INTEGER                      [02/02]     [-/-]
 * BIT STRING                   [03/03]     [-/-]
 * OCTET STRING                 [04/04]     [-/-]
 * NULL                         [05/05]     [-/-]
 * OBJECT IDENTIFIER            [06/06]     [-/-]
 * RELATIVE-OID                 [07/07]     [-/-]
 * ObjectDescriptor             [07/07]     [+/-]
 * REAL                         [08/08]     [-/-]
 * EXTERNAL                     [08/08]     [+/-]
 * ENUMERATED                   [10/0A]     [-/-]
 * EMBEDDED PDV                 [11/08]     [-/-]
 * UTF8String                   [12/0C]     [-/-]
 * SEQUENCE                     [16/10]     [-/-]
 * SEQUENCE OF                  [16/10]     [-/-]
 * SET                          [17/11]     [+/-]
 * SET OF                       [17/11]     [+/-]
 * NumericString                [18/12]     [-/-]
 * PrintableString              [19/13]     [+/-]
 * T61String                    [20/14]     [+/-]
 * TeletexString                [20/14]     [+/-]
 * VideotexString               [21/15]     [+/-]
 * IA5String                    [22/16]     [-/-]
 * UTCTime                      [23/17]     [+/-]
 * GeneralizedTime              [24/18]     [+/-]
 * GraphicString                [25/19]     [+/-]
 * VisibleString                [26/1A]     [-/-]
 * ISO646String                 [26/1A]     [+/-]
 * GeneralString                [27/1B]     [+/-]
 * UniversalString              [27/1B]     [+/-]
 * CHOICE                       [-----]     [-/-]
 * CHARACTER STRING             [29/1D]     [+/-]
 * BMPString                    [30/1E]     [+/-]
 * DATE                         [31/* ]     [-/-]
 * TIME-OF-DAY                  [32/* ]     [-/-]
 * DATE-TIME                    [33/* ]     [-/-]
 * DURATION                     [34/* ]     [-/-]
 * OID-IRI                      [35/* ]     [-/-]
 * RELATIVE-OID-IRI             [36/* ]     [-/-]
 */

typeBoolean                 : RW_TRUE | RW_FALSE | RW_TRUE_LOWER | RW_FALSE_LOWER ;
typeInteger                 : RW_INTEGER ( L_BRACE ( COMMA ) R_BRACE );
typeBitString               : RW_BIT RW_STRING ( ) ;
typeOctetString             : RW_OCTET RW_STRING ( ) ;
typeNull                    : RW_NULL ( ) ;
typeObjectIdentifier        : RW_OBJECT RW_IDENTIFIER ( ) ;
typeRelativeOid             : RW_RELATIVE_OID ( ) ;
typeObjectDescriptor        : RW_OBJECT_DESCRIPTOR ( ) ;
typeReal                    : RW_REAL ( ) ;
typeExternal                : RW_EXTERNAL ( ) ;
typeEnumerated              : RW_ENUMERATED ( ) ;
typeEmbeddedPdv             : RW_EMBEDDED ( ) ;
typeUff8String              : RW_UTF8_STRING ( ) ;
typeSequence                : RW_SEQUENCE ( ) ;
typeSequenceOf              : RW_SEQUENCE RW_OF ( ) ;
typeSet                     : RW_SET ( ) ;
typeSetOf                   : RW_SET RW_OF ( ) ;
typeNumericString           : RW_NUMERIC_STRING ( ) ;
typePrintableString         : RW_PRINTABLE_STRING ( ) ;
typeT61String               : RW_T61_STRING ( ) ;
typeTeletexString           : RW_TELETEX_STRING ( ) ;
typeVideotexString          : RW_VIDEOTEX_STRING ( ) ;
typeIa5String               : RW_IA5_STRING ( ) ;
typeUtcTime                 : RW_UTCTIME ( ) ;
typeGeneralizedString       : RW_GENERALIZED_TIME ( ) ;
typeGraphicString           : RW_GRAPHIC_STRING ( ) ;
typeVisibleString           : RW_VISIBLE_STRING ( ) ;
typeIso646String            : RW_ISO646_STRING ( ) ;
typeGeneralString           : RW_GENERAL_STRING ( ) ;
typeUniversalString         : RW_UNIVERSAL_STRING ( ) ;
typeChoice                  : RW_CHOICE ( ) ;
typeCharacterString         : RW_CHARACTER ( ) ;
typeBmpString               : RW_BMP_STRING ( ) ;
typeDate                    : RW_DATE ( ) ;
typeTimeOfDay               : RW_TIME_OF_DAY ( ) ;
typeDateTime                : RW_DATE_TIME ( ) ;
typeDuration                : RW_DURATION ( ) ;
typeOidIri                  : RW_OID_IRI ( ) ;
typeRelativeOidIri          : RW_RELATIVE_OID_IRI ( ) ;

/*
 * Lexer
 */

/* 12.20 - ASN1 Assignment */
ASSIGNMENT                  : '::=' ;

/* 12.21 - ASN1 Range */
RANGE                       : '..' ;

/* 12.22 - ASN1 Ellipsis */
ELLIPSIS                    : '...' ;

/* 12.23/24 - ASN1 Version */
LEFT_VERSION_BRACKETS       : '[[' ;
RIGHT_VERSION_BRACKETS      : ']]' ;

/* 12.37 - Single Characters, ordered by specification appearance. */
L_BRACE                     : '{' 	;
R_BRACE 	                : '}' 	;
LT 		                    : '<' 	;
GT		                    : '>' 	;
COMMA		                : ',' 	;
DOT		                    : '.' 	;
SOLIDUS	                    : '/' 	;
L_PARAN	                    : '(' 	;
R_PARAN	                    : ')' 	;
L_BRACKET                   : '[' 	;
R_BRACKET                   : ']' 	;
HYPHEN	                    : '-' 	;
COLON		                : ':' 	;
EQUALS	                    : '=' 	;
QUOT		                : '"' 	;
APOS		                : '\''	;
SPACE		                : ' ' 	;
SEMICOLON                   : ';' 	;
AT		                    : '@' 	;
PIPE		                : '|' 	;
EXCLAM	                    : '!' 	;
CARROT	                    : '^' 	;
AMP		                    : '&' 	;
USCORE	                    : '_' 	;
BIN		                    : '\'B' ;
HEX		                    : '\'H' ;

/* 12.38 - Reserved Words; ordered alphabetically. */
RW_ABSENT				    : 'ABSENT' ;
RW_ABSTRACT_SYNTAX		    : 'ABSTRACT-SYNTAX' ;
RW_ALL					    : 'ALL' ;
RW_APPLICATION			    : 'APPLICATION' ;
RW_AUTOMATIC			    : 'AUTOMATIC' ;
RW_BEGIN				    : 'BEGIN' ;
RW_BIT					    : 'BIT' ;
RW_BMP_STRING			    : 'BMPString' ;
RW_BOOLEAN				    : 'BOOLEAN' ;
RW_BY					    : 'BY' ;
RW_CHARACTER			    : 'CHARACTER' ;
RW_CHOICE				    : 'CHOICE' ;
RW_CLASS				    : 'CLASS' ;
RW_COMMENT				    : '--' ; 					/* 12.6.1 */
RW_COMPONENT			    : 'COMPONENT' ;
RW_COMPONENTS			    : 'COMPONENTS' ;
RW_CONSTRAINED			    : 'CONSTRAINED' ;
RW_CONTAINING			    : 'CONTAINING' ;
RW_DATE					    : 'DATE' ;
RW_DATE_TIME			    : 'DATE-TIME' ;
RW_DEFAULT				    : 'DEFAULT' ;
RW_DEFINITIONS			    : 'DEFINITIONS' ;
RW_DURATION				    : 'DURATION' ;
RW_EMBEDDED				    : 'EMBEDDED' ;
RW_ENCODED				    : 'ENCODED' ;
RW_ENCODING_CONTROL		    : 'ENCODING-CONTROL' ;
RW_END					    : 'END' ;
RW_ENUMERATED			    : 'ENUMERATED' ;
RW_EXCEPT				    : 'EXCEPT' ;
RW_EXPLICIT				    : 'EXPLICIT' ;
RW_EXPORTS				    : 'EXPORTS' ;
RW_EXTENSIBILITY		    : 'EXTENSIBILITY' ;
RW_EXTERNAL				    : 'EXTERNAL' ;
RW_FALSE				    : 'FALSE' ;
RW_FALSE_LOWER				: 'false' ;
RW_FROM					    : 'FROM' ;
RW_GENERALIZED_TIME		    : 'GeneralizedTime' ;
RW_GENERAL_STRING		    : 'GeneralString' ;
RW_GRAPHIC_STRING		    : 'GraphicString' ;
RW_IA5_STRING			    : 'IA5String' ;
RW_IDENTIFIER			    : 'IDENTIFIER' ;
RW_IMPLICIT				    : 'IMPLICIT' ;
RW_IMPLIED				    : 'IMPLIED' ;
RW_IMPORTS				    : 'IMPORTS' ;
RW_INCLUDES				    : 'INCLUDES' ;
RW_INSTANCE				    : 'INSTANCE' ;
RW_INSTRUCTIONS			    : 'INSTRUCTIONS' ;
RW_INTEGER				    : 'INTEGER' ;
RW_INTERSECTION			    : 'INTERSECTION' ;
RW_ISO646_STRING		    : 'ISO646String' ;
RW_MAX					    : 'MAX' ;
RW_MIN					    : 'MIN' ;
RW_MINUS_INFINITY		    : 'MINUS-INFINITY' ;
RW_NOT_A_NUMBER			    : 'NOT-A-NUMBER' ;
RW_NULL					    : 'NULL' ;
RW_NUMERIC_STRING		    : 'NumericString' ;
RW_OBJECT				    : 'OBJECT' ;
RW_OBJECT_DESCRIPTOR	    : 'ObjectDescriptor' ;
RW_OCTET				    : 'OCTET' ;
RW_OF					    : 'OF' ;
RW_OID_IRI				    : 'OID-IRI' ;
RW_OPTIONAL				    : 'OPTIONAL' ;
RW_PATTERN				    : 'PATTERN' ;
RW_PDV					    : 'PDV' ;
RW_PLUS_INFINITY		    : 'PLUS-INFINITY' ;
RW_PRESENT				    : 'PRESENT' ;
RW_PRINTABLE_STRING		    : 'PrintableString' ;
RW_PRIVATE				    : 'PRIVATE' ;
RW_REAL					    : 'REAL' ;
RW_RELATIVE_OID			    : 'RELATIVE-OID' ;
RW_RELATIVE_OID_IRI		    : 'RELATIVE-OID-IRI' ;
RW_SEQUENCE				    : 'SEQUENCE' ;
RW_SET					    : 'SET' ;
RW_SETTINGS				    : 'SETTINGS' ;
RW_SIZE					    : 'SIZE' ;
RW_STRING				    : 'STRING' ;
RW_SYNTAX				    : 'SYNTAX' ;
RW_T61_STRING			    : 'T61String' ;
RW_TAGS					    : 'TAGS' ;
RW_TELETEX_STRING		    : 'TeletexString' ;
RW_TIME					    : 'TIME' ;
RW_TIME_OF_DAY			    : 'TIME-OF-DAY' ;
RW_TRUE					    : 'TRUE' ;
RW_TRUE_LOWER				: 'true' ;
RW_TYPE_IDENTIFER		    : 'TYPE-IDENTIFIER' ;
RW_UNION				    : 'UNION' ;
RW_UNIQUE				    : 'UNIQUE' ;
RW_UNIVERSAL			    : 'UNIVERSAL' ;
RW_UNIVERSAL_STRING		    : 'UniversalString' ;
RW_UTCTIME				    : 'UTCTime' ;
RW_UTF8_STRING			    : 'UTF8String' ;
RW_VIDEOTEX_STRING		    : 'VideotexString' ;
RW_VISIBLE_STRING		    : 'VisableString' ;
RW_WITH					    : 'WITH' ;


/*
 * Notations / Misc etc
 */
BINARY_STRING		        : APOS ('0'..'1')* BIN ;
HEX_STRING			        : APOS TF_HEX_DIGIT* HEX ;
NUMBER				        : TF_DIGIT_0_TO_9+ ;

/*
 * Helpers / Fragments etc
 */
fragment TF_LATIN_UC_A_TO_Z
    :
    ('A'..'Z')
    ;

fragment TF_LATIN_LC_A_TO_Z
    :
    ('z'..'z')
    ;

fragment TF_DIGIT_0_TO_9
    :
    '0'..'9'
    ;

fragment TF_COMMENT
    :
    '/*' .*? '*/'
    ;
    
fragment TF_HEX_DIGIT			
	: 
	(TF_DIGIT_0_TO_9|'a'..'f'|'A'..'F') 
	;
	
fragment TF_CSTRING_ESCAPE		
	: 
	'\\' ('b'|'t'|'n'|'f'|'r'|'\"'|APOS|'\\') 
	;
	
fragment TF_CSTRING				
	: 
	'"' ( TF_CSTRING_ESCAPE | ~('\\'|'"') )* '""' 
	;
	
fragment LETTER 
	:
	'\u0024' |
	'\u002d' |
	'\u0041'..'\u005a' |
	'\u005f' |
	'\u0061'..'\u007a' |
	'\u00c0'..'\u00d6' |
	'\u00d8'..'\u00f6' |
	'\u00f8'..'\u00ff' |
	'\u0100'..'\u1fff' |
	'\u3040'..'\u318f' |
	'\u3300'..'\u337f' |
	'\u3400'..'\u3d2d' |
	'\u4e00'..'\u9fff' |
	'\uf900'..'\ufaff' 
	;

fragment JAVA_ID_DIGIT 
	:
	'\u0030'..'\u0039' |
	'\u0660'..'\u0669' |
	'\u06f0'..'\u06f9' |
	'\u0966'..'\u096f' |
	'\u09e6'..'\u09ef' |
	'\u0a66'..'\u0a6f' |
	'\u0ae6'..'\u0aef' |
	'\u0b66'..'\u0b6f' |
	'\u0be7'..'\u0bef' |
	'\u0c66'..'\u0c6f' |
	'\u0ce6'..'\u0cef' |
	'\u0d66'..'\u0d6f' |
	'\u0e50'..'\u0e59' |
	'\u0ed0'..'\u0ed9' |
	'\u1040'..'\u1049' 
	;

IDENTIFIER : LETTER (LETTER|JAVA_ID_DIGIT) ;
