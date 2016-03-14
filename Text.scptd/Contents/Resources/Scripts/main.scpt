FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� Text -- commonly-used text processing commands

Notes: 

- When matching text item delimiters in text value, AppleScript uses the current scope's existing considering/ignoring case, diacriticals, hyphens, punctuation, white space and numeric strings settings; thus, wrapping a `search text` command in different considering/ignoring blocks can produce different results. For example, `search text "fud" for "F" will normally match the first character since AppleScript uses case-insensitive matching by default, whereas enclosing it in a `considering case` block will cause the same command to return zero matches. Conversely, `search text "f ud" for "fu"` will normally return zero matches as AppleScript considers white space by default, but when enclosed in an `ignoring white space` block will match the first three characters: "f u". This is how AppleScript is designed to work, but users need to be reminded of this as considering/ignoring blocks affect ALL script handlers called within that block, including nested calls (and all to any osax and application handlers that understand considering/ignoring attributes).

- Unlike AS text values, which preserve original Unicode normalization but ignore differences in form when comparing and counting, NSString and NSRegularExpression don't ignore normalization differences when comparing for equality. Therefore, handlers such as `search text`, `split text`, etc. that perform comparison operations on/using these Cocoa classes must normalize their input and pattern text first. (Be aware that this means that these commands may output text that uses different normalization form to input text; this shouldn't affect AppleScript itself, but might be a consideration when using that text elsewhere, e.g. in text files or scriptable apps.)

- Useful summary of NSString and Unicode: https://www.objc.io/issues/9-strings/unicode/


TO DO:

- decide if predefined considering/ignoring options in `search text`, etc. should consider or ignore diacriticals and numeric strings; once decided, use same combinations for List library's text comparator for consistency? (currently Text library's `case [in]sensitivity` options consider diacriticals for equality whereas List library ignores them for ordering)


- should `format text`'s `using` parameter also accept ASOC objects (ocid specifiers) that implement objectForKey:? (A. no: users should just use a script object as shim; similarly, a script object could be used to wrap a list or DictionaryObject if a default value should be inserted when a key isn't found)

- extended backreference syntax should really allow backslash-escaped �}� and �\� characters to appear within braces (currently these two characters are disallowed by _tokens pattern)

- fix inconsistency: `search text`'s `for` parameter doesn't allow list of text but `split text`'s `using` parameter does, even though both commands are supposed to support same matching options for consistency

- should line break normalization (in `normalize text` and `join paragraphs`) also recognize `Unicode line break`, `Unicode paragraph break` constants?

- need to decide exactly what constitutes a line break in `transform text`, and make sure both paragraph element and pattern based splitting are consistent (e.g. what about form feeds and Unicode line/paragraph breaks?)

- 10.11 provides NSString method:

	-(nullable NSString)stringByApplyingTransform:(NSString)transform reverse:(BOOL)reverse;

with following transforms (though note that any ICU transform name(s) can be used, concatenated as semicolon-delimited text):

NSStringTransformLatinToKatakana
NSStringTransformLatinToHiragana
NSStringTransformLatinToHangul
NSStringTransformLatinToArabic
NSStringTransformLatinToHebrew
NSStringTransformLatinToThai
NSStringTransformLatinToCyrillic
NSStringTransformLatinToGreek
NSStringTransformToLatin
NSStringTransformMandarinToLatin
NSStringTransformHiraganaToKatakana
NSStringTransformFullwidthToHalfwidth
NSStringTransformToXMLHex
NSStringTransformToUnicodeName
NSStringTransformStripCombiningMarks
NSStringTransformStripDiacritics

- e.g. could add `smart punctuation` and `ASCII punctuation` options to `transform text`

- use `standardized case`, etc rather than `normalized case` in `transform text`? 

     � 	 	!l   T e x t   - -   c o m m o n l y - u s e d   t e x t   p r o c e s s i n g   c o m m a n d s 
 
 N o t e s :   
 
 -   W h e n   m a t c h i n g   t e x t   i t e m   d e l i m i t e r s   i n   t e x t   v a l u e ,   A p p l e S c r i p t   u s e s   t h e   c u r r e n t   s c o p e ' s   e x i s t i n g   c o n s i d e r i n g / i g n o r i n g   c a s e ,   d i a c r i t i c a l s ,   h y p h e n s ,   p u n c t u a t i o n ,   w h i t e   s p a c e   a n d   n u m e r i c   s t r i n g s   s e t t i n g s ;   t h u s ,   w r a p p i n g   a   ` s e a r c h   t e x t `   c o m m a n d   i n   d i f f e r e n t   c o n s i d e r i n g / i g n o r i n g   b l o c k s   c a n   p r o d u c e   d i f f e r e n t   r e s u l t s .   F o r   e x a m p l e ,   ` s e a r c h   t e x t   " f u d "   f o r   " F "   w i l l   n o r m a l l y   m a t c h   t h e   f i r s t   c h a r a c t e r   s i n c e   A p p l e S c r i p t   u s e s   c a s e - i n s e n s i t i v e   m a t c h i n g   b y   d e f a u l t ,   w h e r e a s   e n c l o s i n g   i t   i n   a   ` c o n s i d e r i n g   c a s e `   b l o c k   w i l l   c a u s e   t h e   s a m e   c o m m a n d   t o   r e t u r n   z e r o   m a t c h e s .   C o n v e r s e l y ,   ` s e a r c h   t e x t   " f   u d "   f o r   " f u " `   w i l l   n o r m a l l y   r e t u r n   z e r o   m a t c h e s   a s   A p p l e S c r i p t   c o n s i d e r s   w h i t e   s p a c e   b y   d e f a u l t ,   b u t   w h e n   e n c l o s e d   i n   a n   ` i g n o r i n g   w h i t e   s p a c e `   b l o c k   w i l l   m a t c h   t h e   f i r s t   t h r e e   c h a r a c t e r s :   " f   u " .   T h i s   i s   h o w   A p p l e S c r i p t   i s   d e s i g n e d   t o   w o r k ,   b u t   u s e r s   n e e d   t o   b e   r e m i n d e d   o f   t h i s   a s   c o n s i d e r i n g / i g n o r i n g   b l o c k s   a f f e c t   A L L   s c r i p t   h a n d l e r s   c a l l e d   w i t h i n   t h a t   b l o c k ,   i n c l u d i n g   n e s t e d   c a l l s   ( a n d   a l l   t o   a n y   o s a x   a n d   a p p l i c a t i o n   h a n d l e r s   t h a t   u n d e r s t a n d   c o n s i d e r i n g / i g n o r i n g   a t t r i b u t e s ) . 
 
 -   U n l i k e   A S   t e x t   v a l u e s ,   w h i c h   p r e s e r v e   o r i g i n a l   U n i c o d e   n o r m a l i z a t i o n   b u t   i g n o r e   d i f f e r e n c e s   i n   f o r m   w h e n   c o m p a r i n g   a n d   c o u n t i n g ,   N S S t r i n g   a n d   N S R e g u l a r E x p r e s s i o n   d o n ' t   i g n o r e   n o r m a l i z a t i o n   d i f f e r e n c e s   w h e n   c o m p a r i n g   f o r   e q u a l i t y .   T h e r e f o r e ,   h a n d l e r s   s u c h   a s   ` s e a r c h   t e x t ` ,   ` s p l i t   t e x t ` ,   e t c .   t h a t   p e r f o r m   c o m p a r i s o n   o p e r a t i o n s   o n / u s i n g   t h e s e   C o c o a   c l a s s e s   m u s t   n o r m a l i z e   t h e i r   i n p u t   a n d   p a t t e r n   t e x t   f i r s t .   ( B e   a w a r e   t h a t   t h i s   m e a n s   t h a t   t h e s e   c o m m a n d s   m a y   o u t p u t   t e x t   t h a t   u s e s   d i f f e r e n t   n o r m a l i z a t i o n   f o r m   t o   i n p u t   t e x t ;   t h i s   s h o u l d n ' t   a f f e c t   A p p l e S c r i p t   i t s e l f ,   b u t   m i g h t   b e   a   c o n s i d e r a t i o n   w h e n   u s i n g   t h a t   t e x t   e l s e w h e r e ,   e . g .   i n   t e x t   f i l e s   o r   s c r i p t a b l e   a p p s . ) 
 
 -   U s e f u l   s u m m a r y   o f   N S S t r i n g   a n d   U n i c o d e :   h t t p s : / / w w w . o b j c . i o / i s s u e s / 9 - s t r i n g s / u n i c o d e / 
 
 
 T O   D O : 
 
 -   d e c i d e   i f   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   i n   ` s e a r c h   t e x t ` ,   e t c .   s h o u l d   c o n s i d e r   o r   i g n o r e   d i a c r i t i c a l s   a n d   n u m e r i c   s t r i n g s ;   o n c e   d e c i d e d ,   u s e   s a m e   c o m b i n a t i o n s   f o r   L i s t   l i b r a r y ' s   t e x t   c o m p a r a t o r   f o r   c o n s i s t e n c y ?   ( c u r r e n t l y   T e x t   l i b r a r y ' s   ` c a s e   [ i n ] s e n s i t i v i t y `   o p t i o n s   c o n s i d e r   d i a c r i t i c a l s   f o r   e q u a l i t y   w h e r e a s   L i s t   l i b r a r y   i g n o r e s   t h e m   f o r   o r d e r i n g ) 
 
 
 -   s h o u l d   ` f o r m a t   t e x t ` ' s   ` u s i n g `   p a r a m e t e r   a l s o   a c c e p t   A S O C   o b j e c t s   ( o c i d   s p e c i f i e r s )   t h a t   i m p l e m e n t   o b j e c t F o r K e y : ?   ( A .   n o :   u s e r s   s h o u l d   j u s t   u s e   a   s c r i p t   o b j e c t   a s   s h i m ;   s i m i l a r l y ,   a   s c r i p t   o b j e c t   c o u l d   b e   u s e d   t o   w r a p   a   l i s t   o r   D i c t i o n a r y O b j e c t   i f   a   d e f a u l t   v a l u e   s h o u l d   b e   i n s e r t e d   w h e n   a   k e y   i s n ' t   f o u n d ) 
 
 -   e x t e n d e d   b a c k r e f e r e n c e   s y n t a x   s h o u l d   r e a l l y   a l l o w   b a c k s l a s h - e s c a p e d    }    a n d    \    c h a r a c t e r s   t o   a p p e a r   w i t h i n   b r a c e s   ( c u r r e n t l y   t h e s e   t w o   c h a r a c t e r s   a r e   d i s a l l o w e d   b y   _ t o k e n s   p a t t e r n ) 
 
 -   f i x   i n c o n s i s t e n c y :   ` s e a r c h   t e x t ` ' s   ` f o r `   p a r a m e t e r   d o e s n ' t   a l l o w   l i s t   o f   t e x t   b u t   ` s p l i t   t e x t ` ' s   ` u s i n g `   p a r a m e t e r   d o e s ,   e v e n   t h o u g h   b o t h   c o m m a n d s   a r e   s u p p o s e d   t o   s u p p o r t   s a m e   m a t c h i n g   o p t i o n s   f o r   c o n s i s t e n c y 
 
 -   s h o u l d   l i n e   b r e a k   n o r m a l i z a t i o n   ( i n   ` n o r m a l i z e   t e x t `   a n d   ` j o i n   p a r a g r a p h s ` )   a l s o   r e c o g n i z e   ` U n i c o d e   l i n e   b r e a k ` ,   ` U n i c o d e   p a r a g r a p h   b r e a k `   c o n s t a n t s ? 
 
 -   n e e d   t o   d e c i d e   e x a c t l y   w h a t   c o n s t i t u t e s   a   l i n e   b r e a k   i n   ` t r a n s f o r m   t e x t ` ,   a n d   m a k e   s u r e   b o t h   p a r a g r a p h   e l e m e n t   a n d   p a t t e r n   b a s e d   s p l i t t i n g   a r e   c o n s i s t e n t   ( e . g .   w h a t   a b o u t   f o r m   f e e d s   a n d   U n i c o d e   l i n e / p a r a g r a p h   b r e a k s ? ) 
 
 -   1 0 . 1 1   p r o v i d e s   N S S t r i n g   m e t h o d : 
 
 	 - ( n u l l a b l e   N S S t r i n g ) s t r i n g B y A p p l y i n g T r a n s f o r m : ( N S S t r i n g ) t r a n s f o r m   r e v e r s e : ( B O O L ) r e v e r s e ; 
 
 w i t h   f o l l o w i n g   t r a n s f o r m s   ( t h o u g h   n o t e   t h a t   a n y   I C U   t r a n s f o r m   n a m e ( s )   c a n   b e   u s e d ,   c o n c a t e n a t e d   a s   s e m i c o l o n - d e l i m i t e d   t e x t ) : 
 
 N S S t r i n g T r a n s f o r m L a t i n T o K a t a k a n a 
 N S S t r i n g T r a n s f o r m L a t i n T o H i r a g a n a 
 N S S t r i n g T r a n s f o r m L a t i n T o H a n g u l 
 N S S t r i n g T r a n s f o r m L a t i n T o A r a b i c 
 N S S t r i n g T r a n s f o r m L a t i n T o H e b r e w 
 N S S t r i n g T r a n s f o r m L a t i n T o T h a i 
 N S S t r i n g T r a n s f o r m L a t i n T o C y r i l l i c 
 N S S t r i n g T r a n s f o r m L a t i n T o G r e e k 
 N S S t r i n g T r a n s f o r m T o L a t i n 
 N S S t r i n g T r a n s f o r m M a n d a r i n T o L a t i n 
 N S S t r i n g T r a n s f o r m H i r a g a n a T o K a t a k a n a 
 N S S t r i n g T r a n s f o r m F u l l w i d t h T o H a l f w i d t h 
 N S S t r i n g T r a n s f o r m T o X M L H e x 
 N S S t r i n g T r a n s f o r m T o U n i c o d e N a m e 
 N S S t r i n g T r a n s f o r m S t r i p C o m b i n i n g M a r k s 
 N S S t r i n g T r a n s f o r m S t r i p D i a c r i t i c s 
 
 -   e . g .   c o u l d   a d d   ` s m a r t   p u n c t u a t i o n `   a n d   ` A S C I I   p u n c t u a t i o n `   o p t i o n s   t o   ` t r a n s f o r m   t e x t ` 
 
 -   u s e   ` s t a n d a r d i z e d   c a s e ` ,   e t c   r a t h e r   t h a n   ` n o r m a l i z e d   c a s e `   i n   ` t r a n s f o r m   t e x t ` ?   
 
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      record types     �        r e c o r d   t y p e s   ! " ! l     ��������  ��  ��   "  # $ # j    �� %�� (0 _unmatchedtexttype _UnmatchedTextType % m    ��
�� 
TxtU $  & ' & j    �� (�� $0 _matchedtexttype _MatchedTextType ( m    ��
�� 
TxtM '  ) * ) j    �� +�� &0 _matchedgrouptype _MatchedGroupType + m    ��
�� 
TxtG *  , - , l     ��������  ��  ��   -  . / . l     ��������  ��  ��   /  0 1 0 l     �� 2 3��   2 J D--------------------------------------------------------------------    3 � 4 4 � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 1  5 6 5 l     �� 7 8��   7   support    8 � 9 9    s u p p o r t 6  : ; : l     ��������  ��  ��   ;  < = < l      > ? @ > j     &�� A�� 0 _support   A N     % B B 4     $�� C
�� 
scpt C m   " # D D � E E  T y p e S u p p o r t ? "  used for parameter checking    @ � F F 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g =  G H G l     ��������  ��  ��   H  I J I l     ��������  ��  ��   J  K L K i  ' * M N M I      �� O���� 
0 _error   O  P Q P o      ���� 0 handlername handlerName Q  R S R o      ���� 0 etext eText S  T U T o      ���� 0 enumber eNumber U  V W V o      ���� 0 efrom eFrom W  X�� X o      ���� 
0 eto eTo��  ��   N n     Y Z Y I    �� [���� &0 throwcommanderror throwCommandError [  \ ] \ m     ^ ^ � _ _  T e x t ]  ` a ` o    ���� 0 handlername handlerName a  b c b o    ���� 0 etext eText c  d e d o    	���� 0 enumber eNumber e  f g f o   	 
���� 0 efrom eFrom g  h�� h o   
 ���� 
0 eto eTo��  ��   Z o     ���� 0 _support   L  i j i l     ��������  ��  ��   j  k l k l     ��������  ��  ��   l  m n m l     �� o p��   o J D--------------------------------------------------------------------    p � q q � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - n  r s r l     ��������  ��  ��   s  t u t i  + . v w v I      �� x���� B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter x  y z y o      ���� 0 patterntext patternText z  {�� { o      ���� 0 parametername parameterName��  ��   w l     | } ~ | L        n     � � � I    �� ����� @0 asnsregularexpressionparameter asNSRegularExpressionParameter �  � � � o    ���� 0 patterntext patternText �  � � � l 	   ����� � l    ����� � [     � � � [     � � � [     � � � l   
 ����� � e    
 � � n   
 � � � o    	���� H0 "nsregularexpressioncaseinsensitive "NSRegularExpressionCaseInsensitive � m    ��
�� misccura��  ��   � l 	 
  ����� � l  
  ����� � e   
  � � n  
  � � � o    ���� L0 $nsregularexpressionanchorsmatchlines $NSRegularExpressionAnchorsMatchLines � m   
 ��
�� misccura��  ��  ��  ��   � l 	   ����� � l    ����� � e     � � n    � � � o    ���� Z0 +nsregularexpressiondotmatcheslineseparators +NSRegularExpressionDotMatchesLineSeparators � m    ��
�� misccura��  ��  ��  ��   � l 	   ����� � l    ����� � e     � � n    � � � o    ���� Z0 +nsregularexpressionuseunicodewordboundaries +NSRegularExpressionUseUnicodeWordBoundaries � m    ��
�� misccura��  ��  ��  ��  ��  ��  ��  ��   �  ��� � o    ���� 0 parametername parameterName��  ��   � o     ���� 0 _support   } H B returns a regexp object with `(?imsw)` options enabled by default    ~ � � � �   r e t u r n s   a   r e g e x p   o b j e c t   w i t h   ` ( ? i m s w ) `   o p t i o n s   e n a b l e d   b y   d e f a u l t u  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l      � � � � j   / 1�� ��� 0 _tokens   � m   / 0 � � � � �" 
 \ \ 	 	 	 	 	 	 	 	 #   m a t c h   a   b a c k s l a s h   e s c a p e ,   f o l l o w e d   b y   o n e   o f : 
           ( ? : ( n | r | t | \ \ ) 	 	 	 #   n e w l i n e ,   r e t u r n ,   t a b   o r   b a c k s l a s h   c h a r a c t e r 
       |   (   [ 0 - 9 ]   ) 	 	 	 	 	 #   b a c k s l a s h   +   s i n g l e   d i g i t   ( i n s e r t i o n   i n d e x ) 
       |   \ {   ( [ ^ } { \ \ ] * )   \ } 	 	 #   b a c k s l a s h   +   a n y   t e x t   i n   b r a c e s   ( i n s e r t i o n   i n d e x   o r   n a m e ) 
 ) � � � note: \N{...}, \u1234, and \U00123456 escape sequences are processed separately (via ICU transforms); any other backslash sequences are unrecognized and left unchanged    � � � �P   n o t e :   \ N { . . . } ,   \ u 1 2 3 4 ,   a n d   \ U 0 0 1 2 3 4 5 6   e s c a p e   s e q u e n c e s   a r e   p r o c e s s e d   s e p a r a t e l y   ( v i a   I C U   t r a n s f o r m s ) ;   a n y   o t h e r   b a c k s l a s h   s e q u e n c e s   a r e   u n r e c o g n i z e d   a n d   l e f t   u n c h a n g e d �  � � � l     ��������  ��  ��   �  � � � i  2 5 � � � I      �� ����� (0 _parsetemplatetext _parseTemplateText �  ��� � o      ���� 0 templatetext templateText��  ��   � l   c � � � � k    c � �  � � � r     
 � � � n     � � � I    �� ����� &0 stringwithstring_ stringWithString_ �  ��� � o    �� 0 templatetext templateText��  ��   � n     � � � o    �~�~ 0 nsstring NSString � m     �}
�} misccura � o      �|�| 0 
asocstring 
asocString �  � � � r     � � � n    � � � I    �{ ��z�{ Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_ �  � � � l 
   ��y�x � o    �w�w 0 _tokens  �y  �x   �  � � � l    ��v�u � e     � � n    � � � o    �t�t ^0 -nsregularexpressionallowcommentsandwhitespace -NSRegularExpressionAllowCommentsAndWhitespace � m    �s
�s misccura�v  �u   �  ��r � l    ��q�p � m    �o
�o 
msng�q  �p  �r  �z   � n    � � � o    �n�n *0 nsregularexpression NSRegularExpression � m    �m
�m misccura � o      �l�l 0 asocpattern asocPattern �  � � � r    " � � � m     �k�k   � o      �j�j &0 asocnonmatchstart asocNonMatchStart �  � � � r   # ' � � � J   # %�i�i   � o      �h�h 0 
resultlist 
resultList �  � � � r   ( 9 � � � n  ( 7 � � � I   ) 7�g ��f�g @0 matchesinstring_options_range_ matchesInString_options_range_ �  � � � o   ) *�e�e 0 
asocstring 
asocString �  � � � m   * +�d�d   �  ��c � J   + 3 � �  � � � m   + ,�b�b   �  ��a � n  , 1 � � � I   - 1�`�_�^�` 
0 length  �_  �^   � o   , -�]�] 0 
asocstring 
asocString�a  �c  �f   � o   ( )�\�\ 0 asocpattern asocPattern � o      �[�[  0 asocmatcharray asocMatchArray �  � � � r   : = � � � m   : ;�Z
�Z boovfals � o      �Y�Y 0 
concatnext 
concatNext �  � � � Y   >0 ��X � ��W � k   N+    r   N V l  N T�V�U n  N T I   O T�T�S�T  0 objectatindex_ objectAtIndex_ 	�R	 o   O P�Q�Q 0 i  �R  �S   o   N O�P�P  0 asocmatcharray asocMatchArray�V  �U   o      �O�O 0 	asocmatch 	asocMatch 

 r   W _ l  W ]�N�M n  W ] I   X ]�L�K�L 0 rangeatindex_ rangeAtIndex_ �J m   X Y�I�I  �J  �K   o   W X�H�H 0 	asocmatch 	asocMatch�N  �M   o      �G�G  0 asocmatchrange asocMatchRange  l  ` `�F�F   T N get text before match, convert entities to characters, and add to result list    � �   g e t   t e x t   b e f o r e   m a t c h ,   c o n v e r t   e n t i t i e s   t o   c h a r a c t e r s ,   a n d   a d d   t o   r e s u l t   l i s t  r   ` g n  ` e I   a e�E�D�C�E 0 location  �D  �C   o   ` a�B�B  0 asocmatchrange asocMatchRange o      �A�A  0 asocmatchstart asocMatchStart  l  h  !"  r   h #$# c   h }%&% l  h y'�@�?' n  h y()( I   s y�>*�=�> H0 "stringbyapplyingtransform_reverse_ "stringByApplyingTransform_reverse_* +,+ l  s t-�<�;- m   s t.. �// $ H e x - A n y / C ; N a m e - A n y�<  �;  , 0�:0 m   t u�9
�9 boovfals�:  �=  ) l  h s1�8�71 n  h s232 I   i s�64�5�6 *0 substringwithrange_ substringWithRange_4 5�45 J   i o66 787 o   i j�3�3 &0 asocnonmatchstart asocNonMatchStart8 9�29 l  j m:�1�0: \   j m;<; o   j k�/�/  0 asocmatchstart asocMatchStart< o   k l�.�. &0 asocnonmatchstart asocNonMatchStart�1  �0  �2  �4  �5  3 o   h i�-�- 0 
asocstring 
asocString�8  �7  �@  �?  & m   y |�,
�, 
ctxt$ o      �+�+ 0 nonmatchtext nonMatchText! O I convert \u1234, \U00123456, \N{CHARNAME} escapes to specified characters   " �== �   c o n v e r t   \ u 1 2 3 4 ,   \ U 0 0 1 2 3 4 5 6 ,   \ N { C H A R N A M E }   e s c a p e s   t o   s p e c i f i e d   c h a r a c t e r s >?> Z   � �@A�*B@ o   � ��)�) 0 
concatnext 
concatNextA l  � �CDEC k   � �FF GHG r   � �IJI b   � �KLK n   � �MNM 4  � ��(O
�( 
cobjO m   � ��'�'��N o   � ��&�& 0 
resultlist 
resultListL o   � ��%�% 0 nonmatchtext nonMatchTextJ n      PQP 4  � ��$R
�$ 
cobjR m   � ��#�#��Q o   � ��"�" 0 
resultlist 
resultListH S�!S r   � �TUT m   � �� 
�  boovfalsU o      �� 0 
concatnext 
concatNext�!  D 8 2 only item indexes/names should be at even indexes   E �VV d   o n l y   i t e m   i n d e x e s / n a m e s   s h o u l d   b e   a t   e v e n   i n d e x e s�*  B r   � �WXW o   � ��� 0 nonmatchtext nonMatchTextX n      YZY  ;   � �Z o   � ��� 0 
resultlist 
resultList? [\[ r   � �]^] [   � �_`_ o   � ���  0 asocmatchstart asocMatchStart` l  � �a��a n  � �bcb I   � ����� 
0 length  �  �  c o   � ���  0 asocmatchrange asocMatchRange�  �  ^ o      �� &0 asocnonmatchstart asocNonMatchStart\ ded l  � ��fg�  f L F get the matched text (escaped linefeed, etc. or insertion index/name)   g �hh �   g e t   t h e   m a t c h e d   t e x t   ( e s c a p e d   l i n e f e e d ,   e t c .   o r   i n s e r t i o n   i n d e x / n a m e )e i�i Y   �+j�kl�j l  �&mnom k   �&pp qrq r   � �sts l  � �u��u n  � �vwv I   � ��x�� 0 rangeatindex_ rangeAtIndex_x y�y o   � ��� 0 j  �  �  w o   � ��
�
 0 	asocmatch 	asocMatch�  �  t o      �	�	  0 asocgrouprange asocGroupRanger z�z Z   �&{|��{ ?   � �}~} n  � �� I   � ����� 
0 length  �  �  � o   � ���  0 asocgrouprange asocGroupRange~ m   � ���  | k   �"�� ��� r   � ���� l  � ��� ��� n  � ���� I   � �������� *0 substringwithrange_ substringWithRange_� ���� o   � �����  0 asocgrouprange asocGroupRange��  ��  � o   � ����� 0 
asocstring 
asocString�   ��  � o      ���� "0 asocmatchstring asocMatchString� ��� r   � ���� c   � ���� o   � ����� "0 asocmatchstring asocMatchString� m   � ���
�� 
ctxt� o      ���� 0 itemtext itemText� ��� Z   � ������ =   � ���� o   � ����� 0 j  � m   � ����� � k   ��� ��� r   ���� b   ���� n   � ���� 4  � ����
�� 
cobj� m   � �������� o   � ����� 0 
resultlist 
resultList� l  ������� n   ���� 4   ����
�� 
cobj� l  ������� I  ������ z����
�� .sysooffslong    ��� null
�� misccura��  � ����
�� 
psof� o   � ����� 0 itemtext itemText� �����
�� 
psin� m  �� ���  n r t \��  ��  ��  � J   � ��� ��� 1   � ���
�� 
lnfd� ��� o   � ���
�� 
ret � ��� 1   � ���
�� 
tab � ���� m   � ��� ���  \��  ��  ��  � n      ��� 4 ���
�� 
cobj� m  ������� o  ���� 0 
resultlist 
resultList� ���� r  ��� m  ��
�� boovtrue� o      ���� 0 
concatnext 
concatNext��  ��  � r   ��� o  ���� 0 itemtext itemText� n      ���  ;  � o  ���� 0 
resultlist 
resultList� ����  S  !"��  �  �  �  n G A _tokens defines 3 groups (index 0 is full match, so ignore that)   o ��� �   _ t o k e n s   d e f i n e s   3   g r o u p s   ( i n d e x   0   i s   f u l l   m a t c h ,   s o   i g n o r e   t h a t )� 0 j  k m   � ����� l m   � ����� �  �  �X 0 i   � m   A B����   � \   B I��� l  B G������ n  B G��� I   C G�������� 	0 count  ��  ��  � o   B C����  0 asocmatcharray asocMatchArray��  ��  � m   G H���� �W   � ��� l 1E���� r  1E��� c  1C��� l 1?������ n 1?��� I  7?������� H0 "stringbyapplyingtransform_reverse_ "stringByApplyingTransform_reverse_� ��� l 7:������ m  7:�� ��� $ H e x - A n y / C ; N a m e - A n y��  ��  � ���� m  :;��
�� boovfals��  ��  � l 17������ n 17��� I  27������� *0 substringfromindex_ substringFromIndex_� ���� o  23���� &0 asocnonmatchstart asocNonMatchStart��  ��  � o  12���� 0 
asocstring 
asocString��  ��  ��  ��  � m  ?B��
�� 
ctxt� o      ���� 0 itemtext itemText� ( " trailing text; convert and append   � ��� D   t r a i l i n g   t e x t ;   c o n v e r t   a n d   a p p e n d� ��� Z  F`������ o  FG���� 0 
concatnext 
concatNext� r  JY��� b  JR��� n  JP��� 4 KP���
�� 
cobj� m  NO������� o  JK���� 0 
resultlist 
resultList� o  PQ���� 0 itemtext itemText� n      ��� 4 SX���
�� 
cobj� m  VW������� o  RS���� 0 
resultlist 
resultList��  � r  \`��� o  \]���� 0 itemtext itemText� n      ���  ;  ^_� o  ]^���� 0 
resultlist 
resultList� ���� L  ac�� o  ab���� 0 
resultlist 
resultList��   � convert template text containing backslashed special characters (\t, \u1234, \3, etc.) to a list of text items of form {text, index or name, ..., text}, where every 2nd item is an unprocessed back reference; used by the _parseSearchTemplate and _parseFormatTemplate handlers    � ���&   c o n v e r t   t e m p l a t e   t e x t   c o n t a i n i n g   b a c k s l a s h e d   s p e c i a l   c h a r a c t e r s   ( \ t ,   \ u 1 2 3 4 ,   \ 3 ,   e t c . )   t o   a   l i s t   o f   t e x t   i t e m s   o f   f o r m   { t e x t ,   i n d e x   o r   n a m e ,   . . . ,   t e x t } ,   w h e r e   e v e r y   2 n d   i t e m   i s   a n   u n p r o c e s s e d   b a c k   r e f e r e n c e ;   u s e d   b y   t h e   _ p a r s e S e a r c h T e m p l a t e   a n d   _ p a r s e F o r m a t T e m p l a t e   h a n d l e r s � ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� � � l     ����   B < parse template text used in `search text` and `format text`    � x   p a r s e   t e m p l a t e   t e x t   u s e d   i n   ` s e a r c h   t e x t `   a n d   ` f o r m a t   t e x t `   l     ����   F @ (note: last parsed template is cached for more efficient reuse)    � �   ( n o t e :   l a s t   p a r s e d   t e m p l a t e   i s   c a c h e d   f o r   m o r e   e f f i c i e n t   r e u s e ) 	
	 l     ��������  ��  ��  
  j   6 :���� :0 _previoussearchtemplatetext _previousSearchTemplateText m   6 9 �    j   ; ?���� F0 !_previoussearchtemplateparsedtext !_previousSearchTemplateParsedText m   ; > �    l     ��������  ��  ��    i  @ C I      ������ ,0 _parsesearchtemplate _parseSearchTemplate �� o      ���� 0 templatetext templateText��  ��   P     � k    �   !"! Z    �#$����# >   %&% o    ���� 0 templatetext templateText& o    ���� :0 _previoussearchtemplatetext _previousSearchTemplateText$ k    �'' ()( r    *+* I    ��,���� (0 _parsetemplatetext _parseTemplateText, -��- o    ���� 0 templatetext templateText��  ��  + o      ���� 0 templateitems templateItems) ./. Y    �0��12��0 k   % �33 454 r   % +676 n   % )898 4   & )��:
�� 
cobj: o   ' (���� 0 i  9 o   % &���� 0 templateitems templateItems7 o      ���� 0 itemtext itemText5 ;��; Z   , �<=��>< =   , 1?@? `   , /ABA o   , -���� 0 i  B m   - .���� @ m   / 0����  = l  4 hCDEC k   4 hFF GHG r   4 ;IJI b   4 9KLK m   4 5MM �NN  $L l  5 8O����O c   5 8PQP o   5 6���� 0 itemtext itemTextQ m   6 7��
�� 
long��  ��  J o      ���� 0 itemtext itemTextH RSR r   < DTUT n   < BVWV 4   = B��X
�� 
cobjX l  > AY����Y [   > AZ[Z o   > ?���� 0 i  [ m   ? @�� ��  ��  W o   < =�~�~ 0 templateitems templateItemsU o      �}�} 0 nextitem nextItemS \]\ l  E a^_`^ Z  E aab�|�{a F   E Ucdc ?   E Jefe n  E Hghg 1   F H�z
�z 
lengh o   E F�y�y 0 nextitem nextItemf m   H I�x�x  d E  M Siji m   M Nkk �ll  1 2 3 4 5 6 7 8 9 0j n  N Rmnm 4   O R�wo
�w 
cha o m   P Q�v�v n o   N O�u�u 0 nextitem nextItemb r   X ]pqp b   X [rsr o   X Y�t�t 0 itemtext itemTexts m   Y Ztt �uu  \q o      �s�s 0 itemtext itemText�|  �{  _ 8 2 make sure ICT template doesn't consume next digit   ` �vv d   m a k e   s u r e   I C T   t e m p l a t e   d o e s n ' t   c o n s u m e   n e x t   d i g i t] w�rw r   b hxyx o   b c�q�q 0 itemtext itemTexty n      z{z 4   d g�p|
�p 
cobj| o   e f�o�o 0 i  { o   c d�n�n 0 templateitems templateItems�r  D #  substitute integer N with $N   E �}} :   s u b s t i t u t e   i n t e g e r   N   w i t h   $ N��  > l  k �~�~ k   k ��� ��� r   k w��� n  k u��� I   p u�m��l�m 0 
asnsstring 
asNSString� ��k� o   p q�j�j 0 itemtext itemText�k  �l  � o   k p�i�i 0 _support  � o      �h�h 0 
asocstring 
asocString� ��g� r   x ���� c   x ���� l  x ���f�e� n  x ���� I   y ��d��c�d �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_� ��� m   y z�� ���  ( [ \ $ ] )� ��� m   z {�� ���  \ \ $ 1� ��� l  { ~��b�a� n  { ~��� o   | ~�`�` 60 nsregularexpressionsearch NSRegularExpressionSearch� m   { |�_
�_ misccura�b  �a  � ��^� J   ~ ��� ��� m   ~ �]�]  � ��\� n   ���� I   � ��[�Z�Y�[ 
0 length  �Z  �Y  � o    ��X�X 0 
asocstring 
asocString�\  �^  �c  � o   x y�W�W 0 
asocstring 
asocString�f  �e  � m   � ��V
�V 
ctxt� n      ��� 4   � ��U�
�U 
cobj� o   � ��T�T 0 i  � o   � ��S�S 0 templateitems templateItems�g     re-escape '/' and '$'   � ��� ,   r e - e s c a p e   ' / '   a n d   ' $ '��  �� 0 i  1 m    �R�R 2 n    ��� 1    �Q
�Q 
leng� o    �P�P 0 templateitems templateItems��  / ��� r   � ���� I   � ��O��N�O 0 	_jointext 	_joinText� ��� o   � ��M�M 0 templateitems templateItems� ��L� m   � ��� ���  �L  �N  � o      �K�K F0 !_previoussearchtemplateparsedtext !_previousSearchTemplateParsedText� ��J� r   � ���� o   � ��I�I 0 templatetext templateText� o      �H�H :0 _previoussearchtemplatetext _previousSearchTemplateText�J  ��  ��  " ��G� L   � ��� o   � ��F�F F0 !_previoussearchtemplateparsedtext !_previousSearchTemplateParsedText�G   �E�
�E conscase� �D�
�D consdiac� �C�
�C conshyph� �B�
�B conspunc� �A�@
�A conswhit�@   �?�>
�? consnume�>   ��� l     �=�<�;�=  �<  �;  � ��� l     �:�9�8�:  �9  �8  � ��� j   D H�7��7 :0 _previousformattemplatetext _previousFormatTemplateText� m   D G�� ���  � ��� l     ���� j   I M�6��6 H0 "_previousformattemplateparseditems "_previousFormatTemplateParsedItems� m   I L�� ���  � 4 . list of form {text, index or name, ..., text}   � ��� \   l i s t   o f   f o r m   { t e x t ,   i n d e x   o r   n a m e ,   . . . ,   t e x t }� ��� l     �5�4�3�5  �4  �3  � ��� i  N Q��� I      �2��1�2 ,0 _parseformattemplate _parseFormatTemplate� ��0� o      �/�/ 0 templatetext templateText�0  �1  � P     /���� k    .�� ��� Z    '���.�-� >   ��� o    �,�, 0 templatetext templateText� o    �+�+ :0 _previousformattemplatetext _previousFormatTemplateText� k    #�� ��� r    ��� I    �*��)�* (0 _parsetemplatetext _parseTemplateText� ��(� o    �'�' 0 templatetext templateText�(  �)  � o      �&�& H0 "_previousformattemplateparseditems "_previousFormatTemplateParsedItems� ��%� r    #��� o    �$�$ 0 templatetext templateText� o      �#�# :0 _previousformattemplatetext _previousFormatTemplateText�%  �.  �-  � ��"� L   ( .�� o   ( -�!�! H0 "_previousformattemplateparseditems "_previousFormatTemplateParsedItems�"  � � �
�  conscase� ��
� consdiac� ��
� conshyph� ��
� conspunc� ��
� conswhit�  � ��
� consnume�  � ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l     ����  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �� �  �   Find and Replace Suite     � .   F i n d   a n d   R e p l a c e   S u i t e�  l     ����  �  �    l     ��     find pattern    �    f i n d   p a t t e r n 	
	 l     ���
�  �  �
  
  i  R U I      �	��	 $0 _matchinforecord _matchInfoRecord  o      �� 0 
asocstring 
asocString  o      ��  0 asocmatchrange asocMatchRange  o      �� 0 
textoffset 
textOffset � o      �� 0 
recordtype 
recordType�  �   k     #  r     
 c      l    �� n      I    � !���  *0 substringwithrange_ substringWithRange_! "��" o    ����  0 asocmatchrange asocMatchRange��  ��    o     ���� 0 
asocstring 
asocString�  �   m    ��
�� 
ctxt o      ���� 0 	foundtext 	foundText #$# l   %&'% r    ()( [    *+* o    ���� 0 
textoffset 
textOffset+ l   ,����, n    -.- 1    ��
�� 
leng. o    ���� 0 	foundtext 	foundText��  ��  ) o      ����  0 nexttextoffset nextTextOffset& : 4 calculate the start index of the next AS text range   ' �// h   c a l c u l a t e   t h e   s t a r t   i n d e x   o f   t h e   n e x t   A S   t e x t   r a n g e$ 010 l   ��23��  2
 note: record keys are identifiers, not keywords, as 1. library-defined keywords are a huge pain to use outside of `tell script...` blocks and 2. importing the library's terminology into the global namespace via `use script...` is an excellent way to create keyword conflicts; only the class value is a keyword since Script Editor/OSAKit don't correctly handle records that use non-typename values (e.g. `{class:"matched text",...}`), but this shouldn't impact usability as it's really only used for informational purposes   3 �44   n o t e :   r e c o r d   k e y s   a r e   i d e n t i f i e r s ,   n o t   k e y w o r d s ,   a s   1 .   l i b r a r y - d e f i n e d   k e y w o r d s   a r e   a   h u g e   p a i n   t o   u s e   o u t s i d e   o f   ` t e l l   s c r i p t . . . `   b l o c k s   a n d   2 .   i m p o r t i n g   t h e   l i b r a r y ' s   t e r m i n o l o g y   i n t o   t h e   g l o b a l   n a m e s p a c e   v i a   ` u s e   s c r i p t . . . `   i s   a n   e x c e l l e n t   w a y   t o   c r e a t e   k e y w o r d   c o n f l i c t s ;   o n l y   t h e   c l a s s   v a l u e   i s   a   k e y w o r d   s i n c e   S c r i p t   E d i t o r / O S A K i t   d o n ' t   c o r r e c t l y   h a n d l e   r e c o r d s   t h a t   u s e   n o n - t y p e n a m e   v a l u e s   ( e . g .   ` { c l a s s : " m a t c h e d   t e x t " , . . . } ` ) ,   b u t   t h i s   s h o u l d n ' t   i m p a c t   u s a b i l i t y   a s   i t ' s   r e a l l y   o n l y   u s e d   f o r   i n f o r m a t i o n a l   p u r p o s e s1 5��5 L    #66 J    "77 898 K    :: ��;<
�� 
pcls; o    ���� 0 
recordtype 
recordType< ��=>�� 0 
startindex 
startIndex= o    ���� 0 
textoffset 
textOffset> ��?@�� 0 endindex endIndex? \    ABA o    ����  0 nexttextoffset nextTextOffsetB m    ���� @ ��C���� 0 	foundtext 	foundTextC o    ���� 0 	foundtext 	foundText��  9 D��D o     ����  0 nexttextoffset nextTextOffset��  ��   EFE l     ��������  ��  ��  F GHG l     ��������  ��  ��  H IJI i  V YKLK I      ��M���� 0 _matchrecords _matchRecordsM NON o      ���� 0 
asocstring 
asocStringO PQP o      ����  0 asocmatchrange asocMatchRangeQ RSR o      ����  0 asocstartindex asocStartIndexS TUT o      ���� 0 
textoffset 
textOffsetU VWV o      ���� (0 nonmatchrecordtype nonMatchRecordTypeW X��X o      ���� "0 matchrecordtype matchRecordType��  ��  L k     VYY Z[Z l     ��\]��  \TN important: NSString character indexes aren't guaranteed to be same as AS character indexes (AS sensibly counts glyphs but NSString only counts UTF16 codepoints, and a glyph may be composed of more than one codepoint), so reconstruct both non-matching and matching AS text values, and calculate accurate AS character ranges from those   ] �^^�   i m p o r t a n t :   N S S t r i n g   c h a r a c t e r   i n d e x e s   a r e n ' t   g u a r a n t e e d   t o   b e   s a m e   a s   A S   c h a r a c t e r   i n d e x e s   ( A S   s e n s i b l y   c o u n t s   g l y p h s   b u t   N S S t r i n g   o n l y   c o u n t s   U T F 1 6   c o d e p o i n t s ,   a n d   a   g l y p h   m a y   b e   c o m p o s e d   o f   m o r e   t h a n   o n e   c o d e p o i n t ) ,   s o   r e c o n s t r u c t   b o t h   n o n - m a t c h i n g   a n d   m a t c h i n g   A S   t e x t   v a l u e s ,   a n d   c a l c u l a t e   a c c u r a t e   A S   c h a r a c t e r   r a n g e s   f r o m   t h o s e[ _`_ r     aba n    cdc I    �������� 0 location  ��  ��  d o     ����  0 asocmatchrange asocMatchRangeb o      ����  0 asocmatchstart asocMatchStart` efe r    ghg [    iji o    	����  0 asocmatchstart asocMatchStartj l  	 k����k n  	 lml I   
 �������� 
0 length  ��  ��  m o   	 
����  0 asocmatchrange asocMatchRange��  ��  h o      ���� 0 asocmatchend asocMatchEndf non r    pqp K    rr ��st�� 0 location  s o    ����  0 asocstartindex asocStartIndext ��u���� 
0 length  u \    vwv o    ����  0 asocmatchstart asocMatchStartw o    ����  0 asocstartindex asocStartIndex��  q o      ���� &0 asocnonmatchrange asocNonMatchRangeo xyx r    5z{z I      ��|���� $0 _matchinforecord _matchInfoRecord| }~} o    ���� 0 
asocstring 
asocString~ � o     ���� &0 asocnonmatchrange asocNonMatchRange� ��� o     !���� 0 
textoffset 
textOffset� ���� o   ! "���� (0 nonmatchrecordtype nonMatchRecordType��  ��  { J      �� ��� o      ���� 0 nonmatchinfo nonMatchInfo� ���� o      ���� 0 
textoffset 
textOffset��  y ��� r   6 N��� I      ������� $0 _matchinforecord _matchInfoRecord� ��� o   7 8���� 0 
asocstring 
asocString� ��� o   8 9����  0 asocmatchrange asocMatchRange� ��� o   9 :���� 0 
textoffset 
textOffset� ���� o   : ;���� "0 matchrecordtype matchRecordType��  ��  � J      �� ��� o      ���� 0 	matchinfo 	matchInfo� ���� o      ���� 0 
textoffset 
textOffset��  � ���� L   O V�� J   O U�� ��� o   O P���� 0 nonmatchinfo nonMatchInfo� ��� o   P Q���� 0 	matchinfo 	matchInfo� ��� o   Q R���� 0 asocmatchend asocMatchEnd� ���� o   R S���� 0 
textoffset 
textOffset��  ��  J ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  Z ]��� I      ������� &0 _matchedgrouplist _matchedGroupList� ��� o      ���� 0 
asocstring 
asocString� ��� o      ���� 0 	asocmatch 	asocMatch� ��� o      ���� 0 
textoffset 
textOffset� ���� o      ���� &0 includenonmatches includeNonMatches��  ��  � k     ��� ��� r     ��� J     ����  � o      ���� "0 submatchresults subMatchResults� ��� r    ��� \    ��� l   
������ n   
��� I    
��������  0 numberofranges numberOfRanges��  ��  � o    ���� 0 	asocmatch 	asocMatch��  ��  � m   
 ���� � o      ���� 0 groupindexes groupIndexes� ��� Z    �������� ?    ��� o    ���� 0 groupindexes groupIndexes� m    ����  � k    ��� ��� r    ��� n   ��� I    ������� 0 rangeatindex_ rangeAtIndex_� ���� m    ����  ��  ��  � o    ���� 0 	asocmatch 	asocMatch� o      ���� (0 asocfullmatchrange asocFullMatchRange� ��� r    %��� n   #��� I    #�������� 0 location  ��  ��  � o    ���� (0 asocfullmatchrange asocFullMatchRange� o      ���� &0 asocnonmatchstart asocNonMatchStart� ��� r   & /��� [   & -��� o   & '���� &0 asocnonmatchstart asocNonMatchStart� l  ' ,����� n  ' ,��� I   ( ,�~�}�|�~ 
0 length  �}  �|  � o   ' (�{�{ (0 asocfullmatchrange asocFullMatchRange��  �  � o      �z�z $0 asocfullmatchend asocFullMatchEnd� ��� Y   0 ���y���x� k   : ��� ��� r   : o��� I      �w��v�w 0 _matchrecords _matchRecords� ��� o   ; <�u�u 0 
asocstring 
asocString� ��� n  < B��� I   = B�t��s�t 0 rangeatindex_ rangeAtIndex_� ��r� o   = >�q�q 0 i  �r  �s  � o   < =�p�p 0 	asocmatch 	asocMatch� ��� o   B C�o�o &0 asocnonmatchstart asocNonMatchStart� ��� o   C D�n�n 0 
textoffset 
textOffset� ��� o   D I�m�m (0 _unmatchedtexttype _UnmatchedTextType� ��l� o   I N�k�k &0 _matchedgrouptype _MatchedGroupType�l  �v  � J      �� ��� o      �j�j 0 nonmatchinfo nonMatchInfo� ��� o      �i�i 0 	matchinfo 	matchInfo� ��� o      �h�h &0 asocnonmatchstart asocNonMatchStart� ��g� o      �f�f 0 
textoffset 
textOffset�g  �    Z  p |�e�d o   p q�c�c &0 includenonmatches includeNonMatches r   t x o   t u�b�b 0 nonmatchinfo nonMatchInfo n        ;   v w o   u v�a�a "0 submatchresults subMatchResults�e  �d   �` r   } �	
	 o   } ~�_�_ 0 	matchinfo 	matchInfo
 n        ;    � o   ~ �^�^ "0 submatchresults subMatchResults�`  �y 0 i  � m   3 4�]�] � o   4 5�\�\ 0 groupindexes groupIndexes�x  � �[ Z   � ��Z�Y o   � ��X�X &0 includenonmatches includeNonMatches k   � �  r   � � K   � � �W�W 0 location   o   � ��V�V &0 asocnonmatchstart asocNonMatchStart �U�T�U 
0 length   \   � � o   � ��S�S $0 asocfullmatchend asocFullMatchEnd o   � ��R�R &0 asocnonmatchstart asocNonMatchStart�T   o      �Q�Q &0 asocnonmatchrange asocNonMatchRange �P r   � � n   � � 4   � ��O 
�O 
cobj  m   � ��N�N  I   � ��M!�L�M $0 _matchinforecord _matchInfoRecord! "#" o   � ��K�K 0 
asocstring 
asocString# $%$ o   � ��J�J &0 asocnonmatchrange asocNonMatchRange% &'& o   � ��I�I 0 
textoffset 
textOffset' (�H( o   � ��G�G (0 _unmatchedtexttype _UnmatchedTextType�H  �L   n      )*)  ;   � �* o   � ��F�F "0 submatchresults subMatchResults�P  �Z  �Y  �[  ��  ��  � +�E+ L   � �,, o   � ��D�D "0 submatchresults subMatchResults�E  � -.- l     �C�B�A�C  �B  �A  . /0/ l     �@�?�>�@  �?  �>  0 121 l     �=�<�;�=  �<  �;  2 343 i  ^ a565 I      �:7�9�: 0 _findpattern _findPattern7 898 o      �8�8 0 thetext theText9 :;: o      �7�7 0 patterntext patternText; <=< o      �6�6 &0 includenonmatches includeNonMatches= >�5> o      �4�4  0 includematches includeMatches�5  �9  6 k    ?? @A@ r     BCB n    DED I    �3F�2�3 (0 asbooleanparameter asBooleanParameterF GHG o    �1�1 &0 includenonmatches includeNonMatchesH I�0I m    JJ �KK  u n m a t c h e d   t e x t�0  �2  E o     �/�/ 0 _support  C o      �.�. &0 includenonmatches includeNonMatchesA LML r    NON n   PQP I    �-R�,�- (0 asbooleanparameter asBooleanParameterR STS o    �+�+  0 includematches includeMatchesT U�*U m    VV �WW  m a t c h e d   t e x t�*  �,  Q o    �)�) 0 _support  O o      �(�(  0 includematches includeMatchesM XYX r    %Z[Z I    #�'\�&�' B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter\ ]^] o    �%�% 0 patterntext patternText^ _�$_ m    `` �aa  f o r�$  �&  [ o      �#�# 0 asocpattern asocPatternY bcb r   & 2ded n  & 0fgf I   + 0�"h�!�" ,0 asnormalizednsstring asNormalizedNSStringh i� i o   + ,�� 0 thetext theText�   �!  g o   & +�� 0 _support  e o      �� 0 
asocstring 
asocStringc jkj l  3 6lmnl r   3 6opo m   3 4��  p o      �� &0 asocnonmatchstart asocNonMatchStartm G A used to calculate NSRanges for non-matching portions of NSString   n �qq �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n gk rsr l  7 :tuvt r   7 :wxw m   7 8�� x o      �� 0 
textoffset 
textOffsetu B < used to calculate correct AppleScript start and end indexes   v �yy x   u s e d   t o   c a l c u l a t e   c o r r e c t   A p p l e S c r i p t   s t a r t   a n d   e n d   i n d e x e ss z{z r   ; ?|}| J   ; =��  } o      �� 0 
resultlist 
resultList{ ~~ l  @ @����  � @ : iterate over each non-matched + matched range in NSString   � ��� t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n g ��� r   @ Q��� n  @ O��� I   A O���� @0 matchesinstring_options_range_ matchesInString_options_range_� ��� o   A B�� 0 
asocstring 
asocString� ��� m   B C��  � ��� J   C K�� ��� m   C D��  � ��� n  D I��� I   E I���� 
0 length  �  �  � o   D E�� 0 
asocstring 
asocString�  �  �  � o   @ A�
�
 0 asocpattern asocPattern� o      �	�	  0 asocmatcharray asocMatchArray� ��� Y   R ������� k   b ��� ��� r   b j��� l  b h���� n  b h��� I   c h����  0 objectatindex_ objectAtIndex_� ��� o   c d�� 0 i  �  �  � o   b c� �   0 asocmatcharray asocMatchArray�  �  � o      ���� 0 	asocmatch 	asocMatch� ��� l  k k������  � � � the first range in match identifies the text matched by the entire pattern, so generate records for full match and its preceding (unmatched) text   � ���$   t h e   f i r s t   r a n g e   i n   m a t c h   i d e n t i f i e s   t h e   t e x t   m a t c h e d   b y   t h e   e n t i r e   p a t t e r n ,   s o   g e n e r a t e   r e c o r d s   f o r   f u l l   m a t c h   a n d   i t s   p r e c e d i n g   ( u n m a t c h e d )   t e x t� ��� r   k ���� I      ������� 0 _matchrecords _matchRecords� ��� o   l m���� 0 
asocstring 
asocString� ��� n  m s��� I   n s������� 0 rangeatindex_ rangeAtIndex_� ���� m   n o����  ��  ��  � o   m n���� 0 	asocmatch 	asocMatch� ��� o   s t���� &0 asocnonmatchstart asocNonMatchStart� ��� o   t u���� 0 
textoffset 
textOffset� ��� o   u z���� (0 _unmatchedtexttype _UnmatchedTextType� ���� o   z ���� $0 _matchedtexttype _MatchedTextType��  ��  � J      �� ��� o      ���� 0 nonmatchinfo nonMatchInfo� ��� o      ���� 0 	matchinfo 	matchInfo� ��� o      ���� &0 asocnonmatchstart asocNonMatchStart� ���� o      ���� 0 
textoffset 
textOffset��  � ��� Z  � �������� o   � ����� &0 includenonmatches includeNonMatches� r   � ���� o   � ����� 0 nonmatchinfo nonMatchInfo� n      ���  ;   � �� o   � ����� 0 
resultlist 
resultList��  ��  � ���� Z   � �������� o   � �����  0 includematches includeMatches� k   � ��� ��� l  � �������  � any additional ranges in match identify text matched by group references within regexp pattern, e.g. "([0-9]{4})-([0-9]{2})-([0-9]{2})" will match `YYYY-MM-DD` style date strings, returning the entire text match, plus sub-matches representing year, month and day text   � ���   a n y   a d d i t i o n a l   r a n g e s   i n   m a t c h   i d e n t i f y   t e x t   m a t c h e d   b y   g r o u p   r e f e r e n c e s   w i t h i n   r e g e x p   p a t t e r n ,   e . g .   " ( [ 0 - 9 ] { 4 } ) - ( [ 0 - 9 ] { 2 } ) - ( [ 0 - 9 ] { 2 } ) "   w i l l   m a t c h   ` Y Y Y Y - M M - D D `   s t y l e   d a t e   s t r i n g s ,   r e t u r n i n g   t h e   e n t i r e   t e x t   m a t c h ,   p l u s   s u b - m a t c h e s   r e p r e s e n t i n g   y e a r ,   m o n t h   a n d   d a y   t e x t� ���� r   � ���� b   � ���� o   � ����� 0 	matchinfo 	matchInfo� K   � ��� ������� 0 foundgroups foundGroups� I   � �������� &0 _matchedgrouplist _matchedGroupList� ��� o   � ����� 0 
asocstring 
asocString� ��� o   � ����� 0 	asocmatch 	asocMatch� ��� n  � ���� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 	matchinfo 	matchInfo� ���� o   � ����� &0 includenonmatches includeNonMatches��  ��  ��  � n      ���  ;   � �� o   � ����� 0 
resultlist 
resultList��  ��  ��  ��  � 0 i  � m   U V����  � \   V ]��� l  V [������ n  V [��� I   W [�������� 	0 count  ��  ��  � o   V W����  0 asocmatcharray asocMatchArray��  ��  � m   [ \���� �  � ��� l  � �������  � "  add final non-matched range   � ��� 8   a d d   f i n a l   n o n - m a t c h e d   r a n g e� ��� Z   �������� o   � ����� &0 includenonmatches includeNonMatches� k   ��� ��� r   � ���� c   � ���� l  � ������� n  � �� � I   � ������� *0 substringfromindex_ substringFromIndex_ �� o   � ����� &0 asocnonmatchstart asocNonMatchStart��  ��    o   � ����� 0 
asocstring 
asocString��  ��  � m   � ���
�� 
ctxt� o      ���� 0 	foundtext 	foundText� �� r   � K   � � ��
�� 
pcls o   � ����� (0 _unmatchedtexttype _UnmatchedTextType ��	
�� 0 
startindex 
startIndex	 o   � ����� 0 
textoffset 
textOffset
 ���� 0 endindex endIndex n   � � 1   � ���
�� 
leng o   � ����� 0 thetext theText ������ 0 	foundtext 	foundText o   � ����� 0 	foundtext 	foundText��   n        ;   �  o   � ����� 0 
resultlist 
resultList��  ��  ��  � �� L   o  ���� 0 
resultlist 
resultList��  4  l     ��������  ��  ��    l     ��������  ��  ��    l     ����    -----    � 
 - - - - -  l     �� ��     replace pattern     �!!     r e p l a c e   p a t t e r n "#" l     ��������  ��  ��  # $%$ i  b e&'& I      ��(���� "0 _replacepattern _replacePattern( )*) o      ���� 0 thetext theText* +,+ o      ���� 0 patterntext patternText, -��- o      ���� 0 templatetext templateText��  ��  ' k    P.. /0/ r     121 n    
343 I    
��5���� ,0 asnormalizednsstring asNormalizedNSString5 6��6 o    ���� 0 thetext theText��  ��  4 o     ���� 0 _support  2 o      ���� 0 
asocstring 
asocString0 787 r    9:9 I    ��;���� B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter; <=< o    ���� 0 patterntext patternText= >��> m    ?? �@@  f o r��  ��  : o      ���� 0 asocpattern asocPattern8 A��A Z   PBC��DB =    "EFE l    G����G I    ��HI
�� .corecnte****       ****H J    JJ K��K o    ���� 0 templatetext templateText��  I ��L��
�� 
koclL m    ��
�� 
scpt��  ��  ��  F m     !���� C k   %3MM NON r   % APQP J   % +RR STS J   % '����  T UVU m   ' (����  V W��W m   ( )���� ��  Q J      XX YZY o      ���� 0 
resultlist 
resultListZ [\[ o      ���� &0 asocnonmatchstart asocNonMatchStart\ ]��] o      ���� 0 
textoffset 
textOffset��  O ^_^ r   B S`a` n  B Qbcb I   C Q��d���� @0 matchesinstring_options_range_ matchesInString_options_range_d efe o   C D���� 0 
asocstring 
asocStringf ghg m   D E��  h i�~i J   E Mjj klk m   E F�}�}  l m�|m n  F Knon I   G K�{�z�y�{ 
0 length  �z  �y  o o   F G�x�x 0 
asocstring 
asocString�|  �~  ��  c o   B C�w�w 0 asocpattern asocPatterna o      �v�v  0 asocmatcharray asocMatchArray_ pqp Y   T �r�ust�tr k   d �uu vwv r   d lxyx l  d jz�s�rz n  d j{|{ I   e j�q}�p�q  0 objectatindex_ objectAtIndex_} ~�o~ o   e f�n�n 0 i  �o  �p  | o   d e�m�m  0 asocmatcharray asocMatchArray�s  �r  y o      �l�l 0 	asocmatch 	asocMatchw � r   m ���� I      �k��j�k 0 _matchrecords _matchRecords� ��� o   n o�i�i 0 
asocstring 
asocString� ��� n  o u��� I   p u�h��g�h 0 rangeatindex_ rangeAtIndex_� ��f� m   p q�e�e  �f  �g  � o   o p�d�d 0 	asocmatch 	asocMatch� ��� o   u v�c�c &0 asocnonmatchstart asocNonMatchStart� ��� o   v w�b�b 0 
textoffset 
textOffset� ��� o   w |�a�a (0 _unmatchedtexttype _UnmatchedTextType� ��`� o   | ��_�_ $0 _matchedtexttype _MatchedTextType�`  �j  � J      �� ��� o      �^�^ 0 nonmatchinfo nonMatchInfo� ��� o      �]�] 0 	matchinfo 	matchInfo� ��� o      �\�\ &0 asocnonmatchstart asocNonMatchStart� ��[� o      �Z�Z 0 
textoffset 
textOffset�[  � ��� r   � ���� n  � ���� o   � ��Y�Y 0 	foundtext 	foundText� o   � ��X�X 0 nonmatchinfo nonMatchInfo� n      ���  ;   � �� o   � ��W�W 0 
resultlist 
resultList� ��� r   � ���� I   � ��V��U�V &0 _matchedgrouplist _matchedGroupList� ��� o   � ��T�T 0 
asocstring 
asocString� ��� o   � ��S�S 0 	asocmatch 	asocMatch� ��� n  � ���� o   � ��R�R 0 
startindex 
startIndex� o   � ��Q�Q 0 	matchinfo 	matchInfo� ��P� m   � ��O
�O boovtrue�P  �U  � o      �N�N 0 matchedgroups matchedGroups� ��M� Q   � ����� r   � ���� c   � ���� n  � ���� I   � ��L��K�L  0 replacepattern replacePattern� ��� n  � ���� o   � ��J�J 0 	foundtext 	foundText� o   � ��I�I 0 	matchinfo 	matchInfo� ��H� o   � ��G�G 0 matchedgroups matchedGroups�H  �K  � o   � ��F�F 0 templatetext templateText� m   � ��E
�E 
ctxt� n      ���  ;   � �� o   � ��D�D 0 
resultlist 
resultList� R      �C��
�C .ascrerr ****      � ****� o      �B�B 0 etext eText� �A��
�A 
errn� o      �@�@ 0 enumber eNumber� �?��
�? 
erob� o      �>�> 0 efrom eFrom� �=��<
�= 
errt� o      �;�; 
0 eto eTo�<  � R   � ��:��
�: .ascrerr ****      � ****� b   � ���� m   � ��� ��� � A n   e r r o r   o c c u r r e d   w h e n   c a l l i n g   t h e    r e p l a c i n g   w i t h    p a r a m e t e r  s    r e p l a c e P a t t e r n    h a n d l e r :  � o   � ��9�9 0 etext eText� �8��
�8 
errn� o   � ��7�7 0 enumber eNumber� �6��
�6 
erob� o   � ��5�5 0 efrom eFrom� �4��3
�4 
errt� o   � ��2�2 
0 eto eTo�3  �M  �u 0 i  s m   W X�1�1  t \   X _��� l  X ]��0�/� n  X ]��� I   Y ]�.�-�,�. 	0 count  �-  �,  � o   X Y�+�+  0 asocmatcharray asocMatchArray�0  �/  � m   ] ^�*�* �t  q ��� l  � ��)���)  � "  add final non-matched range   � ��� 8   a d d   f i n a l   n o n - m a t c h e d   r a n g e� ��� r   � ��� c   � ���� l  � ���(�'� n  � ���� I   � ��&��%�& *0 substringfromindex_ substringFromIndex_� ��$� o   � ��#�# &0 asocnonmatchstart asocNonMatchStart�$  �%  � o   � ��"�" 0 
asocstring 
asocString�(  �'  � m   � ��!
�! 
ctxt� n      ���  ;   � �� o   � �� �  0 
resultlist 
resultList� ��� r  ��� n ��� 1  �
� 
txdl� 1  �
� 
ascr� o      �� 0 oldtids oldTIDs� ��� r  ��� m  �� ���  � n     ��� 1  �
� 
txdl� 1  �
� 
ascr� ��� r  "��� c  ��� o  �� 0 
resultlist 
resultList� m  �
� 
ctxt� o      �� 0 
resulttext 
resultText�    r  #. o  #&�� 0 oldtids oldTIDs n      1  )-�
� 
txdl 1  &)�
� 
ascr � L  /3 o  /2�� 0 
resulttext 
resultText�  ��  D L  6P c  6O	
	 l 6K�� n 6K I  7K��� |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_  l 
78�� o  78�� 0 
asocstring 
asocString�  �    m  89��    J  9A  m  9:�
�
   �	 n :? I  ;?���� 
0 length  �  �   o  :;�� 0 
asocstring 
asocString�	   � I  AG��� ,0 _parsesearchtemplate _parseSearchTemplate � o  BC� �  0 templatetext templateText�  �  �  �   o  67���� 0 asocpattern asocPattern�  �  
 m  KN��
�� 
ctxt��  %   l     ��������  ��  ��    !"! l     ��������  ��  ��  " #$# l     ��%&��  %  -----   & �'' 
 - - - - -$ ()( l     ��*+��  *  
 find text   + �,,    f i n d   t e x t) -.- l     ��������  ��  ��  . /0/ i  f i121 I      ��3���� 0 	_findtext 	_findText3 454 o      ���� 0 thetext theText5 676 o      ���� 0 fortext forText7 898 o      ���� &0 includenonmatches includeNonMatches9 :��: o      ����  0 includematches includeMatches��  ��  2 k    	;; <=< r     >?> J     ����  ? o      ���� 0 
resultlist 
resultList= @A@ r    
BCB n   DED 1    ��
�� 
txdlE 1    ��
�� 
ascrC o      ���� 0 oldtids oldTIDsA FGF r    HIH o    ���� 0 fortext forTextI n     JKJ 1    ��
�� 
txdlK 1    ��
�� 
ascrG LML r    NON m    ���� O o      ���� 0 
startindex 
startIndexM PQP r    RSR n    TUT 1    ��
�� 
lengU n    VWV 4    ��X
�� 
citmX m    ���� W o    ���� 0 thetext theTextS o      ���� 0 endindex endIndexQ YZY Z    Q[\����[ o    ���� &0 includenonmatches includeNonMatches\ k   " M]] ^_^ Z   " ;`a��b` B   " %cdc o   " #���� 0 
startindex 
startIndexd o   # $���� 0 endindex endIndexa r   ( 5efe n   ( 3ghg 7  ) 3��ij
�� 
ctxti o   - /���� 0 
startindex 
startIndexj o   0 2���� 0 endindex endIndexh o   ( )���� 0 thetext theTextf o      ���� 0 	foundtext 	foundText��  b r   8 ;klk m   8 9mm �nn  l o      ���� 0 	foundtext 	foundText_ o��o r   < Mpqp K   < Jrr ��st
�� 
pclss o   = B���� (0 _unmatchedtexttype _UnmatchedTextTypet ��uv�� 0 
startindex 
startIndexu o   C D���� 0 
startindex 
startIndexv ��wx�� 0 endindex endIndexw o   E F���� 0 endindex endIndexx ��y���� 0 	foundtext 	foundTexty o   G H���� 0 	foundtext 	foundText��  q n      z{z  ;   K L{ o   J K���� 0 
resultlist 
resultList��  ��  ��  Z |}| Y   R ~�����~ k   b ��� ��� r   b g��� [   b e��� o   b c���� 0 endindex endIndex� m   c d���� � o      ���� 0 
startindex 
startIndex� ��� r   h }��� \   h {��� l  h k������ n   h k��� 1   i k��
�� 
leng� o   h i���� 0 thetext theText��  ��  � l  k z������ n   k z��� 1   x z��
�� 
leng� n   k x��� 7  l x����
�� 
ctxt� l  p s������ 4   p s���
�� 
citm� o   q r���� 0 i  ��  ��  � l  t w������ 4   t w���
�� 
citm� m   u v��������  ��  � o   k l���� 0 thetext theText��  ��  � o      ���� 0 endindex endIndex� ��� Z   ~ �������� o   ~ ����  0 includematches includeMatches� k   � ��� ��� Z   � ������� B   � ���� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� r   � ���� n   � ���� 7  � �����
�� 
ctxt� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� o   � ����� 0 thetext theText� o      ���� 0 	foundtext 	foundText��  � r   � ���� m   � ��� ���  � o      ���� 0 	foundtext 	foundText� ���� r   � ���� K   � ��� ����
�� 
pcls� o   � ����� $0 _matchedtexttype _MatchedTextType� ������ 0 
startindex 
startIndex� o   � ����� 0 
startindex 
startIndex� ������ 0 endindex endIndex� o   � ����� 0 endindex endIndex� ������ 0 	foundtext 	foundText� o   � ����� 0 	foundtext 	foundText� ������� 0 foundgroups foundGroups� J   � �����  ��  � n      ���  ;   � �� o   � ����� 0 
resultlist 
resultList��  ��  ��  � ��� r   � ���� [   � ���� o   � ����� 0 endindex endIndex� m   � ����� � o      ���� 0 
startindex 
startIndex� ��� r   � ���� \   � ���� [   � ���� o   � ����� 0 
startindex 
startIndex� l  � ������� n   � ���� 1   � ���
�� 
leng� n   � ���� 4   � ����
�� 
citm� o   � ����� 0 i  � o   � ����� 0 thetext theText��  ��  � m   � ����� � o      ���� 0 endindex endIndex� ���� Z   � �������� o   � ����� &0 includenonmatches includeNonMatches� k   � ��� ��� Z   � ������� B   � ���� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� r   � ���� n   � ���� 7  � �����
�� 
ctxt� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� o   � ��� 0 thetext theText� o      �~�~ 0 	foundtext 	foundText��  � r   � ���� m   � ��� ���  � o      �}�} 0 	foundtext 	foundText� ��|� r   � ���� K   � ��� �{��
�{ 
pcls� o   � ��z�z (0 _unmatchedtexttype _UnmatchedTextType� �y���y 0 
startindex 
startIndex� o   � ��x�x 0 
startindex 
startIndex� �w���w 0 endindex endIndex� o   � ��v�v 0 endindex endIndex� �u��t�u 0 	foundtext 	foundText� o   � ��s�s 0 	foundtext 	foundText�t  � n      ���  ;   � �� o   � ��r�r 0 
resultlist 
resultList�|  ��  ��  ��  �� 0 i   m   U V�q�q � I  V ]�p��o
�p .corecnte****       ****� n   V Y��� 2  W Y�n
�n 
citm� o   V W�m�m 0 thetext theText�o  ��  } ��� r  ��� o  �l�l 0 oldtids oldTIDs� n     ��� 1  �k
�k 
txdl� 1  �j
�j 
ascr�  �i  L  	 o  �h�h 0 
resultlist 
resultList�i  0  l     �g�f�e�g  �f  �e    l     �d�c�b�d  �c  �b    l     �a	�a    -----   	 �

 
 - - - - -  l     �`�`     replace text    �    r e p l a c e   t e x t  l     �_�^�]�_  �^  �]    i  j m I      �\�[�\ 0 _replacetext _replaceText  o      �Z�Z 0 thetext theText  o      �Y�Y 0 fortext forText �X o      �W�W 0 newtext newText�X  �[   k    '  r       n    !"! 1    �V
�V 
txdl" 1     �U
�U 
ascr  o      �T�T 0 oldtids oldTIDs #$# r    %&% o    �S�S 0 fortext forText& n     '(' 1    
�R
�R 
txdl( 1    �Q
�Q 
ascr$ )*) Z   +,�P-+ >    ./. l   0�O�N0 I   �M12
�M .corecnte****       ****1 J    33 4�L4 o    �K�K 0 newtext newText�L  2 �J5�I
�J 
kocl5 m    �H
�H 
scpt�I  �O  �N  / m    �G�G  , k    �66 787 r    ;9:9 J    %;; <=< J    �F�F  = >?> m    �E�E ? @�D@ n    #ABA 1   ! #�C
�C 
lengB n    !CDC 4    !�BE
�B 
citmE m     �A�A D o    �@�@ 0 thetext theText�D  : J      FF GHG o      �?�? 0 
resultlist 
resultListH IJI o      �>�> 0 
startindex 
startIndexJ K�=K o      �<�< 0 endindex endIndex�=  8 LML Z  < TNO�;�:N B   < ?PQP o   < =�9�9 0 
startindex 
startIndexQ o   = >�8�8 0 endindex endIndexO r   B PRSR n   B MTUT 7  C M�7VW
�7 
ctxtV o   G I�6�6 0 
startindex 
startIndexW o   J L�5�5 0 endindex endIndexU o   B C�4�4 0 thetext theTextS n      XYX  ;   N OY o   M N�3�3 0 
resultlist 
resultList�;  �:  M Z[Z Y   U �\�2]^�1\ k   e �__ `a` r   e jbcb [   e hded o   e f�0�0 0 endindex endIndexe m   f g�/�/ c o      �.�. 0 
startindex 
startIndexa fgf r   k �hih \   k ~jkj l  k nl�-�,l n   k nmnm 1   l n�+
�+ 
lengn o   k l�*�* 0 thetext theText�-  �,  k l  n }o�)�(o n   n }pqp 1   { }�'
�' 
lengq n   n {rsr 7  o {�&tu
�& 
ctxtt l  s vv�%�$v 4   s v�#w
�# 
citmw o   t u�"�" 0 i  �%  �$  u l  w zx�!� x 4   w z�y
� 
citmy m   x y�����!  �   s o   n o�� 0 thetext theText�)  �(  i o      �� 0 endindex endIndexg z{z Z   � �|}�~| B   � �� o   � ��� 0 
startindex 
startIndex� o   � ��� 0 endindex endIndex} r   � ���� n   � ���� 7  � ����
� 
ctxt� o   � ��� 0 
startindex 
startIndex� o   � ��� 0 endindex endIndex� o   � ��� 0 thetext theText� o      �� 0 	foundtext 	foundText�  ~ r   � ���� m   � ��� ���  � o      �� 0 	foundtext 	foundText{ ��� Q   � ����� r   � ���� c   � ���� n  � ���� I   � ����� 0 replacetext replaceText� ��� o   � ��� 0 	foundtext 	foundText�  �  � o   � ��� 0 newtext newText� m   � ��
� 
ctxt� n      ���  ;   � �� o   � ��� 0 
resultlist 
resultList� R      ���
� .ascrerr ****      � ****� o      �
�
 0 etext eText� �	��
�	 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  � R   � ����
� .ascrerr ****      � ****� b   � ���� m   � ��� ��� � A n   e r r o r   o c c u r r e d   w h e n   c a l l i n g   t h e    r e p l a c i n g   w i t h    p a r a m e t e r  s    r e p l a c e T e x t    h a n d l e r :  � o   � ��� 0 etext eText� � ��
�  
errn� o   � ����� 0 enumber eNumber� ����
�� 
erob� o   � ����� 0 efrom eFrom� �����
�� 
errt� o   � ����� 
0 eto eTo��  � ��� r   � ���� [   � ���� o   � ����� 0 endindex endIndex� m   � ����� � o      ���� 0 
startindex 
startIndex� ��� r   � ���� \   � ���� [   � ���� o   � ����� 0 
startindex 
startIndex� l  � ������� n   � ���� 1   � ���
�� 
leng� n   � ���� 4   � ����
�� 
citm� o   � ����� 0 i  � o   � ����� 0 thetext theText��  ��  � m   � ����� � o      ���� 0 endindex endIndex� ���� Z  � �������� B   � ���� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� r   � ���� n   � ���� 7  � �����
�� 
ctxt� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� o   � ����� 0 thetext theText� n      ���  ;   � �� o   � ����� 0 
resultlist 
resultList��  ��  ��  �2 0 i  ] m   X Y���� ^ I  Y `�����
�� .corecnte****       ****� n   Y \��� 2  Z \��
�� 
citm� o   Y Z���� 0 thetext theText��  �1  [ ���� r   � ���� m   � ��� ���  � n     ��� 1   � ���
�� 
txdl� 1   � ���
�� 
ascr��  �P  - l  ����� k   ��� ��� l  � �������  �   replace with text   � ��� $   r e p l a c e   w i t h   t e x t� ��� r   ���� n  �
��� I  
������� "0 astextparameter asTextParameter� ��� o  ���� 0 newtext newText� ���� m  �� ���  r e p l a c i n g   w i t h��  ��  � o   ����� 0 _support  � o      ���� 0 newtext newText� ��� l ���� r  ��� n ��� 2 ��
�� 
citm� o  ���� 0 thetext theText� o      ���� 0 
resultlist 
resultList� J D note: TID-based matching uses current considering/ignoring settings   � ��� �   n o t e :   T I D - b a s e d   m a t c h i n g   u s e s   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s� ���� r  ��� o  ���� 0 newtext newText� n     ��� 1  ��
�� 
txdl� 1  ��
�� 
ascr��  � * $ replace with callback-supplied text   � ��� H   r e p l a c e   w i t h   c a l l b a c k - s u p p l i e d   t e x t* ��� r  ��� c     o  ���� 0 
resultlist 
resultList m  ��
�� 
ctxt� o      ���� 0 
resulttext 
resultText�  r  $ o   ���� 0 oldtids oldTIDs n      1  !#��
�� 
txdl 1   !��
�� 
ascr �� L  %'		 o  %&���� 0 
resulttext 
resultText��   

 l     ��������  ��  ��    l     ��������  ��  ��    l     ����    -----    � 
 - - - - -  l     ��������  ��  ��    i  n q I     ��
�� .Txt:Srchnull���     ctxt o      ���� 0 thetext theText ��
�� 
For_ o      ���� 0 fortext forText ��
�� 
Usin |������ ��  ��   o      ���� 0 matchformat matchFormat��    l 
    !����! l     "����" m      ��
�� SerECmpI��  ��  ��  ��   ��#$
�� 
Repl# |����%��&��  ��  % o      ���� 0 newtext newText��  & l     '����' m      ��
�� 
msng��  ��  $ ��(��
�� 
Retu( |����)��*��  ��  ) o      ���� 0 resultformat resultFormat��  * l     +����+ m      ��
�� RetEMatT��  ��  ��   Q    b,-., k   L// 010 r    232 n   454 I    ��6���� "0 astextparameter asTextParameter6 787 o    	���� 0 thetext theText8 9��9 m   	 
:: �;;  ��  ��  5 o    ���� 0 _support  3 o      ���� 0 thetext theText1 <=< r    >?> n   @A@ I    ��B���� "0 astextparameter asTextParameterB CDC o    ���� 0 fortext forTextD E��E m    FF �GG  f o r��  ��  A o    ���� 0 _support  ? o      ���� 0 fortext forText= HIH Z   8JK����J =    $LML n   "NON 1     "��
�� 
lengO o     ���� 0 fortext forTextM m   " #����  K n  ' 4PQP I   , 4��R���� .0 throwinvalidparameter throwInvalidParameterR STS o   , -���� 0 fortext forTextT UVU m   - .WW �XX  f o rV YZY m   . /��
�� 
ctxtZ [��[ m   / 0\\ �]] ( C a n  t   b e   e m p t y   t e x t .��  ��  Q o   ' ,���� 0 _support  ��  ��  I ^��^ Z   9L_`��a_ =  9 <bcb o   9 :���� 0 newtext newTextc m   : ;��
�� 
msng` l  ?�defd k   ?�gg hih Z   ? jjk����j =   ? Dlml n  ? Bnon 1   @ B�
� 
lengo o   ? @�~�~ 0 thetext theTextm m   B C�}�}  k Z   G fpq�|rp =  G Jsts o   G H�{�{ 0 resultformat resultFormatt m   H I�z
�z RetEMatTq L   M Puu J   M O�y�y  �|  r L   S fvv J   S eww x�xx K   S cyy �wz{
�w 
pclsz o   T Y�v�v (0 _unmatchedtexttype _UnmatchedTextType{ �u|}�u 0 
startindex 
startIndex| m   Z [�t�t } �s~�s 0 endindex endIndex~ m   \ ]�r�r   �q��p�q 0 	foundtext 	foundText� m   ^ _�� ���  �p  �x  ��  ��  i ��� Z   k ������ =  k n��� o   k l�o�o 0 resultformat resultFormat� m   l m�n
�n RetEMatT� r   q ���� J   q u�� ��� m   q r�m
�m boovfals� ��l� m   r s�k
�k boovtrue�l  � J      �� ��� o      �j�j &0 includenonmatches includeNonMatches� ��i� o      �h�h  0 includematches includeMatches�i  � ��� =  � ���� o   � ��g�g 0 resultformat resultFormat� m   � ��f
�f RetEUmaT� ��� r   � ���� J   � ��� ��� m   � ��e
�e boovtrue� ��d� m   � ��c
�c boovfals�d  � J      �� ��� o      �b�b &0 includenonmatches includeNonMatches� ��a� o      �`�`  0 includematches includeMatches�a  � ��� =  � ���� o   � ��_�_ 0 resultformat resultFormat� m   � ��^
�^ RetEAllT� ��]� r   � ���� J   � ��� ��� m   � ��\
�\ boovtrue� ��[� m   � ��Z
�Z boovtrue�[  � J      �� ��� o      �Y�Y &0 includenonmatches includeNonMatches� ��X� o      �W�W  0 includematches includeMatches�X  �]  � n  � ���� I   � ��V��U�V >0 throwinvalidconstantparameter throwInvalidConstantParameter� ��� o   � ��T�T 0 resultformat resultFormat� ��S� m   � ��� ���  r e t u r n i n g�S  �U  � o   � ��R�R 0 _support  � ��Q� Z   ������� =  � ���� o   � ��P�P 0 matchformat matchFormat� m   � ��O
�O SerECmpI� P   � ����� L   � ��� I   � ��N��M�N 0 	_findtext 	_findText� ��� o   � ��L�L 0 thetext theText� ��� o   � ��K�K 0 fortext forText� ��� o   � ��J�J &0 includenonmatches includeNonMatches� ��I� o   � ��H�H  0 includematches includeMatches�I  �M  � �G�
�G consdiac� �F�
�F conshyph� �E�
�E conspunc� �D�
�D conswhit� �C�B
�C consnume�B  � �A�@
�A conscase�@  � ��� =  ���� o   � ��?�? 0 matchformat matchFormat� m   � �>
�> SerECmpP� ��� L  �� I  �=��<�= 0 _findpattern _findPattern� ��� o  �;�; 0 thetext theText� ��� o  �:�: 0 fortext forText� ��� o  �9�9 &0 includenonmatches includeNonMatches� ��8� o  	�7�7  0 includematches includeMatches�8  �<  � ��� = ��� o  �6�6 0 matchformat matchFormat� m  �5
�5 SerECmpC� ��� P  +���4� L   *�� I   )�3��2�3 0 	_findtext 	_findText� ��� o  !"�1�1 0 thetext theText� ��� o  "#�0�0 0 fortext forText� ��� o  #$�/�/ &0 includenonmatches includeNonMatches� ��.� o  $%�-�-  0 includematches includeMatches�.  �2  � �,�
�, conscase� �+�
�+ consdiac� �*�
�* conshyph� �)�
�) conspunc� �(�
�( conswhit� �'�&
�' consnume�&  �4  � ��� = .3��� o  ./�%�% 0 matchformat matchFormat� m  /2�$
�$ SerECmpE� ��� P  6J��	 � L  ?I		 I  ?H�#	�"�# 0 	_findtext 	_findText	 			 o  @A�!�! 0 thetext theText	 			 o  AB� �  0 fortext forText	 			 o  BC�� &0 includenonmatches includeNonMatches	 		�		 o  CD��  0 includematches includeMatches�  �"  � �	

� conscase	
 �	
� consdiac	 �	
� conshyph	 �	
� conspunc	 ��
� conswhit�  	  ��
� consnume�  � 			 = MR			 o  MN�� 0 matchformat matchFormat	 m  NQ�
� SerECmpD	 	�	 k  U}		 			 l Ur				 Z Ur		��	 = UZ			 o  UV�� 0 fortext forText	 m  VY		 �		  	 n ]n		 	 I  bn�	!�� .0 throwinvalidparameter throwInvalidParameter	! 	"	#	" o  bc�� 0 fortext forText	# 	$	%	$ m  cf	&	& �	'	'  f o r	% 	(	)	( m  fg�
� 
ctxt	) 	*�
	* m  gj	+	+ �	,	, ~ O n l y   c o n t a i n s   c h a r a c t e r s   i g n o r e d   b y   t h e   c u r r e n t   c o n s i d e r a t i o n s .�
  �  	  o  ]b�	�	 0 _support  �  �  	�� checks if all characters in forText are ignored by current considering/ignoring settings (the alternative would be to return each character as a non-match separated by a zero-length match, but that's probably not what the user intended); note that unlike `aString's length = 0`, which is what library code normally uses to check for empty text, on this occasion we do want to take into account the current considering/ignoring settings so deliberately use `forText is ""` here. For example, when ignoring punctuation, searching for the TID `"!?"` is no different to searching for `""`, because all of its characters are being ignored when comparing the text being searched against the text being searched for. Thus, a simple `forText is ""` test can be used to check in advance if the text contains any matchable characters under the current considering/ignoring settings, and report a meaningful error if not.   	 �	-	-   c h e c k s   i f   a l l   c h a r a c t e r s   i n   f o r T e x t   a r e   i g n o r e d   b y   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   ( t h e   a l t e r n a t i v e   w o u l d   b e   t o   r e t u r n   e a c h   c h a r a c t e r   a s   a   n o n - m a t c h   s e p a r a t e d   b y   a   z e r o - l e n g t h   m a t c h ,   b u t   t h a t ' s   p r o b a b l y   n o t   w h a t   t h e   u s e r   i n t e n d e d ) ;   n o t e   t h a t   u n l i k e   ` a S t r i n g ' s   l e n g t h   =   0 ` ,   w h i c h   i s   w h a t   l i b r a r y   c o d e   n o r m a l l y   u s e s   t o   c h e c k   f o r   e m p t y   t e x t ,   o n   t h i s   o c c a s i o n   w e   d o   w a n t   t o   t a k e   i n t o   a c c o u n t   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   s o   d e l i b e r a t e l y   u s e   ` f o r T e x t   i s   " " `   h e r e .   F o r   e x a m p l e ,   w h e n   i g n o r i n g   p u n c t u a t i o n ,   s e a r c h i n g   f o r   t h e   T I D   ` " ! ? " `   i s   n o   d i f f e r e n t   t o   s e a r c h i n g   f o r   ` " " ` ,   b e c a u s e   a l l   o f   i t s   c h a r a c t e r s   a r e   b e i n g   i g n o r e d   w h e n   c o m p a r i n g   t h e   t e x t   b e i n g   s e a r c h e d   a g a i n s t   t h e   t e x t   b e i n g   s e a r c h e d   f o r .   T h u s ,   a   s i m p l e   ` f o r T e x t   i s   " " `   t e s t   c a n   b e   u s e d   t o   c h e c k   i n   a d v a n c e   i f   t h e   t e x t   c o n t a i n s   a n y   m a t c h a b l e   c h a r a c t e r s   u n d e r   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s ,   a n d   r e p o r t   a   m e a n i n g f u l   e r r o r   i f   n o t .	 	.�	. L  s}	/	/ I  s|�	0�� 0 	_findtext 	_findText	0 	1	2	1 o  tu�� 0 thetext theText	2 	3	4	3 o  uv�� 0 fortext forText	4 	5	6	5 o  vw�� &0 includenonmatches includeNonMatches	6 	7�	7 o  wx��  0 includematches includeMatches�  �  �  �  � n ��	8	9	8 I  ��� 	:���  >0 throwinvalidconstantparameter throwInvalidConstantParameter	: 	;	<	; o  ������ 0 matchformat matchFormat	< 	=��	= m  ��	>	> �	?	? 
 u s i n g��  ��  	9 o  ������ 0 _support  �Q  e   find matches   f �	@	@    f i n d   m a t c h e s��  a l �L	A	B	C	A k  �L	D	D 	E	F	E Z ��	G	H����	G =  ��	I	J	I n ��	K	L	K 1  ����
�� 
leng	L o  ������ 0 thetext theText	J m  ������  	H L  ��	M	M m  ��	N	N �	O	O  ��  ��  	F 	P��	P Z  �L	Q	R	S	T	Q = ��	U	V	U o  ������ 0 matchformat matchFormat	V m  ����
�� SerECmpI	R P  ��	W	X	Y	W L  ��	Z	Z I  ����	[���� 0 _replacetext _replaceText	[ 	\	]	\ o  ������ 0 thetext theText	] 	^	_	^ o  ������ 0 fortext forText	_ 	`��	` o  ������ 0 newtext newText��  ��  	X ��	a
�� consdiac	a ��	b
�� conshyph	b ��	c
�� conspunc	c ��	d
�� conswhit	d ����
�� consnume��  	Y ����
�� conscase��  	S 	e	f	e = ��	g	h	g o  ������ 0 matchformat matchFormat	h m  ����
�� SerECmpP	f 	i	j	i L  ��	k	k I  ����	l���� "0 _replacepattern _replacePattern	l 	m	n	m o  ������ 0 thetext theText	n 	o	p	o o  ������ 0 fortext forText	p 	q��	q o  ������ 0 newtext newText��  ��  	j 	r	s	r = ��	t	u	t o  ������ 0 matchformat matchFormat	u m  ����
�� SerECmpE	s 	v	w	v P  ��	x	y	z	x L  ��	{	{ I  ����	|���� 0 _replacetext _replaceText	| 	}	~	} o  ������ 0 thetext theText	~ 		�	 o  ������ 0 fortext forText	� 	���	� o  ������ 0 newtext newText��  ��  	y ��	�
�� conscase	� ��	�
�� consdiac	� ��	�
�� conshyph	� ��	�
�� conspunc	� ����
�� conswhit��  	z ����
�� consnume��  	w 	�	�	� = ��	�	�	� o  ������ 0 matchformat matchFormat	� m  ����
�� SerECmpC	� 	�	�	� P  �
	�	���	� L   		�	� I   ��	����� 0 _replacetext _replaceText	� 	�	�	� o  ���� 0 thetext theText	� 	�	�	� o  ���� 0 fortext forText	� 	���	� o  ���� 0 newtext newText��  ��  	� ��	�
�� conscase	� ��	�
�� consdiac	� ��	�
�� conshyph	� ��	�
�� conspunc	� ��	�
�� conswhit	� ����
�� consnume��  ��  	� 	�	�	� = 	�	�	� o  ���� 0 matchformat matchFormat	� m  ��
�� SerECmpD	� 	���	� k  <	�	� 	�	�	� Z 2	�	�����	� = 	�	�	� o  ���� 0 fortext forText	� m  	�	� �	�	�  	� n .	�	�	� I  ".��	����� .0 throwinvalidparameter throwInvalidParameter	� 	�	�	� o  "#���� 0 fortext forText	� 	�	�	� m  #&	�	� �	�	�  f o r	� 	�	�	� m  &'��
�� 
ctxt	� 	���	� m  '*	�	� �	�	� ~ O n l y   c o n t a i n s   c h a r a c t e r s   i g n o r e d   b y   t h e   c u r r e n t   c o n s i d e r a t i o n s .��  ��  	� o  "���� 0 _support  ��  ��  	� 	���	� L  3<	�	� I  3;��	����� 0 _replacetext _replaceText	� 	�	�	� o  45���� 0 thetext theText	� 	�	�	� o  56���� 0 fortext forText	� 	���	� o  67���� 0 newtext newText��  ��  ��  ��  	T n ?L	�	�	� I  DL��	����� >0 throwinvalidconstantparameter throwInvalidConstantParameter	� 	�	�	� o  DE���� 0 matchformat matchFormat	� 	���	� m  EH	�	� �	�	� 
 u s i n g��  ��  	� o  ?D���� 0 _support  ��  	B   replace matches   	C �	�	�     r e p l a c e   m a t c h e s��  - R      ��	�	�
�� .ascrerr ****      � ****	� o      ���� 0 etext eText	� ��	�	�
�� 
errn	� o      ���� 0 enumber eNumber	� ��	�	�
�� 
erob	� o      ���� 0 efrom eFrom	� ��	���
�� 
errt	� o      ���� 
0 eto eTo��  . I  Tb��	����� 
0 _error  	� 	�	�	� m  UX	�	� �	�	�  s e a r c h   t e x t	� 	�	�	� o  XY���� 0 etext eText	� 	�	�	� o  YZ���� 0 enumber eNumber	� 	�	�	� o  Z[���� 0 efrom eFrom	� 	���	� o  [\���� 
0 eto eTo��  ��   	�	�	� l     ��������  ��  ��  	� 	�	�	� l     ��������  ��  ��  	� 	�	�	� i  r u	�	�	� I     ��	���
�� .Txt:EPatnull���     ctxt	� o      ���� 0 thetext theText��  	� Q     *	�	�	�	� L    	�	� c    	�	�	� l   	�����	� n   	�	�	� I    ��	����� 40 escapedpatternforstring_ escapedPatternForString_	� 	���	� l   	�����	� n   	�	�	� I    ��	����� "0 astextparameter asTextParameter	� 	�	�	� o    ���� 0 thetext theText	� 	���	� m    	�	� �	�	�  ��  ��  	� o    ���� 0 _support  ��  ��  ��  ��  	� n   	�	�	� o    ���� *0 nsregularexpression NSRegularExpression	� m    �
� misccura��  ��  	� m    �~
�~ 
ctxt	� R      �}	�	�
�} .ascrerr ****      � ****	� o      �|�| 0 etext eText	� �{	�	�
�{ 
errn	� o      �z�z 0 enumber eNumber	� �y	�	�
�y 
erob	� o      �x�x 0 efrom eFrom	� �w	��v
�w 
errt	� o      �u�u 
0 eto eTo�v  	� I     *�t
 �s�t 
0 _error  
  


 m   ! "

 �

  e s c a p e   p a t t e r n
 


 o   " #�r�r 0 etext eText
 


 o   # $�q�q 0 enumber eNumber
 
	


	 o   $ %�p�p 0 efrom eFrom

 
�o
 o   % &�n�n 
0 eto eTo�o  �s  	� 


 l     �m�l�k�m  �l  �k  
 


 l     �j�i�h�j  �i  �h  
 


 i  v y


 I     �g
�f
�g .Txt:ETemnull���     ctxt
 o      �e�e 0 thetext theText�f  
 Q     -



 L    

 I    �d
�c�d 0 	_jointext 	_joinText
 


 I    �b
�a�b 0 
_splittext 
_splitText
 


 n   

 
 I   
 �`
!�_�` "0 astextparameter asTextParameter
! 
"
#
" o   
 �^�^ 0 thetext theText
# 
$�]
$ m    
%
% �
&
&  �]  �_  
  o    
�\�\ 0 _support  
 
'�[
' m    
(
( �
)
)  \�[  �a  
 
*�Z
* m    
+
+ �
,
,  \ \�Z  �c  
 R      �Y
-
.
�Y .ascrerr ****      � ****
- o      �X�X 0 etext eText
. �W
/
0
�W 
errn
/ o      �V�V 0 enumber eNumber
0 �U
1
2
�U 
erob
1 o      �T�T 0 efrom eFrom
2 �S
3�R
�S 
errt
3 o      �Q�Q 
0 eto eTo�R  
 I   # -�P
4�O�P 
0 _error  
4 
5
6
5 m   $ %
7
7 �
8
8  e s c a p e   t e m p l a t e
6 
9
:
9 o   % &�N�N 0 etext eText
: 
;
<
; o   & '�M�M 0 enumber eNumber
< 
=
>
= o   ' (�L�L 0 efrom eFrom
> 
?�K
? o   ( )�J�J 
0 eto eTo�K  �O  
 
@
A
@ l     �I�H�G�I  �H  �G  
A 
B
C
B l     �F�E�D�F  �E  �D  
C 
D
E
D l     �C
F
G�C  
F J D--------------------------------------------------------------------   
G �
H
H � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
E 
I
J
I l     �B
K
L�B  
K   Conversion Suite   
L �
M
M "   C o n v e r s i o n   S u i t e
J 
N
O
N l     �A�@�?�A  �@  �?  
O 
P
Q
P i  z }
R
S
R I     �>
T
U
�> .Txt:UppTnull���     ctxt
T o      �=�= 0 thetext theText
U �<
V�;
�< 
Loca
V |�:�9
W�8
X�:  �9  
W o      �7�7 0 
localecode 
localeCode�8  
X m      �6
�6 
msng�;  
S Q     P
Y
Z
[
Y k    >
\
\ 
]
^
] r    
_
`
_ n   
a
b
a I    �5
c�4�5 0 
asnsstring 
asNSString
c 
d�3
d n   
e
f
e I    �2
g�1�2 "0 astextparameter asTextParameter
g 
h
i
h o    �0�0 0 thetext theText
i 
j�/
j m    
k
k �
l
l  �/  �1  
f o    �.�. 0 _support  �3  �4  
b o    �-�- 0 _support  
` o      �,�, 0 
asocstring 
asocString
^ 
m�+
m Z    >
n
o�*
p
n =   
q
r
q o    �)�) 0 
localecode 
localeCode
r m    �(
�( 
msng
o L     (
s
s c     '
t
u
t l    %
v�'�&
v n    %
w
x
w I   ! %�%�$�#�% "0 uppercasestring uppercaseString�$  �#  
x o     !�"�" 0 
asocstring 
asocString�'  �&  
u m   % &�!
�! 
ctxt�*  
p L   + >
y
y c   + =
z
{
z l  + ;
|� �
| n  + ;
}
~
} I   , ;�
�� 80 uppercasestringwithlocale_ uppercaseStringWithLocale_
 
��
� l  , 7
���
� n  , 7
�
�
� I   1 7�
��� *0 asnslocaleparameter asNSLocaleParameter
� 
�
�
� o   1 2�� 0 
localecode 
localeCode
� 
��
� m   2 3
�
� �
�
�  f o r   l o c a l e�  �  
� o   , 1�� 0 _support  �  �  �  �  
~ o   + ,�� 0 
asocstring 
asocString�   �  
{ m   ; <�
� 
ctxt�+  
Z R      �
�
�
� .ascrerr ****      � ****
� o      �� 0 etext eText
� �
�
�
� 
errn
� o      �� 0 enumber eNumber
� �
�
�
� 
erob
� o      �� 0 efrom eFrom
� �
��
� 
errt
� o      �
�
 
0 eto eTo�  
[ I   F P�	
���	 
0 _error  
� 
�
�
� m   G H
�
� �
�
�  u p p e r c a s e   t e x t
� 
�
�
� o   H I�� 0 etext eText
� 
�
�
� o   I J�� 0 enumber eNumber
� 
�
�
� o   J K�� 0 efrom eFrom
� 
��
� o   K L�� 
0 eto eTo�  �  
Q 
�
�
� l     ��� �  �  �   
� 
�
�
� l     ��������  ��  ��  
� 
�
�
� i  ~ �
�
�
� I     ��
�
�
�� .Txt:CapTnull���     ctxt
� o      ���� 0 thetext theText
� ��
���
�� 
Loca
� |����
���
���  ��  
� o      ���� 0 
localecode 
localeCode��  
� m      ��
�� 
msng��  
� Q     P
�
�
�
� k    >
�
� 
�
�
� r    
�
�
� n   
�
�
� I    ��
����� 0 
asnsstring 
asNSString
� 
���
� n   
�
�
� I    ��
����� "0 astextparameter asTextParameter
� 
�
�
� o    ���� 0 thetext theText
� 
���
� m    
�
� �
�
�  ��  ��  
� o    ���� 0 _support  ��  ��  
� o    ���� 0 _support  
� o      ���� 0 
asocstring 
asocString
� 
���
� Z    >
�
���
�
� =   
�
�
� o    ���� 0 
localecode 
localeCode
� m    ��
�� 
msng
� L     (
�
� c     '
�
�
� l    %
�����
� n    %
�
�
� I   ! %�������� &0 capitalizedstring capitalizedString��  ��  
� o     !���� 0 
asocstring 
asocString��  ��  
� m   % &��
�� 
ctxt��  
� L   + >
�
� c   + =
�
�
� l  + ;
�����
� n  + ;
�
�
� I   , ;��
����� <0 capitalizedstringwithlocale_ capitalizedStringWithLocale_
� 
���
� l  , 7
�����
� n  , 7
�
�
� I   1 7��
����� *0 asnslocaleparameter asNSLocaleParameter
� 
�
�
� o   1 2���� 0 
localecode 
localeCode
� 
���
� m   2 3
�
� �
�
�  f o r   l o c a l e��  ��  
� o   , 1���� 0 _support  ��  ��  ��  ��  
� o   + ,���� 0 
asocstring 
asocString��  ��  
� m   ; <��
�� 
ctxt��  
� R      ��
�
�
�� .ascrerr ****      � ****
� o      ���� 0 etext eText
� ��
�
�
�� 
errn
� o      ���� 0 enumber eNumber
� ��
�
�
�� 
erob
� o      ���� 0 efrom eFrom
� ��
���
�� 
errt
� o      ���� 
0 eto eTo��  
� I   F P��
����� 
0 _error  
� 
�
�
� m   G H
�
� �
�
�  c a p i t a l i z e   t e x t
� 
�
�
� o   H I���� 0 etext eText
� 
�
�
� o   I J���� 0 enumber eNumber
� 
�
�
� o   J K���� 0 efrom eFrom
� 
���
� o   K L���� 
0 eto eTo��  ��  
� 
�
�
� l     ��������  ��  ��  
� 
�
�
� l     ��������  ��  ��  
� 
�
�
� i  � �
�
�
� I     ��
�
�
�� .Txt:LowTnull���     ctxt
� o      ���� 0 thetext theText
� ��
���
�� 
Loca
� |����
���
���  ��  
� o      ���� 0 
localecode 
localeCode��  
� m      ��
�� 
msng��  
� Q     P
�
�
�
� k    >
�
� 
� 
� r     n    I    ������ 0 
asnsstring 
asNSString �� n    I    ��	���� "0 astextparameter asTextParameter	 

 o    ���� 0 thetext theText �� m     �  ��  ��   o    ���� 0 _support  ��  ��   o    ���� 0 _support   o      ���� 0 
asocstring 
asocString  �� Z    >�� =    o    ���� 0 
localecode 
localeCode m    ��
�� 
msng L     ( c     ' l    %���� n    % I   ! %�������� "0 lowercasestring lowercaseString��  ��   o     !���� 0 
asocstring 
asocString��  ��   m   % &��
�� 
ctxt��   L   + > c   + = l  + ;���� n  + ;  I   , ;��!���� 80 lowercasestringwithlocale_ lowercaseStringWithLocale_! "��" l  , 7#����# n  , 7$%$ I   1 7��&���� *0 asnslocaleparameter asNSLocaleParameter& '(' o   1 2���� 0 
localecode 
localeCode( )��) m   2 3** �++  f o r   l o c a l e��  ��  % o   , 1���� 0 _support  ��  ��  ��  ��    o   + ,���� 0 
asocstring 
asocString��  ��   m   ; <��
�� 
ctxt��  
� R      ��,-
�� .ascrerr ****      � ****, o      ���� 0 etext eText- ��./
�� 
errn. o      ���� 0 enumber eNumber/ ��01
�� 
erob0 o      ���� 0 efrom eFrom1 ��2��
�� 
errt2 o      ���� 
0 eto eTo��  
� I   F P��3���� 
0 _error  3 454 m   G H66 �77  l o w e r c a s e   t e x t5 898 o   H I���� 0 etext eText9 :;: o   I J���� 0 enumber eNumber; <=< o   J K���� 0 efrom eFrom= >��> o   K L�� 
0 eto eTo��  ��  
� ?@? l     �~�}�|�~  �}  �|  @ ABA l     �{�z�y�{  �z  �y  B CDC i  � �EFE I     �xGH
�x .Txt:FTxtnull���     ctxtG o      �w�w 0 templatetext templateTextH �vI�u
�v 
UsinI |�t�sJ�rK�t  �s  J o      �q�q 0 	thevalues 	theValues�r  K J      �p�p  �u  F Q     �LMNL P    �OPQO k    �RR STS r    UVU I    �oW�n�o ,0 _parseformattemplate _parseFormatTemplateW X�mX n  	 YZY I    �l[�k�l "0 astextparameter asTextParameter[ \]\ o    �j�j 0 templatetext templateText] ^�i^ m    __ �``  �i  �k  Z o   	 �h�h 0 _support  �m  �n  V o      �g�g 0 templateitems templateItemsT aba r    cdc m    �f�f d o      �e�e 0 i  b efe Q    �ghig Z   " �jk�dlj =   " -mnm l  " +o�c�bo I  " +�apq
�a .corecnte****       ****p J   " %rr s�`s o   " #�_�_ 0 	thevalues 	theValues�`  q �^t�]
�^ 
koclt m   & '�\
�\ 
scpt�]  �c  �b  n m   + ,�[�[ k l  0 Suvwu Y   0 Sx�Zyz{x r   = N|}| c   = I~~ n  = G��� I   > G�Y��X�Y 0 getitem getItem� ��W� e   > C�� n   > C��� 4   ? B�V�
�V 
cobj� o   @ A�U�U 0 i  � o   > ?�T�T 0 templateitems templateItems�W  �X  � o   = >�S�S 0 	thevalues 	theValues m   G H�R
�R 
ctxt} n      ��� 4   J M�Q�
�Q 
cobj� o   K L�P�P 0 i  � o   I J�O�O 0 templateitems templateItems�Z 0 i  y m   3 4�N�N z n  4 8��� 1   5 7�M
�M 
leng� o   4 5�L�L 0 templateitems templateItems{ m   8 9�K�K v S M assume it's a script object with getItem handler (e.g. DictionaryCollection)   w ��� �   a s s u m e   i t ' s   a   s c r i p t   o b j e c t   w i t h   g e t I t e m   h a n d l e r   ( e . g .   D i c t i o n a r y C o l l e c t i o n )�d  l l  V ����� k   V ��� ��� r   V c��� n  V a��� I   [ a�J��I�J "0 aslistparameter asListParameter� ��� o   [ \�H�H 0 	thevalues 	theValues� ��G� m   \ ]�� ��� 
 u s i n g�G  �I  � o   V [�F�F 0 _support  � o      �E�E 0 	thevalues 	theValues� ��D� Y   d ���C���� r   q ���� c   q ~��� l  q |��B�A� e   q |�� n  q |��� 4   r {�@�
�@ 
cobj� l  s z��?�>� c   s z��� l  s x��=�<� e   s x�� n   s x��� 4   t w�;�
�; 
cobj� o   u v�:�: 0 i  � o   s t�9�9 0 templateitems templateItems�=  �<  � m   x y�8
�8 
long�?  �>  � o   q r�7�7 0 	thevalues 	theValues�B  �A  � m   | }�6
�6 
ctxt� n      ��� 4    ��5�
�5 
cobj� o   � ��4�4 0 i  � o   ~ �3�3 0 templateitems templateItems�C 0 i  � m   g h�2�2 � n  h l��� 1   i k�1
�1 
leng� o   h i�0�0 0 templateitems templateItems� m   l m�/�/ �D  � * $ it's a list (or a single-item list)   � ��� H   i t ' s   a   l i s t   ( o r   a   s i n g l e - i t e m   l i s t )h R      �.��
�. .ascrerr ****      � ****� o      �-�- 0 etext eText� �,��
�, 
errn� o      �+�+ 0 enumber eNumber� �*��
�* 
erob� o      �)�) 0 efrom eFrom� �(��'
�( 
errt� o      �&�& 
0 eto eTo�'  i R   � ��%��
�% .ascrerr ****      � ****� b   � ���� b   � ���� b   � ���� m   � ��� ��� : C a n  t   s u b s i t u t e   p l a c e h o l d e r   � n   � ���� 4   � ��$�
�$ 
cobj� o   � ��#�# 0 i  � o   � ��"�" 0 templateitems templateItems� m   � ��� ���   :  � o   � ��!�! 0 etext eText� � ��
�  
errn� o   � ��� 0 enumber eNumber� ���
� 
erob� o   � ��� 0 efrom eFrom� ���
� 
errt� o   � ��� 
0 eto eTo�  f ��� L   � ��� I   � ����� 0 	_jointext 	_joinText� ��� o   � ��� 0 templateitems templateItems� ��� m   � ��� ���  �  �  �  P ��
� conscase� ��
� consdiac� ��
� conshyph� ��
� conspunc� ��
� conswhit�  Q ��
� consnume�  M R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� �
��
�
 
errn� o      �	�	 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  N I   � ����� 
0 _error  � ��� m   � ��� ���  f o r m a t   t e x t� ��� o   � ��� 0 etext eText� ��� o   � �� �  0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  �  D ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     ����
�� .Txt:Normnull���     ctxt� o      ���� 0 thetext theText� ����
�� 
NoFo� |���� ����  ��    o      ���� 0 nopts nOpts��   J       �� m      ��
�� LiBrLiOX��  � ����
�� 
Loca |��������  ��   o      ���� 0 
localecode 
localeCode��   l     ���� m       �		  n o n e��  ��  ��  � Q    

 k   i  r     n    I    ������ "0 astextparameter asTextParameter  o    	���� 0 thetext theText �� m   	 
 �  ��  ��   o    ���� 0 _support   o      ���� 0 thetext theText  r     n    I    �� ���� "0 aslistparameter asListParameter  !"! o    ���� 0 nopts nOpts" #��# m    $$ �%% 
 u s i n g��  ��   o    ���� 0 _support   o      ���� 0 nopts nOpts &'& l   ��()��  (   common case shortcuts   ) �** ,   c o m m o n   c a s e   s h o r t c u t s' +,+ Z   --.����- =    $/0/ n   "121 1     "��
�� 
leng2 o     ���� 0 thetext theText0 m   " #����  . L   ' )33 m   ' (44 �55  ��  ��  , 676 Z  . D89����8 =  . 3:;: o   . /���� 0 nopts nOpts; J   / 2<< =��= m   / 0��
�� LiBrLiOX��  9 L   6 @>> I   6 ?��?���� 0 	_jointext 	_joinText? @A@ n  7 :BCB 2  8 :��
�� 
cparC o   7 8���� 0 thetext theTextA D��D 1   : ;��
�� 
lnfd��  ��  ��  ��  7 EFE Z  E RGH����G =  E IIJI o   E F���� 0 nopts nOptsJ J   F H����  H L   L NKK o   L M���� 0 thetext theText��  ��  F LML l  S S��NO��  N &   else fully process options list   O �PP @   e l s e   f u l l y   p r o c e s s   o p t i o n s   l i s tM QRQ Q   SbSTUS k   VGVV WXW Z   V gYZ��[Y E  V [\]\ o   V W���� 0 nopts nOpts] J   W Z^^ _��_ m   W X��
�� LiBrLiOX��  Z r   ^ a`a` 1   ^ _��
�� 
lnfda o      ���� 0 	linebreak 	lineBreak��  [ r   d gbcb m   d e��
�� 
msngc o      ���� 0 	linebreak 	lineBreakX ded Z   h �fg����f E  h mhih o   h i���� 0 nopts nOptsi J   i ljj k��k m   i j��
�� LiBrLiCM��  g k   p �ll mnm Z  p �op����o >  p sqrq o   p q���� 0 	linebreak 	lineBreakr m   q r��
�� 
msngp R   v |��st
�� .ascrerr ****      � ****s m   z {uu �vv > C o n f l i c t i n g   l i n e   b r e a k   o p t i o n s .t ��w��
�� 
errnw m   x y����f��  ��  ��  n xyx Z  � �z{����z =   � �|}| n  � �~~ 1   � ���
�� 
leng o   � ����� 0 nopts nOpts} m   � ����� { L   � ��� I   � �������� 0 	_jointext 	_joinText� ��� n  � ���� 2  � ���
�� 
cpar� o   � ����� 0 thetext theText� ���� o   � ���
�� 
ret ��  ��  ��  ��  y ���� r   � ���� o   � ���
�� 
ret � o      ���� 0 	linebreak 	lineBreak��  ��  ��  e ��� Z   � �������� E  � ���� o   � ����� 0 nopts nOpts� J   � ��� ���� m   � ���
�� LiBrLiWi��  � k   � ��� ��� Z  � �������� >  � ���� o   � ����� 0 	linebreak 	lineBreak� m   � ���
�� 
msng� R   � �����
�� .ascrerr ****      � ****� m   � ��� ��� > C o n f l i c t i n g   l i n e   b r e a k   o p t i o n s .� �����
�� 
errn� m   � �����f��  ��  ��  � ��� Z  � �������� =   � ���� n  � ���� 1   � ���
�� 
leng� o   � ����� 0 nopts nOpts� m   � ����� � L   � ��� I   � �������� 0 	_jointext 	_joinText� ��� n  � ���� 2  � ���
�� 
cpar� o   � ����� 0 thetext theText� ���� b   � ���� o   � ���
�� 
ret � 1   � ���
�� 
lnfd��  ��  ��  ��  � ���� r   � ���� b   � ���� o   � ���
�� 
ret � 1   � ���
�� 
lnfd� o      ���� 0 	linebreak 	lineBreak��  ��  ��  � ��� r   � ���� n  � ���� I   � �������� 0 
asnsstring 
asNSString� ���� o   � ��� 0 thetext theText��  ��  � o   � ��~�~ 0 _support  � o      �}�} 0 
asocstring 
asocString� ��� l  � ��|���|  � , & fold case, diacriticals, and/or width   � ��� L   f o l d   c a s e ,   d i a c r i t i c a l s ,   a n d / o r   w i d t h� ��� r   � ���� m   � ��{�{  � o      �z�z 0 foldingflags foldingFlags� ��� Z  ����y�x� E  � ���� o   � ��w�w 0 nopts nOpts� J   � ��� ��v� m   � ��u
�u NoFoNoCa�v  � r   � ��� [   � ���� o   � ��t�t 0 foldingflags foldingFlags� m   � ��s�s � o      �r�r 0 foldingflags foldingFlags�y  �x  � ��� Z ���q�p� E ��� o  �o�o 0 nopts nOpts� J  �� ��n� m  	�m
�m NoFoNoDi�n  � r  ��� [  ��� o  �l�l 0 foldingflags foldingFlags� m  �k�k �� o      �j�j 0 foldingflags foldingFlags�q  �p  � ��� Z 0���i�h� E "��� o  �g�g 0 nopts nOpts� J  !�� ��f� m  �e
�e NoFoNoWi�f  � r  %,��� [  %*��� o  %&�d�d 0 foldingflags foldingFlags� m  &)�c�c � o      �b�b 0 foldingflags foldingFlags�i  �h  � ��� Z 1P���a�`� >  14��� o  12�_�_ 0 foldingflags foldingFlags� m  23�^�^  � r  7L��� n 7J��� I  8J�]��\�] H0 "stringbyfoldingwithoptions_locale_ "stringByFoldingWithOptions_locale_� ��� o  89�[�[ 0 foldingflags foldingFlags� ��Z� l 9F��Y�X� n 9F��� I  >F�W��V�W *0 asnslocaleparameter asNSLocaleParameter� ��� o  >?�U�U 0 
localecode 
localeCode� ��T� m  ?B�� ���  f o r   l o c a l e�T  �V  � o  9>�S�S 0 _support  �Y  �X  �Z  �\  � o  78�R�R 0 
asocstring 
asocString� o      �Q�Q 0 
asocstring 
asocString�a  �`  �    l QQ�P�P   !  normalize white space runs    � 6   n o r m a l i z e   w h i t e   s p a c e   r u n s  Z  Q	�O E QX

 o  QR�N�N 0 nopts nOpts J  RW �M m  RU�L
�L NoFoNoSp�M   k  [�  l [y r  [y n [w I  \w�K�J�K �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_  m  \_ � ^ \ A ( ? : \ u 2 0 2 8 | \ u 2 0 2 9 | \ s ) + | ( ? : \ u 2 0 2 8 | \ u 2 0 2 9 | \ s ) + \ z  m  _b �     !"! l bi#�I�H# n bi$%$ o  ei�G�G 60 nsregularexpressionsearch NSRegularExpressionSearch% m  be�F
�F misccura�I  �H  " &�E& J  iq'' ()( m  ij�D�D  ) *�C* n jo+,+ I  ko�B�A�@�B 
0 length  �A  �@  , o  jk�?�? 0 
asocstring 
asocString�C  �E  �J   o  [\�>�> 0 
asocstring 
asocString o      �=�= 0 
asocstring 
asocString ( " trim leading/trailing white space    �-- D   t r i m   l e a d i n g / t r a i l i n g   w h i t e   s p a c e .�<. Z  z�/0�;1/ = z}232 o  z{�:�: 0 	linebreak 	lineBreak3 m  {|�9
�9 
msng0 l ��4564 r  ��787 n ��9:9 I  ���8;�7�8 �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_; <=< m  ��>> �?? @ ( ? : \ r \ n | \ r | \ n | \ u 2 0 2 8 | \ u 2 0 2 9 | \ s ) += @A@ 1  ���6
�6 
spacA BCB l ��D�5�4D n ��EFE o  ���3�3 60 nsregularexpressionsearch NSRegularExpressionSearchF m  ���2
�2 misccura�5  �4  C G�1G J  ��HH IJI m  ���0�0  J K�/K n ��LML I  ���.�-�,�. 
0 length  �-  �,  M o  ���+�+ 0 
asocstring 
asocString�/  �1  �7  : o  ���*�* 0 
asocstring 
asocString8 o      �)�) 0 
asocstring 
asocString5 b \ also convert line breaks (including Unicode line and paragraph separators) to single spaces   6 �NN �   a l s o   c o n v e r t   l i n e   b r e a k s   ( i n c l u d i n g   U n i c o d e   l i n e   a n d   p a r a g r a p h   s e p a r a t o r s )   t o   s i n g l e   s p a c e s�;  1 l ��OPQO k  ��RR STS r  ��UVU n ��WXW I  ���(Y�'�( �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_Y Z[Z m  ��\\ �]] N ( ? : \ s * ( ? : \ r \ n | \ r | \ n | \ u 2 0 2 8 | \ u 2 0 2 9 ) ) + \ s *[ ^_^ o  ���&�& 0 	linebreak 	lineBreak_ `a` l ��b�%�$b n ��cdc o  ���#�# 60 nsregularexpressionsearch NSRegularExpressionSearchd m  ���"
�" misccura�%  �$  a e�!e J  ��ff ghg m  ��� �   h i�i n ��jkj I  ������ 
0 length  �  �  k o  ���� 0 
asocstring 
asocString�  �!  �'  X o  ���� 0 
asocstring 
asocStringV o      �� 0 
asocstring 
asocStringT l�l r  ��mnm n ��opo I  ���q�� �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_q rsr m  ��tt �uu  [ \ f \ t \ p { Z } ] +s vwv 1  ���
� 
spacw xyx l ��z��z n ��{|{ o  ���� 60 nsregularexpressionsearch NSRegularExpressionSearch| m  ���
� misccura�  �  y }�} J  ��~~ � m  ����  � ��� n ����� I  ������ 
0 length  �  �  � o  ���
�
 0 
asocstring 
asocString�  �  �  p o  ���	�	 0 
asocstring 
asocStringn o      �� 0 
asocstring 
asocString�  P � � convert line break runs (including any other white space) to single `lineBreak`, and any other white space runs (tabs, spaces, etc) to single spaces   Q ���*   c o n v e r t   l i n e   b r e a k   r u n s   ( i n c l u d i n g   a n y   o t h e r   w h i t e   s p a c e )   t o   s i n g l e   ` l i n e B r e a k ` ,   a n d   a n y   o t h e r   w h i t e   s p a c e   r u n s   ( t a b s ,   s p a c e s ,   e t c )   t o   s i n g l e   s p a c e s�<  	 ��� > ����� o  ���� 0 	linebreak 	lineBreak� m  ���
� 
msng� ��� l ����� r  ���� n ����� I  ������ �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_� ��� m  ���� ��� 0 \ r \ n | \ r | \ n | \ u 2 0 2 8 | \ u 2 0 2 9� ��� o  ���� 0 	linebreak 	lineBreak� ��� l ����� � n ����� o  ������ 60 nsregularexpressionsearch NSRegularExpressionSearch� m  ����
�� misccura�  �   � ���� J  ���� ��� m  ������  � ���� n ����� I  ���������� 
0 length  ��  ��  � o  ������ 0 
asocstring 
asocString��  ��  �  � o  ������ 0 
asocstring 
asocString� o      ���� 0 
asocstring 
asocString�   standardize line breaks   � ��� 0   s t a n d a r d i z e   l i n e   b r e a k s�  �O   ��� l ������  � 8 2 apply punctuation, ASCII-only transforms (10.11+)   � ��� d   a p p l y   p u n c t u a t i o n ,   A S C I I - o n l y   t r a n s f o r m s   ( 1 0 . 1 1 + )� ��� Z  ������� E ��� o  ���� 0 nopts nOpts� J  �� ���� m  
��
�� NoFoNoSP��  � k  @�� ��� Z 4������� G  %��� E ��� o  ���� 0 nopts nOpts� J  �� ���� m  ��
�� NoFoNoTP��  � E !��� o  ���� 0 nopts nOpts� J   �� ���� m  ��
�� NoFoNoAO��  � R  (0����
�� .ascrerr ****      � ****� m  ,/�� ��� J C o n f l i c t i n g   p u n c t u a t i o n / A S C I I   o p t i o n s� �����
�� 
errn� m  *+����f��  ��  ��  � ���� r  5@��� n 5>��� I  6>������� H0 "stringbyapplyingtransform_reverse_ "stringByApplyingTransform_reverse_� ��� l 69������ m  69�� ���  A n y - P u b l i s h i n g��  ��  � ���� m  9:��
�� boovfals��  ��  � o  56���� 0 
asocstring 
asocString� o      ���� 0 
asocstring 
asocString��  � ��� E CJ��� o  CD���� 0 nopts nOpts� J  DI�� ���� m  DG��
�� NoFoNoTP��  � ��� k  Mo�� ��� Z Mc������� E MT��� o  MN���� 0 nopts nOpts� J  NS�� ���� m  NQ��
�� NoFoNoAO��  � R  W_����
�� .ascrerr ****      � ****� m  [^�� ��� L C o n f l i c t i n g   p u n c t u a t i o n / A S C I I   o p t i o n s .� �����
�� 
errn� m  YZ����f��  ��  ��  � ���� r  do��� n dm��� I  em������� H0 "stringbyapplyingtransform_reverse_ "stringByApplyingTransform_reverse_� ��� l eh������ m  eh�� ���  P u b l i s h i n g - A n y��  ��  � ���� m  hi��
�� boovfals��  ��  � o  de���� 0 
asocstring 
asocString� o      ���� 0 
asocstring 
asocString��  � ��� E ry��� o  rs���� 0 nopts nOpts� J  sx�� ���� m  sv��
�� NoFoNoAO��  � ���� k  |��� ��� r  |�� � n |� I  }������� H0 "stringbyapplyingtransform_reverse_ "stringByApplyingTransform_reverse_  l }����� m  }� � * A n y - L a t i n ; L a t i n - A S C I I��  ��   	��	 m  ����
�� boovfals��  ��   o  |}���� 0 
asocstring 
asocString  o      ���� 0 
asocstring 
asocString� 
��
 r  �� n �� I  �������� �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_  m  �� � , [ ^ \ r \ n \ t \ u 0 0 2 0 - \ u 0 0 7 e ]  m  �� �  ?  l ������ n �� o  ������ 60 nsregularexpressionsearch NSRegularExpressionSearch m  ����
�� misccura��  ��   �� J  ��   m  ������    !��! n ��"#" I  ���������� 
0 length  ��  ��  # o  ������ 0 
asocstring 
asocString��  ��  ��   o  ������ 0 
asocstring 
asocString o      ���� 0 
asocstring 
asocString��  ��  ��  � $%$ l ����&'��  & 6 0 convert to specified Unicode normalization form   ' �(( `   c o n v e r t   t o   s p e c i f i e d   U n i c o d e   n o r m a l i z a t i o n   f o r m% )*) Z  ��+,��-+ E ��./. o  ������ 0 nopts nOpts/ J  ��00 1��1 m  ����
�� NoFoNo_C��  , k  ��22 343 r  ��565 n ��787 I  ���������� N0 %precomposedstringwithcanonicalmapping %precomposedStringWithCanonicalMapping��  ��  8 o  ������ 0 
asocstring 
asocString6 o      ���� 0 
asocstring 
asocString4 9��9 r  ��:;: m  ����
�� boovtrue; o      ���� 0 didnormalize didNormalize��  ��  - r  ��<=< m  ����
�� boovfals= o      ���� 0 didnormalize didNormalize* >?> Z  ��@A����@ E ��BCB o  ������ 0 nopts nOptsC J  ��DD E��E m  ����
�� NoFoNo_D��  A k  ��FF GHG Z ��IJ����I o  ������ 0 didnormalize didNormalizeJ R  ����KL
�� .ascrerr ****      � ****K m  ��MM �NN 8 C o n f l i c t i n g   U n i c o d e   o p t i o n s .L ��O��
�� 
errnO m  ������f��  ��  ��  H PQP r  ��RSR n ��TUT I  ���������� L0 $decomposedstringwithcanonicalmapping $decomposedStringWithCanonicalMapping��  ��  U o  ������ 0 
asocstring 
asocStringS o      ���� 0 
asocstring 
asocStringQ V��V r  ��WXW m  ����
�� boovtrueX o      ���� 0 didnormalize didNormalize��  ��  ��  ? YZY Z  �[\����[ E ��]^] o  ������ 0 nopts nOpts^ J  ��__ `��` m  ����
�� NoFoNoKC��  \ k  �aa bcb Z �de����d o  ���� 0 didnormalize didNormalizee R   �~fg
�~ .ascrerr ****      � ****f m  hh �ii 8 C o n f l i c t i n g   U n i c o d e   o p t i o n s .g �}j�|
�} 
errnj m  �{�{f�|  ��  ��  c klk r  mnm n opo I  �z�y�x�z V0 )precomposedstringwithcompatibilitymapping )precomposedStringWithCompatibilityMapping�y  �x  p o  �w�w 0 
asocstring 
asocStringn o      �v�v 0 
asocstring 
asocStringl q�uq r  rsr m  �t
�t boovtrues o      �s�s 0 didnormalize didNormalize�u  ��  ��  Z t�rt Z  Guv�q�pu E $wxw o  �o�o 0 nopts nOptsx J  #yy z�nz m  !�m
�m NoFoNoKD�n  v k  'C{{ |}| Z '7~�l�k~ o  '(�j�j 0 didnormalize didNormalize R  +3�i��
�i .ascrerr ****      � ****� m  /2�� ��� 8 C o n f l i c t i n g   U n i c o d e   o p t i o n s .� �h��g
�h 
errn� m  -.�f�ff�g  �l  �k  } ��� r  8?��� n 8=��� I  9=�e�d�c�e T0 (decomposedstringwithcompatibilitymapping (decomposedStringWithCompatibilityMapping�d  �c  � o  89�b�b 0 
asocstring 
asocString� o      �a�a 0 
asocstring 
asocString� ��`� r  @C��� m  @A�_
�_ boovtrue� o      �^�^ 0 didnormalize didNormalize�`  �q  �p  �r  T R      �]��
�] .ascrerr ****      � ****� o      �\�\ 0 etext eText� �[��Z
�[ 
errn� m      �Y�Yf�Z  U n Ob��� I  Tb�X��W�X .0 throwinvalidparameter throwInvalidParameter� ��� o  TU�V�V 0 nopts nOpts� ��� m  UX�� ��� 
 u s i n g� ��� m  X[�U
�U 
list� ��T� o  [\�S�S 0 etext eText�T  �W  � o  OT�R�R 0 _support  R ��Q� L  ci�� c  ch��� o  cd�P�P 0 
asocstring 
asocString� m  dg�O
�O 
ctxt�Q   R      �N��
�N .ascrerr ****      � ****� o      �M�M 0 etext eText� �L��
�L 
errn� o      �K�K 0 enumber eNumber� �J��
�J 
erob� o      �I�I 0 efrom eFrom� �H��G
�H 
errt� o      �F�F 
0 eto eTo�G   I  q�E��D�E 
0 _error  � ��� m  ru�� ���  n o r m a l i z e   t e x t� ��� o  uv�C�C 0 etext eText� ��� o  vw�B�B 0 enumber eNumber� ��� o  wx�A�A 0 efrom eFrom� ��@� o  xy�?�? 
0 eto eTo�@  �D  � ��� l     �>�=�<�>  �=  �<  � ��� l     �;�:�9�;  �:  �9  � ��� i  � ���� I     �8��
�8 .Txt:PadTnull���     ctxt� o      �7�7 0 thetext theText� �6��
�6 
toPl� o      �5�5 0 	textwidth 	textWidth� �4��
�4 
Char� |�3�2��1��3  �2  � o      �0�0 0 padtext padText�1  � l     ��/�.� m      �� ���                                  �/  �.  � �-��,
�- 
From� |�+�*��)��+  �*  � o      �(�( 0 whichend whichEnd�)  � l     ��'�&� m      �%
�% LeTrLCha�'  �&  �,  � Q    ���� k   �� ��� r    ��� n   ��� I    �$��#�$ "0 astextparameter asTextParameter� ��� o    	�"�" 0 thetext theText� ��!� m   	 
�� ���  �!  �#  � o    � �  0 _support  � o      �� 0 thetext theText� ��� r    ��� n   ��� I    ���� (0 asintegerparameter asIntegerParameter� ��� o    �� 0 	textwidth 	textWidth� ��� m    �� ���  t o   p l a c e s�  �  � o    �� 0 _support  � o      �� 0 	textwidth 	textWidth� ��� r    &��� \    $��� o     �� 0 	textwidth 	textWidth� l    #���� n    #��� 1   ! #�
� 
leng� o     !�� 0 thetext theText�  �  � o      �� 0 
widthtoadd 
widthToAdd� ��� Z  ' 3����� B   ' *��� o   ' (�� 0 
widthtoadd 
widthToAdd� m   ( )��  � L   - /�� o   - .�� 0 thetext theText�  �  � ��� r   4 A��� n  4 ?��� I   9 ?���� "0 astextparameter asTextParameter� ��� o   9 :�� 0 padtext padText�  �
  m   : ; � 
 u s i n g�
  �  � o   4 9�	�	 0 _support  � o      �� 0 padtext padText�  r   B G n  B E 1   C E�
� 
leng o   B C�� 0 padtext padText o      �� 0 padsize padSize 	
	 Z  H a�� =   H M n  H K 1   I K�
� 
leng o   H I�� 0 padtext padText m   K L� �    n  P ] I   U ]������ .0 throwinvalidparameter throwInvalidParameter  o   U V���� 0 padtext padText  m   V W � 
 u s i n g  m   W X��
�� 
ctxt �� m   X Y � ( C a n  t   b e   e m p t y   t e x t .��  ��   o   P U���� 0 _support  �  �  
   V   b x!"! r   n s#$# b   n q%&% o   n o���� 0 padtext padText& o   o p���� 0 padtext padText$ o      ���� 0 padtext padText" A   f m'(' n  f i)*) 1   g i��
�� 
leng* o   f g���� 0 padtext padText( l  i l+����+ [   i l,-, o   i j���� 0 
widthtoadd 
widthToAdd- o   j k���� 0 padsize padSize��  ��    .��. Z   y/012/ =  y |343 o   y z���� 0 whichend whichEnd4 m   z {��
�� LeTrLCha0 L    �55 b    �676 l   �8����8 n   �9:9 7  � ���;<
�� 
ctxt; m   � ����� < o   � ����� 0 
widthtoadd 
widthToAdd: o    ����� 0 padtext padText��  ��  7 o   � ����� 0 thetext theText1 =>= =  � �?@? o   � ����� 0 whichend whichEnd@ m   � ���
�� LeTrTCha> ABA k   � �CC DED r   � �FGF `   � �HIH l  � �J����J n  � �KLK 1   � ���
�� 
lengL o   � ����� 0 thetext theText��  ��  I o   � ����� 0 padsize padSizeG o      ���� 0 	padoffset 	padOffsetE M��M L   � �NN b   � �OPO o   � ����� 0 thetext theTextP l  � �Q����Q n  � �RSR 7  � ���TU
�� 
ctxtT l  � �V����V [   � �WXW m   � ����� X o   � ����� 0 	padoffset 	padOffset��  ��  U l  � �Y����Y [   � �Z[Z o   � ����� 0 	padoffset 	padOffset[ o   � ����� 0 
widthtoadd 
widthToAdd��  ��  S o   � ����� 0 padtext padText��  ��  ��  B \]\ =  � �^_^ o   � ����� 0 whichend whichEnd_ m   � ���
�� LeTrBCha] `��` k   � �aa bcb Z  � �de����d ?   � �fgf o   � ����� 0 
widthtoadd 
widthToAddg m   � ����� e r   � �hih b   � �jkj n  � �lml 7  � ���no
�� 
ctxtn m   � ����� o l  � �p����p _   � �qrq o   � ����� 0 
widthtoadd 
widthToAddr m   � ����� ��  ��  m o   � ����� 0 padtext padTextk o   � ����� 0 thetext theTexti o      ���� 0 thetext theText��  ��  c sts r   � �uvu `   � �wxw l  � �y����y n  � �z{z 1   � ���
�� 
leng{ o   � ����� 0 thetext theText��  ��  x o   � ����� 0 padsize padSizev o      ���� 0 	padoffset 	padOffsett |��| L   � �}} b   � �~~ o   � ����� 0 thetext theText l  � ������� n  � ���� 7  � �����
�� 
ctxt� l  � ������� [   � ���� m   � ����� � o   � ����� 0 	padoffset 	padOffset��  ��  � l  � ������� [   � ���� o   � ����� 0 	padoffset 	padOffset� _   � ���� l  � ������� [   � ���� o   � ����� 0 
widthtoadd 
widthToAdd� m   � ����� ��  ��  � m   � ����� ��  ��  � o   � ����� 0 padtext padText��  ��  ��  ��  2 n  ���� I   �������� >0 throwinvalidconstantparameter throwInvalidConstantParameter� ��� o   � ����� 0 whichend whichEnd� ���� m   � ��� ���  a d d i n g��  ��  � o   � ����� 0 _support  ��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I  	������� 
0 _error  � ��� m  
�� ���  p a d   t e x t� ��� o  ���� 0 etext eText� ��� o  ���� 0 enumber eNumber� ��� o  ���� 0 efrom eFrom� ���� o  ���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     ����
�� .Txt:SliTnull���     ctxt� o      ���� 0 thetext theText� ����
�� 
FIdx� |����������  ��  � o      ���� 0 
startindex 
startIndex��  � l     ������ m      ��
�� 
msng��  ��  � �����
�� 
TIdx� |���������  ��  � o      �~�~ 0 endindex endIndex�  � l     ��}�|� m      �{
�{ 
msng�}  �|  ��  � Q    ����� k   ��� ��� r    ��� n   ��� I    �z��y�z "0 astextparameter asTextParameter� ��� o    	�x�x 0 thetext theText� ��w� m   	 
�� ���  �w  �y  � o    �v�v 0 _support  � o      �u�u 0 thetext theText� ��� r    ��� n   ��� 1    �t
�t 
leng� o    �s�s 0 thetext theText� o      �r�r 0 	thelength 	theLength� ��� Z    S���q�p� =    ��� o    �o�o 0 	thelength 	theLength� m    �n�n  � k    O�� ��� l   �m���m  � � � note: index 0 is always disallowed as its position is ambiguous, being both before index 1 at start of text and after index -1 at end of text   � ���   n o t e :   i n d e x   0   i s   a l w a y s   d i s a l l o w e d   a s   i t s   p o s i t i o n   i s   a m b i g u o u s ,   b e i n g   b o t h   b e f o r e   i n d e x   1   a t   s t a r t   o f   t e x t   a n d   a f t e r   i n d e x   - 1   a t   e n d   o f   t e x t� ��� Z   4���l�k� =     ��� o    �j�j 0 
startindex 
startIndex� m    �i�i  � n  # 0��� I   ( 0�h��g�h .0 throwinvalidparameter throwInvalidParameter� ��� o   ( )�f�f 0 
startindex 
startIndex� ��� m   ) *�� ���  f r o m� ��� m   * +�e
�e 
long� ��d� m   + ,�� ��� " I n d e x   c a n  t   b e   0 .�d  �g  � o   # (�c�c 0 _support  �l  �k  � ��� Z  5 L���b�a� =   5 8��� o   5 6�`�` 0 endindex endIndex� m   6 7�_�_  � n  ; H��� I   @ H�^��]�^ .0 throwinvalidparameter throwInvalidParameter� ��� o   @ A�\�\ 0 endindex endIndex� � � m   A B �  t o   m   B C�[
�[ 
long �Z m   C D � " I n d e x   c a n  t   b e   0 .�Z  �]  � o   ; @�Y�Y 0 _support  �b  �a  � �X L   M O		 m   M N

 �  �X  �q  �p  �  Z   T ��W >  T W o   T U�V�V 0 
startindex 
startIndex m   U V�U
�U 
msng k   Z �  r   Z g n  Z e I   _ e�T�S�T (0 asintegerparameter asIntegerParameter  o   _ `�R�R 0 
startindex 
startIndex �Q m   ` a �  f r o m�Q  �S   o   Z _�P�P 0 _support   o      �O�O 0 
startindex 
startIndex  !  Z  h "#�N�M" =   h k$%$ o   h i�L�L 0 
startindex 
startIndex% m   i j�K�K  # n  n {&'& I   s {�J(�I�J .0 throwinvalidparameter throwInvalidParameter( )*) o   s t�H�H 0 
startindex 
startIndex* +,+ m   t u-- �..  f r o m, /0/ m   u v�G
�G 
long0 1�F1 m   v w22 �33 " I n d e x   c a n  t   b e   0 .�F  �I  ' o   n s�E�E 0 _support  �N  �M  ! 4�D4 Z   � �56�C�B5 =  � �787 o   � ��A�A 0 endindex endIndex8 m   � ��@
�@ 
msng6 Z   � �9:;<9 A   � �=>= o   � ��?�? 0 
startindex 
startIndex> d   � �?? o   � ��>�> 0 	thelength 	theLength: L   � �@@ o   � ��=�= 0 thetext theText; ABA ?   � �CDC o   � ��<�< 0 
startindex 
startIndexD o   � ��;�; 0 	thelength 	theLengthB E�:E L   � �FF m   � �GG �HH  �:  < L   � �II n  � �JKJ 7  � ��9LM
�9 
ctxtL o   � ��8�8 0 
startindex 
startIndexM m   � ��7�7��K o   � ��6�6 0 thetext theText�C  �B  �D   NON =  � �PQP o   � ��5�5 0 endindex endIndexQ m   � ��4
�4 
msngO R�3R R   � ��2ST
�2 .ascrerr ****      � ****S m   � �UU �VV v E x p e c t e d    f r o m    a n d / o r    t o    p a r a m e t e r   b u t   r e c e i v e d   n e i t h e r .T �1W�0
�1 
errnW m   � ��/�/�[�0  �3  �W   XYX Z   �4Z[�.�-Z >  � �\]\ o   � ��,�, 0 endindex endIndex] m   � ��+
�+ 
msng[ k   �0^^ _`_ r   � �aba n  � �cdc I   � ��*e�)�* (0 asintegerparameter asIntegerParametere fgf o   � ��(�( 0 endindex endIndexg h�'h m   � �ii �jj  t o�'  �)  d o   � ��&�& 0 _support  b o      �%�% 0 endindex endIndex` klk Z  � �mn�$�#m =   � �opo o   � ��"�" 0 endindex endIndexp m   � ��!�!  n n  � �qrq I   � �� s��  .0 throwinvalidparameter throwInvalidParameters tut o   � ��� 0 endindex endIndexu vwv m   � �xx �yy  t ow z{z m   � ��
� 
long{ |�| m   � �}} �~~ " I n d e x   c a n  t   b e   0 .�  �  r o   � ��� 0 _support  �$  �#  l � Z   �0����� =  ���� o   � ��� 0 
startindex 
startIndex� m   � �
� 
msng� Z  ,����� A  ��� o  �� 0 endindex endIndex� d  �� o  �� 0 	thelength 	theLength� L  �� m  �� ���  � ��� ?  ��� o  �� 0 endindex endIndex� o  �� 0 	thelength 	theLength� ��� L  �� o  �� 0 thetext theText�  � L  ,�� n +��� 7 *���
� 
ctxt� m  $&�� � o  ')�� 0 endindex endIndex� o  �� 0 thetext theText�  �  �  �.  �-  Y ��� l 55����  � + % both start and end indexes are given   � ��� J   b o t h   s t a r t   a n d   e n d   i n d e x e s   a r e   g i v e n� ��� Z 5F���
�	� A  58��� o  56�� 0 
startindex 
startIndex� m  67��  � r  ;B��� [  ;@��� [  ;>��� o  ;<�� 0 	thelength 	theLength� m  <=�� � o  >?�� 0 
startindex 
startIndex� o      �� 0 
startindex 
startIndex�
  �	  � ��� Z GX����� A  GJ��� o  GH� �  0 endindex endIndex� m  HI����  � r  MT��� [  MR��� [  MP��� o  MN���� 0 	thelength 	theLength� m  NO���� � o  PQ���� 0 endindex endIndex� o      ���� 0 endindex endIndex�  �  � ��� Z Y�������� G  Y���� G  Yp��� ?  Y\��� o  YZ���� 0 
startindex 
startIndex� o  Z[���� 0 endindex endIndex� F  _l��� A  _b��� o  _`���� 0 
startindex 
startIndex� m  `a���� � A  eh��� o  ef���� 0 endindex endIndex� l 
fg������ m  fg���� ��  ��  � F  s���� ?  sv��� o  st���� 0 
startindex 
startIndex� o  tu���� 0 	thelength 	theLength� ?  y|��� o  yz���� 0 endindex endIndex� o  z{���� 0 	thelength 	theLength� L  ���� m  ���� ���  ��  ��  � ��� Z  �������� A  ����� o  ������ 0 
startindex 
startIndex� m  ������ � r  ����� m  ������ � o      ���� 0 
startindex 
startIndex� ��� ?  ����� o  ������ 0 
startindex 
startIndex� o  ������ 0 	thelength 	theLength� ���� r  ����� o  ������ 0 	thelength 	theLength� o      ���� 0 
startindex 
startIndex��  ��  � ��� Z  �������� A  ����� o  ������ 0 endindex endIndex� m  ������ � r  ����� m  ������ � o      ���� 0 endindex endIndex� ��� ?  ����� o  ������ 0 endindex endIndex� o  ������ 0 	thelength 	theLength� ���� r  ����� o  ������ 0 	thelength 	theLength� o      ���� 0 endindex endIndex��  ��  � ���� L  ���� n  ����� 7 ������
�� 
ctxt� o  ������ 0 
startindex 
startIndex� o  ������ 0 endindex endIndex� o  ������ 0 thetext theText��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I  ��������� 
0 _error  � ��� m  ��   �  s l i c e   t e x t�  o  ������ 0 etext eText  o  ������ 0 enumber eNumber  o  ������ 0 efrom eFrom �� o  ������ 
0 eto eTo��  ��  � 	
	 l     ��������  ��  ��  
  l     ��������  ��  ��    i  � � I     ��
�� .Txt:TrmTnull���     ctxt o      ���� 0 thetext theText ����
�� 
From |��������  ��   o      ���� 0 whichend whichEnd��   l     ���� m      ��
�� LeTrBCha��  ��  ��   Q     � k    �  r     n     I    ��!���� "0 astextparameter asTextParameter! "#" o    	���� 0 thetext theText# $��$ m   	 
%% �&&  ��  ��    o    ���� 0 _support   o      ���� 0 thetext theText '(' Z    -)*����) H    ++ E   ,-, J    .. /0/ m    ��
�� LeTrLCha0 121 m    ��
�� LeTrTCha2 3��3 m    ��
�� LeTrBCha��  - J    44 5��5 o    ���� 0 whichend whichEnd��  * n   )676 I   # )��8���� >0 throwinvalidconstantparameter throwInvalidConstantParameter8 9:9 o   # $���� 0 whichend whichEnd: ;��; m   $ %<< �==  r e m o v i n g��  ��  7 o    #���� 0 _support  ��  ��  ( >��> P   . �?@A? k   3 �BB CDC l  3 ?EFGE Z  3 ?HI����H =  3 6JKJ o   3 4���� 0 thetext theTextK m   4 5LL �MM  I L   9 ;NN m   9 :OO �PP  ��  ��  F H B check if theText is empty or contains white space characters only   G �QQ �   c h e c k   i f   t h e T e x t   i s   e m p t y   o r   c o n t a i n s   w h i t e   s p a c e   c h a r a c t e r s   o n l yD RSR r   @ STUT J   @ DVV WXW m   @ A���� X Y��Y m   A B��������  U J      ZZ [\[ o      ���� 0 
startindex 
startIndex\ ]��] o      ���� 0 endindex endIndex��  S ^_^ Z   T x`a����` E  T \bcb J   T Xdd efe m   T U��
�� LeTrLChaf g��g m   U V��
�� LeTrBCha��  c J   X [hh i��i o   X Y�� 0 whichend whichEnd��  a V   _ tjkj r   j olml [   j mnon o   j k�� 0 
startindex 
startIndexo m   k l�� m o      �� 0 
startindex 
startIndexk =  c ipqp n   c grsr 4   d g�t
� 
cha t o   e f�� 0 
startindex 
startIndexs o   c d�� 0 thetext theTextq m   g huu �vv  ��  ��  _ wxw Z   y �yz��y E  y �{|{ J   y }}} ~~ m   y z�
� LeTrTCha ��� m   z {�
� LeTrBCha�  | J   } ��� ��� o   } ~�� 0 whichend whichEnd�  z V   � ���� r   � ���� \   � ���� o   � ��� 0 endindex endIndex� m   � ��� � o      �� 0 endindex endIndex� =  � ���� n   � ���� 4   � ��~�
�~ 
cha � o   � ��}�} 0 endindex endIndex� o   � ��|�| 0 thetext theText� m   � ��� ���  �  �  x ��{� L   � ��� n   � ���� 7  � ��z��
�z 
ctxt� o   � ��y�y 0 
startindex 
startIndex� o   � ��x�x 0 endindex endIndex� o   � ��w�w 0 thetext theText�{  @ �v�
�v conscase� �u�
�u consdiac� �t�
�t conshyph� �s�r
�s conspunc�r  A �q�
�q consnume� �p�o
�p conswhit�o  ��   R      �n��
�n .ascrerr ****      � ****� o      �m�m 0 etext eText� �l��
�l 
errn� o      �k�k 0 enumber eNumber� �j��
�j 
erob� o      �i�i 0 efrom eFrom� �h��g
�h 
errt� o      �f�f 
0 eto eTo�g   I   � ��e��d�e 
0 _error  � ��� m   � ��� ���  t r i m   t e x t� ��� o   � ��c�c 0 etext eText� ��� o   � ��b�b 0 enumber eNumber� ��� o   � ��a�a 0 efrom eFrom� ��`� o   � ��_�_ 
0 eto eTo�`  �d   ��� l     �^�]�\�^  �]  �\  � ��� l     �[�Z�Y�[  �Z  �Y  � ��� l     �X���X  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �W���W  �   Split and Join Suite   � ��� *   S p l i t   a n d   J o i n   S u i t e� ��� l     �V�U�T�V  �U  �T  � ��� i  � ���� I      �S��R�S .0 _aslinebreakparameter _asLineBreakParameter� ��� o      �Q�Q 0 linebreaktype lineBreakType� ��P� o      �O�O 0 parametername parameterName�P  �R  � l    /���� Z     /����� =    ��� o     �N�N 0 linebreaktype lineBreakType� m    �M
�M LiBrLiOX� L    	�� 1    �L
�L 
lnfd� ��� =   ��� o    �K�K 0 linebreaktype lineBreakType� m    �J
�J LiBrLiCM� ��� L    �� o    �I
�I 
ret � ��� =   ��� o    �H�H 0 linebreaktype lineBreakType� m    �G
�G LiBrLiWi� ��F� L    !�� b     ��� o    �E
�E 
ret � 1    �D
�D 
lnfd�F  � n  $ /��� I   ) /�C��B�C >0 throwinvalidconstantparameter throwInvalidConstantParameter� ��� o   ) *�A�A 0 linebreaktype lineBreakType� ��@� o   * +�?�? 0 parametername parameterName�@  �B  � o   $ )�>�> 0 _support  � < 6 used by `join paragraphs` and `normalize line breaks`   � ��� l   u s e d   b y   ` j o i n   p a r a g r a p h s `   a n d   ` n o r m a l i z e   l i n e   b r e a k s `� ��� l     �=�<�;�=  �<  �;  � ��� l     �:�9�8�:  �9  �8  � ��� i  � ���� I      �7��6�7 0 
_splittext 
_splitText� ��� o      �5�5 0 thetext theText� ��4� o      �3�3 0 theseparator theSeparator�4  �6  � l    ^���� k     ^�� ��� r     ��� n    
��� I    
�2��1�2 0 aslist asList� ��0� o    �/�/ 0 theseparator theSeparator�0  �1  � o     �.�. 0 _support  � o      �-�- 0 delimiterlist delimiterList� ��� X    C��, � Q    > l    ) r     ) c     %	
	 n     # 1   ! #�+
�+ 
pcnt o     !�*�* 0 aref aRef
 m   # $�)
�) 
ctxt n       1   & (�(
�( 
pcnt o   % &�'�' 0 aref aRef�� caution: AS silently ignores invalid TID values, so separator items must be explicitly validated to catch any user errors; for now, just coerce to text and catch errors, but might want to make it more rigorous in future (e.g. if a list of lists is given, should sublist be treated as an error instead of just coercing it to text, which is itself TIDs sensitive); see also existing TODO on TypeSupport's asTextParameter handler    �V   c a u t i o n :   A S   s i l e n t l y   i g n o r e s   i n v a l i d   T I D   v a l u e s ,   s o   s e p a r a t o r   i t e m s   m u s t   b e   e x p l i c i t l y   v a l i d a t e d   t o   c a t c h   a n y   u s e r   e r r o r s ;   f o r   n o w ,   j u s t   c o e r c e   t o   t e x t   a n d   c a t c h   e r r o r s ,   b u t   m i g h t   w a n t   t o   m a k e   i t   m o r e   r i g o r o u s   i n   f u t u r e   ( e . g .   i f   a   l i s t   o f   l i s t s   i s   g i v e n ,   s h o u l d   s u b l i s t   b e   t r e a t e d   a s   a n   e r r o r   i n s t e a d   o f   j u s t   c o e r c i n g   i t   t o   t e x t ,   w h i c h   i s   i t s e l f   T I D s   s e n s i t i v e ) ;   s e e   a l s o   e x i s t i n g   T O D O   o n   T y p e S u p p o r t ' s   a s T e x t P a r a m e t e r   h a n d l e r R      �&�%
�& .ascrerr ****      � ****�%   �$�#
�$ 
errn d       m      �"�"��#   n  1 > I   6 >�!� �! 60 throwinvalidparametertype throwInvalidParameterType  o   6 7�� 0 aref aRef  m   7 8 � 
 u s i n g  m   8 9�
� 
ctxt � m   9 : �    l i s t   o f   t e x t�  �    o   1 6�� 0 _support  �, 0 aref aRef  o    �� 0 delimiterlist delimiterList� !"! r   D I#$# n  D G%&% 1   E G�
� 
txdl& 1   D E�
� 
ascr$ o      �� 0 oldtids oldTIDs" '(' r   J O)*) o   J K�� 0 delimiterlist delimiterList* n     +,+ 1   L N�
� 
txdl, 1   K L�
� 
ascr( -.- r   P U/0/ n   P S121 2  Q S�
� 
citm2 o   P Q�� 0 thetext theText0 o      �� 0 
resultlist 
resultList. 343 r   V [565 o   V W�� 0 oldtids oldTIDs6 n     787 1   X Z�
� 
txdl8 1   W X�
� 
ascr4 9�9 L   \ ^:: o   \ ]�� 0 
resultlist 
resultList�  � � � used by `split text` to split text using one or more text item delimiters and current or predefined considering/ignoring settings   � �;;   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   o n e   o r   m o r e   t e x t   i t e m   d e l i m i t e r s   a n d   c u r r e n t   o r   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s� <=< l     ���
�  �  �
  = >?> l     �	���	  �  �  ? @A@ i  � �BCB I      �D�� 0 _splitpattern _splitPatternD EFE o      �� 0 thetext theTextF G�G o      �� 0 patterntext patternText�  �  C l    �HIJH k     �KK LML Z    NO�� N =     PQP l    	R����R I    	��ST
�� .corecnte****       ****S J     UU V��V o     ���� 0 patterntext patternText��  T ��W��
�� 
koclW m    ��
�� 
list��  ��  ��  Q m   	 
���� O r    XYX I   ��Z[
�� .Txt:JoiTnull���     ****Z o    ���� 0 patterntext patternText[ ��\��
�� 
Sepa\ m    ]] �^^  |��  Y o      ���� 0 patterntext patternText�  �   M _`_ r    %aba I    #��c���� B0 _asnsregularexpressionparameter _asNSRegularExpressionParameterc ded o    ���� 0 patterntext patternTexte f��f m    gg �hh  a t��  ��  b o      ���� 0 asocpattern asocPattern` iji r   & 2klk n  & 0mnm I   + 0��o���� ,0 asnormalizednsstring asNormalizedNSStringo p��p o   + ,���� 0 thetext theText��  ��  n o   & +���� 0 _support  l o      ���� 0 
asocstring 
asocStringj qrq l  3 6stus r   3 6vwv m   3 4����  w o      ���� &0 asocnonmatchstart asocNonMatchStartt G A used to calculate NSRanges for non-matching portions of NSString   u �xx �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n gr yzy r   7 ;{|{ J   7 9����  | o      ���� 0 
resultlist 
resultListz }~} l  < <�����   @ : iterate over each non-matched + matched range in NSString   � ��� t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n g~ ��� r   < M��� n  < K��� I   = K������� @0 matchesinstring_options_range_ matchesInString_options_range_� ��� o   = >���� 0 
asocstring 
asocString� ��� m   > ?����  � ���� J   ? G�� ��� m   ? @����  � ���� n  @ E��� I   A E�������� 
0 length  ��  ��  � o   @ A���� 0 
asocstring 
asocString��  ��  ��  � o   < =���� 0 asocpattern asocPattern� o      ����  0 asocmatcharray asocMatchArray� ��� Y   N ��������� k   ^ ��� ��� r   ^ k��� l  ^ i������ n  ^ i��� I   d i������� 0 rangeatindex_ rangeAtIndex_� ���� m   d e����  ��  ��  � l  ^ d������ n  ^ d��� I   _ d�������  0 objectatindex_ objectAtIndex_� ���� o   _ `���� 0 i  ��  ��  � o   ^ _����  0 asocmatcharray asocMatchArray��  ��  ��  ��  � o      ����  0 asocmatchrange asocMatchRange� ��� r   l s��� n  l q��� I   m q�������� 0 location  ��  ��  � o   l m����  0 asocmatchrange asocMatchRange� o      ����  0 asocmatchstart asocMatchStart� ��� r   t ���� c   t ���� l  t ����� n  t ���� I   u ����� *0 substringwithrange_ substringWithRange_� ��� K   u }�� ���� 0 location  � o   v w�� &0 asocnonmatchstart asocNonMatchStart� ���� 
0 length  � \   x {��� o   x y��  0 asocmatchstart asocMatchStart� o   y z�� &0 asocnonmatchstart asocNonMatchStart�  �  �  � o   t u�� 0 
asocstring 
asocString�  �  � m   � ��
� 
ctxt� n      ���  ;   � �� o   � ��� 0 
resultlist 
resultList� ��� r   � ���� [   � ���� o   � ���  0 asocmatchstart asocMatchStart� l  � ����� n  � ���� I   � ����� 
0 length  �  �  � o   � ���  0 asocmatchrange asocMatchRange�  �  � o      �� &0 asocnonmatchstart asocNonMatchStart�  �� 0 i  � m   Q R��  � \   R Y��� l  R W���� n  R W��� I   S W���� 	0 count  �  �  � o   R S��  0 asocmatcharray asocMatchArray�  �  � m   W X�� ��  � ��� l  � �����  � "  add final non-matched range   � ��� 8   a d d   f i n a l   n o n - m a t c h e d   r a n g e� ��� r   � ���� c   � ���� l  � ����� n  � ���� I   � ����� *0 substringfromindex_ substringFromIndex_� ��� o   � ��� &0 asocnonmatchstart asocNonMatchStart�  �  � o   � ��� 0 
asocstring 
asocString�  �  � m   � ��
� 
ctxt� n      ���  ;   � �� o   � ��� 0 
resultlist 
resultList� ��� l  � ����� Z  � ������ F   � ���� =   � ���� n  � ���� 1   � ��
� 
leng� o   � ��� 0 
resultlist 
resultList� m   � ��� � =   � ���� n  � ���� 1   � ��
� 
leng� n  � ���� 4   � ���
� 
cobj� m   � ��� � o   � ��� 0 
resultlist 
resultList� m   � ���  � L   � ��� J   � ���  �  �  � U O for consistency with _splitText(), where `text items of ""` returns empty list   � ��� �   f o r   c o n s i s t e n c y   w i t h   _ s p l i t T e x t ( ) ,   w h e r e   ` t e x t   i t e m s   o f   " " `   r e t u r n s   e m p t y   l i s t� ��� L   � ��� o   � ��� 0 
resultlist 
resultList�  I Q K used by `split text` to split text using a regular expression as separator   J ��� �   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   a   r e g u l a r   e x p r e s s i o n   a s   s e p a r a t o rA ��� l     ����  �  �  � ��� l     ����  �  �  � ��� i  � �� � I      ��� 0 	_jointext 	_joinText  o      �� 0 thelist theList � o      �� 0 separatortext separatorText�  �    k     8  r     	 n    

 1    �~
�~ 
txdl 1     �}
�} 
ascr	 o      �|�| 0 oldtids oldTIDs  r     o    �{�{ 0 separatortext separatorText n      1    
�z
�z 
txdl 1    �y
�y 
ascr  Q    / r     c     o    �x�x 0 thelist theList m    �w
�w 
ctxt o      �v�v 0 
resulttext 
resultText R      �u�t
�u .ascrerr ****      � ****�t   �s�r
�s 
errn d       m      �q�q��r   k    /   r    !!"! o    �p�p 0 oldtids oldTIDs" n     #$# 1     �o
�o 
txdl$ 1    �n
�n 
ascr  %�m% n  " /&'& I   ' /�l(�k�l .0 throwinvalidparameter throwInvalidParameter( )*) o   ' (�j�j 0 thelist theList* +,+ m   ( )-- �..  , /0/ m   ) *�i
�i 
list0 1�h1 m   * +22 �33 , E x p e c t e d   l i s t   o f   t e x t .�h  �k  ' o   " '�g�g 0 _support  �m   454 r   0 5676 o   0 1�f�f 0 oldtids oldTIDs7 n     898 1   2 4�e
�e 
txdl9 1   1 2�d
�d 
ascr5 :�c: L   6 8;; o   6 7�b�b 0 
resulttext 
resultText�c  � <=< l     �a�`�_�a  �`  �_  = >?> l     �^�]�\�^  �]  �\  ? @A@ l     �[BC�[  B  -----   C �DD 
 - - - - -A EFE l     �Z�Y�X�Z  �Y  �X  F GHG i  � �IJI I     �WKL
�W .Txt:SplTnull���     ctxtK o      �V�V 0 thetext theTextL �UMN
�U 
SepaM |�T�SO�RP�T  �S  O o      �Q�Q 0 theseparator theSeparator�R  P l     Q�P�OQ m      �N
�N 
msng�P  �O  N �MR�L
�M 
UsinR |�K�JS�IT�K  �J  S o      �H�H 0 matchformat matchFormat�I  T l     U�G�FU m      �E
�E SerECmpI�G  �F  �L  J k     �VV WXW l     �DYZ�D  Y � � convenience handler for splitting text using TIDs that can also use a regular expression pattern as separator; similar to Python's str.split()   Z �[[   c o n v e n i e n c e   h a n d l e r   f o r   s p l i t t i n g   t e x t   u s i n g   T I D s   t h a t   c a n   a l s o   u s e   a   r e g u l a r   e x p r e s s i o n   p a t t e r n   a s   s e p a r a t o r ;   s i m i l a r   t o   P y t h o n ' s   s t r . s p l i t ( )X \�C\ Q     �]^_] k    �`` aba r    cdc n   efe I    �Bg�A�B "0 astextparameter asTextParameterg hih o    	�@�@ 0 thetext theTexti j�?j m   	 
kk �ll  �?  �A  f o    �>�> 0 _support  d o      �=�= 0 thetext theTextb mnm Z    op�<�;o =    qrq n   sts 1    �:
�: 
lengt o    �9�9 0 thetext theTextr m    �8�8  p L    uu J    �7�7  �<  �;  n v�6v Z   ! �wxyzw =  ! ${|{ o   ! "�5�5 0 theseparator theSeparator| m   " #�4
�4 
msngx l  ' 3}~} L   ' 3�� I   ' 2�3��2�3 0 _splitpattern _splitPattern� ��� I  ( -�1��0
�1 .Txt:TrmTnull���     ctxt� o   ( )�/�/ 0 thetext theText�0  � ��.� m   - .�� ���  \ s +�.  �2  ~ � � if `at` parameter is omitted, trim ends then then split on whitespace runs, same as Python's str.split() default behavior (any `using` options are ignored)    ���8   i f   ` a t `   p a r a m e t e r   i s   o m i t t e d ,   t r i m   e n d s   t h e n   t h e n   s p l i t   o n   w h i t e s p a c e   r u n s ,   s a m e   a s   P y t h o n ' s   s t r . s p l i t ( )   d e f a u l t   b e h a v i o r   ( a n y   ` u s i n g `   o p t i o n s   a r e   i g n o r e d )y ��� =  6 9��� o   6 7�-�- 0 matchformat matchFormat� m   7 8�,
�, SerECmpI� ��� P   < J���� L   A I�� I   A H�+��*�+ 0 
_splittext 
_splitText� ��� o   B C�)�) 0 thetext theText� ��(� o   C D�'�' 0 theseparator theSeparator�(  �*  � �&�
�& consdiac� �%�
�% conshyph� �$�
�$ conspunc� �#�
�# conswhit� �"�!
�" consnume�!  � � �
�  conscase�  � ��� =  M P��� o   M N�� 0 matchformat matchFormat� m   N O�
� SerECmpP� ��� L   S [�� I   S Z���� 0 _splitpattern _splitPattern� ��� o   T U�� 0 thetext theText� ��� o   U V�� 0 theseparator theSeparator�  �  � ��� =  ^ a��� o   ^ _�� 0 matchformat matchFormat� m   _ `�
� SerECmpC� ��� P   d r���� L   i q�� I   i p���� 0 
_splittext 
_splitText� ��� o   j k�� 0 thetext theText� ��� o   k l�� 0 theseparator theSeparator�  �  � ��
� conscase� ��
� consdiac� ��
� conshyph� ��
� conspunc� ��
� conswhit� �
�	
�
 consnume�	  �  � ��� =  u x��� o   u v�� 0 matchformat matchFormat� m   v w�
� SerECmpE� ��� P   { ����� L   � ��� I   � ����� 0 
_splittext 
_splitText� ��� o   � ��� 0 thetext theText� ��� o   � ��� 0 theseparator theSeparator�  �  � ��
� conscase� � �
�  consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  � ����
�� consnume��  � ��� =  � ���� o   � ����� 0 matchformat matchFormat� m   � ���
�� SerECmpD� ���� L   � ��� I   � �������� 0 
_splittext 
_splitText� ��� o   � ����� 0 thetext theText� ���� o   � ����� 0 theseparator theSeparator��  ��  ��  z n  � ���� I   � �������� >0 throwinvalidconstantparameter throwInvalidConstantParameter� ��� o   � ����� 0 matchformat matchFormat� ���� m   � ��� ��� 
 u s i n g��  ��  � o   � ����� 0 _support  �6  ^ R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  _ I   � �������� 
0 _error  � ��� m   � ��� ���  s p l i t   t e x t� ��� o   � ����� 0 etext eText� ��� o   � ����� 0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  ��  �C  H ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     ����
�� .Txt:JoiTnull���     ****� o      ���� 0 thelist theList� �����
�� 
Sepa� |����������  ��  � o      ���� 0 separatortext separatorText��  � m      �� ���  ��  � Q     1�� � L     I    ������ 0 	_jointext 	_joinText  n    I   	 ������ "0 aslistparameter asListParameter 	 o   	 
���� 0 thelist theList	 
��
 m   
  �  ��  ��   o    	���� 0 _support   �� n    I    ������ "0 astextparameter asTextParameter  o    ���� 0 separatortext separatorText �� m     � 
 u s i n g��  ��   o    ���� 0 _support  ��  ��  � R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText �
� 
errn o      �� 0 enumber eNumber �
� 
erob o      �� 0 efrom eFrom ��
� 
errt o      �� 
0 eto eTo�    I   ' 1��� 
0 _error    m   ( )   �!!  j o i n   t e x t "#" o   ) *�� 0 etext eText# $%$ o   * +�� 0 enumber eNumber% &'& o   + ,�� 0 efrom eFrom' (�( o   , -�� 
0 eto eTo�  �  � )*) l     ����  �  �  * +,+ l     ����  �  �  , -.- i  � �/0/ I     �1�
� .Txt:SplPnull���     ctxt1 o      �� 0 thetext theText�  0 Q     $2342 L    55 n    676 2   �
� 
cpar7 n   898 I    �:�� "0 astextparameter asTextParameter: ;<; o    	�� 0 thetext theText< =�= m   	 
>> �??  �  �  9 o    �� 0 _support  3 R      �@A
� .ascrerr ****      � ****@ o      �� 0 etext eTextA �BC
� 
errnB o      �� 0 enumber eNumberC �DE
� 
erobD o      �� 0 efrom eFromE �F�
� 
errtF o      �� 
0 eto eTo�  4 I    $�G�� 
0 _error  G HIH m    JJ �KK   s p l i t   p a r a g r a p h sI LML o    �� 0 etext eTextM NON o    �� 0 enumber eNumberO PQP o    �� 0 efrom eFromQ R�R o     �� 
0 eto eTo�  �  . STS l     ����  �  �  T UVU l     ����  �  �  V WXW i  � �YZY I     �[\
� .Txt:JoiPnull���     ****[ o      �� 0 thelist theList\ �]�
� 
LiBr] |��^�_�  �  ^ o      �� 0 linebreaktype lineBreakType�  _ l     `��` m      �
� LiBrLiOX�  �  �  Z Q     -abca L    dd I    �e�� 0 	_jointext 	_joinTexte fgf n   hih I   	 �j�~� "0 aslistparameter asListParameterj klk o   	 
�}�} 0 thelist theListl m�|m m   
 nn �oo  �|  �~  i o    	�{�{ 0 _support  g p�zp I    �yq�x�y .0 _aslinebreakparameter _asLineBreakParameterq rsr o    �w�w 0 linebreaktype lineBreakTypes t�vt m    uu �vv 
 u s i n g�v  �x  �z  �  b R      �uwx
�u .ascrerr ****      � ****w o      �t�t 0 etext eTextx �syz
�s 
errny o      �r�r 0 enumber eNumberz �q{|
�q 
erob{ o      �p�p 0 efrom eFrom| �o}�n
�o 
errt} o      �m�m 
0 eto eTo�n  c I   # -�l~�k�l 
0 _error  ~ � m   $ %�� ���  j o i n   p a r a g r a p h s� ��� o   % &�j�j 0 etext eText� ��� o   & '�i�i 0 enumber eNumber� ��� o   ' (�h�h 0 efrom eFrom� ��g� o   ( )�f�f 
0 eto eTo�g  �k  X ��� l     �e�d�c�e  �d  �c  � ��b� l     �a�`�_�a  �`  �_  �b       +�^���]�\�[��� ���������������������������������^  � )�Z�Y�X�W�V�U�T�S�R�Q�P�O�N�M�L�K�J�I�H�G�F�E�D�C�B�A�@�?�>�=�<�;�:�9�8�7�6�5�4�3�2
�Z 
pimr�Y (0 _unmatchedtexttype _UnmatchedTextType�X $0 _matchedtexttype _MatchedTextType�W &0 _matchedgrouptype _MatchedGroupType�V 0 _support  �U 
0 _error  �T B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter�S 0 _tokens  �R (0 _parsetemplatetext _parseTemplateText�Q :0 _previoussearchtemplatetext _previousSearchTemplateText�P F0 !_previoussearchtemplateparsedtext !_previousSearchTemplateParsedText�O ,0 _parsesearchtemplate _parseSearchTemplate�N :0 _previousformattemplatetext _previousFormatTemplateText�M H0 "_previousformattemplateparseditems "_previousFormatTemplateParsedItems�L ,0 _parseformattemplate _parseFormatTemplate�K $0 _matchinforecord _matchInfoRecord�J 0 _matchrecords _matchRecords�I &0 _matchedgrouplist _matchedGroupList�H 0 _findpattern _findPattern�G "0 _replacepattern _replacePattern�F 0 	_findtext 	_findText�E 0 _replacetext _replaceText
�D .Txt:Srchnull���     ctxt
�C .Txt:EPatnull���     ctxt
�B .Txt:ETemnull���     ctxt
�A .Txt:UppTnull���     ctxt
�@ .Txt:CapTnull���     ctxt
�? .Txt:LowTnull���     ctxt
�> .Txt:FTxtnull���     ctxt
�= .Txt:Normnull���     ctxt
�< .Txt:PadTnull���     ctxt
�; .Txt:SliTnull���     ctxt
�: .Txt:TrmTnull���     ctxt�9 .0 _aslinebreakparameter _asLineBreakParameter�8 0 
_splittext 
_splitText�7 0 _splitpattern _splitPattern�6 0 	_jointext 	_joinText
�5 .Txt:SplTnull���     ctxt
�4 .Txt:JoiTnull���     ****
�3 .Txt:SplPnull���     ctxt
�2 .Txt:JoiPnull���     ****� �1��1 �  ��� �0��/
�0 
cobj� ��   �. 
�. 
frmk�/  � �-��,
�- 
cobj� ��   �+
�+ 
osax�,  
�] 
TxtU
�\ 
TxtM
�[ 
TxtG� ��   �* D
�* 
scpt� �) N�(�'���&�) 
0 _error  �( �%��% �  �$�#�"�!� �$ 0 handlername handlerName�# 0 etext eText�" 0 enumber eNumber�! 0 efrom eFrom�  
0 eto eTo�'  � ������ 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo�  ^��� � &0 throwcommanderror throwCommandError�& b  ࠡ����+ � � w������ B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter� ��� �  ��� 0 patterntext patternText� 0 parametername parameterName�  � ��� 0 patterntext patternText� 0 parametername parameterName� ������

� misccura� H0 "nsregularexpressioncaseinsensitive "NSRegularExpressionCaseInsensitive� L0 $nsregularexpressionanchorsmatchlines $NSRegularExpressionAnchorsMatchLines� Z0 +nsregularexpressiondotmatcheslineseparators +NSRegularExpressionDotMatchesLineSeparators� Z0 +nsregularexpressionuseunicodewordboundaries +NSRegularExpressionUseUnicodeWordBoundaries�
 @0 asnsregularexpressionparameter asNSRegularExpressionParameter�  b  ���,E��,E��,E��,E�m+ � �	 �������	 (0 _parsetemplatetext _parseTemplateText� ��� �  �� 0 templatetext templateText�  � ���� ������������������������� 0 templatetext templateText� 0 
asocstring 
asocString� 0 asocpattern asocPattern�  &0 asocnonmatchstart asocNonMatchStart�� 0 
resultlist 
resultList��  0 asocmatcharray asocMatchArray�� 0 
concatnext 
concatNext�� 0 i  �� 0 	asocmatch 	asocMatch��  0 asocmatchrange asocMatchRange��  0 asocmatchstart asocMatchStart�� 0 nonmatchtext nonMatchText�� 0 j  ��  0 asocgrouprange asocGroupRange�� "0 asocmatchstring asocMatchString�� 0 itemtext itemText� ����������������������������.�������������������������
�� misccura�� 0 nsstring NSString�� &0 stringwithstring_ stringWithString_�� *0 nsregularexpression NSRegularExpression�� ^0 -nsregularexpressionallowcommentsandwhitespace -NSRegularExpressionAllowCommentsAndWhitespace
�� 
msng�� Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_�� 
0 length  �� @0 matchesinstring_options_range_ matchesInString_options_range_�� 	0 count  ��  0 objectatindex_ objectAtIndex_�� 0 rangeatindex_ rangeAtIndex_�� 0 location  �� *0 substringwithrange_ substringWithRange_�� H0 "stringbyapplyingtransform_reverse_ "stringByApplyingTransform_reverse_
�� 
ctxt
�� 
cobj
�� 
lnfd
�� 
ret 
�� 
tab �� 
�� 
psof
�� 
psin
�� .sysooffslong    ��� null�� *0 substringfromindex_ substringFromIndex_�d��,�k+ E�O��,b  ��,E�m+ E�OjE�OjvE�O��jj�j+ lvm+ E�OfE�O �j�j+ 	kkh ��k+ 
E�O�jk+ E�O�j+ E�O����lvk+ �fl+ a &E�O� �a i/�%�a i/FOfE�Y ��6FO��j+ E�O �kmkh ��k+ E�O�j+ j a��k+ E�O�a &E�O�k  A�a i/_ _ _ a a va � *a �a a a  U/%�a i/FOeE�Y ��6FOY h[OY��[OY�O��k+ a fl+ a &E�O� �a i/�%�a i/FY ��6FO�� ������������ ,0 _parsesearchtemplate _parseSearchTemplate�� ����� �  ���� 0 templatetext templateText��  � �������������� 0 templatetext templateText�� 0 templateitems templateItems�� 0 i  �� 0 itemtext itemText�� 0 nextitem nextItem�� 0 
asocstring 
asocString� ������M��k����t��������������������� (0 _parsetemplatetext _parseTemplateText
�� 
leng
�� 
cobj
�� 
long
�� 
cha 
�� 
bool�� 0 
asnsstring 
asNSString
�� misccura�� 60 nsregularexpressionsearch NSRegularExpressionSearch�� 
0 length  �� �� �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_
�� 
ctxt�� 0 	_jointext 	_joinText�� ��� ��b  	 �*�k+ E�O �k��,Ekh ��/E�O�l#j  9��&%E�O��k/E�O��,j	 
��k/�& 
��%E�Y hO���/FY ,b  �k+ E�O�����,j�j+ lva + a &��/F[OY��O*�a l+ Ec  
O�Ec  	Y hOb  
V� ���������� ,0 _parseformattemplate _parseFormatTemplate� ��� �  �� 0 templatetext templateText�  � �� 0 templatetext templateText� ���� (0 _parsetemplatetext _parseTemplateText� 0�� ,�b   *�k+ Ec  O�Ec  Y hOb  V� ������� $0 _matchinforecord _matchInfoRecord� ��� �  ����� 0 
asocstring 
asocString�  0 asocmatchrange asocMatchRange� 0 
textoffset 
textOffset� 0 
recordtype 
recordType�  � ������� 0 
asocstring 
asocString�  0 asocmatchrange asocMatchRange� 0 
textoffset 
textOffset� 0 
recordtype 
recordType� 0 	foundtext 	foundText�  0 nexttextoffset nextTextOffset� ��������� *0 substringwithrange_ substringWithRange_
� 
ctxt
� 
leng
� 
pcls� 0 
startindex 
startIndex� 0 endindex endIndex� 0 	foundtext 	foundText� � $��k+  �&E�O���,E�O���k���lv� �L������ 0 _matchrecords _matchRecords� ��� �  ������� 0 
asocstring 
asocString�  0 asocmatchrange asocMatchRange�  0 asocstartindex asocStartIndex� 0 
textoffset 
textOffset� (0 nonmatchrecordtype nonMatchRecordType� "0 matchrecordtype matchRecordType�  � ������������ 0 
asocstring 
asocString�  0 asocmatchrange asocMatchRange�  0 asocstartindex asocStartIndex� 0 
textoffset 
textOffset� (0 nonmatchrecordtype nonMatchRecordType� "0 matchrecordtype matchRecordType�  0 asocmatchstart asocMatchStart� 0 asocmatchend asocMatchEnd� &0 asocnonmatchrange asocNonMatchRange� 0 nonmatchinfo nonMatchInfo� 0 	matchinfo 	matchInfo� ������ 0 location  � 
0 length  � � $0 _matchinforecord _matchInfoRecord
� 
cobj� W�j+  E�O��j+ E�O�ᦢ�E�O*�����+ E[�k/E�Z[�l/E�ZO*�����+ E[�k/E�Z[�l/E�ZO�����v� �������� &0 _matchedgrouplist _matchedGroupList� ��� �  ����~� 0 
asocstring 
asocString� 0 	asocmatch 	asocMatch� 0 
textoffset 
textOffset�~ &0 includenonmatches includeNonMatches�  � �}�|�{�z�y�x�w�v�u�t�s�r�q�} 0 
asocstring 
asocString�| 0 	asocmatch 	asocMatch�{ 0 
textoffset 
textOffset�z &0 includenonmatches includeNonMatches�y "0 submatchresults subMatchResults�x 0 groupindexes groupIndexes�w (0 asocfullmatchrange asocFullMatchRange�v &0 asocnonmatchstart asocNonMatchStart�u $0 asocfullmatchend asocFullMatchEnd�t 0 i  �s 0 nonmatchinfo nonMatchInfo�r 0 	matchinfo 	matchInfo�q &0 asocnonmatchrange asocNonMatchRange� 	�p�o�n�m�l�k�j�i�h�p  0 numberofranges numberOfRanges�o 0 rangeatindex_ rangeAtIndex_�n 0 location  �m 
0 length  �l �k 0 _matchrecords _matchRecords
�j 
cobj�i �h $0 _matchinforecord _matchInfoRecord� �jvE�O�j+  kE�O�j ��jk+ E�O�j+ E�O��j+ E�O Uk�kh 	*���k+ ��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO��6F[OY��O� #�㨧�E�O*���b  �+ �k/�6FY hY hO�� �g6�f�e���d�g 0 _findpattern _findPattern�f �c��c �  �b�a�`�_�b 0 thetext theText�a 0 patterntext patternText�` &0 includenonmatches includeNonMatches�_  0 includematches includeMatches�e  � �^�]�\�[�Z�Y�X�W�V�U�T�S�R�Q�P�^ 0 thetext theText�] 0 patterntext patternText�\ &0 includenonmatches includeNonMatches�[  0 includematches includeMatches�Z 0 asocpattern asocPattern�Y 0 
asocstring 
asocString�X &0 asocnonmatchstart asocNonMatchStart�W 0 
textoffset 
textOffset�V 0 
resultlist 
resultList�U  0 asocmatcharray asocMatchArray�T 0 i  �S 0 	asocmatch 	asocMatch�R 0 nonmatchinfo nonMatchInfo�Q 0 	matchinfo 	matchInfo�P 0 	foundtext 	foundText� J�OV`�N�M�L�K�J�I�H�G�F�E�D�C�B�A�@�?�>�=�<�;�:�O (0 asbooleanparameter asBooleanParameter�N B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter�M ,0 asnormalizednsstring asNormalizedNSString�L 
0 length  �K @0 matchesinstring_options_range_ matchesInString_options_range_�J 	0 count  �I  0 objectatindex_ objectAtIndex_�H 0 rangeatindex_ rangeAtIndex_�G �F 0 _matchrecords _matchRecords
�E 
cobj�D �C 0 foundgroups foundGroups�B 0 
startindex 
startIndex�A &0 _matchedgrouplist _matchedGroupList�@ *0 substringfromindex_ substringFromIndex_
�? 
ctxt
�> 
pcls�= 0 endindex endIndex
�< 
leng�; 0 	foundtext 	foundText�: �d	b  ��l+ E�Ob  ��l+ E�O*��l+ E�Ob  �k+ E�OjE�OkE�OjvE�O��jj�j+ lvm+ E�O }j�j+ kkh 
��k+ 	E�O*��jk+ 
��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO� ��*���a ,��+ l%�6FY h[OY��O� 1��k+ a &E�Oa b  a �a �a ,a �a �6FY hO�� �9'�8�7���6�9 "0 _replacepattern _replacePattern�8 �5��5 �  �4�3�2�4 0 thetext theText�3 0 patterntext patternText�2 0 templatetext templateText�7  � �1�0�/�.�-�,�+�*�)�(�'�&�%�$�#�"�!� ���1 0 thetext theText�0 0 patterntext patternText�/ 0 templatetext templateText�. 0 
asocstring 
asocString�- 0 asocpattern asocPattern�, 0 
resultlist 
resultList�+ &0 asocnonmatchstart asocNonMatchStart�* 0 
textoffset 
textOffset�)  0 asocmatcharray asocMatchArray�( 0 i  �' 0 	asocmatch 	asocMatch�& 0 nonmatchinfo nonMatchInfo�% 0 	matchinfo 	matchInfo�$ 0 matchedgroups matchedGroups�# 0 etext eText�" 0 enumber eNumber�! 0 efrom eFrom�  
0 eto eTo� 0 oldtids oldTIDs� 0 
resulttext 
resultText�  �?�������������������
��	���������� ,0 asnormalizednsstring asNormalizedNSString� B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter
� 
kocl
� 
scpt
� .corecnte****       ****
� 
cobj� 
0 length  � @0 matchesinstring_options_range_ matchesInString_options_range_� 	0 count  �  0 objectatindex_ objectAtIndex_� 0 rangeatindex_ rangeAtIndex_� � 0 _matchrecords _matchRecords� � 0 	foundtext 	foundText� 0 
startindex 
startIndex� &0 _matchedgrouplist _matchedGroupList�  0 replacepattern replacePattern
� 
ctxt�
 0 etext eText� �� �
� 
errn�  0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  
�	 
errn
� 
erob
� 
errt� *0 substringfromindex_ substringFromIndex_
� 
ascr
� 
txdl� ,0 _parsesearchtemplate _parseSearchTemplate� |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_�6Qb  �k+  E�O*��l+ E�O�kv��l k jvjkmvE[�k/E�Z[�l/E�Z[�m/E�ZO��jj�j+ lvm+ E�O �j�j+ 	kkh 	��k+ 
E�O*��jk+ ��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO��,�6FO*���a ,e�+ E�O ���,�l+ a &�6FW X  )a �a ] a ] �a �%[OY�qO��k+ a &�6FO_ a ,E^ Oa _ a ,FO�a &E^ O] _ a ,FO] Y ��jj�j+ lv*�k+ �+ a &� ��2���������� 0 	_findtext 	_findText�� ����� �  ���������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches��  � 
���������������������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches�� 0 
resultlist 
resultList�� 0 oldtids oldTIDs�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 0 i  � ����������m������������������
�� 
ascr
�� 
txdl
�� 
citm
�� 
leng
�� 
ctxt
�� 
pcls�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 
�� .corecnte****       ****�� 0 foundgroups foundGroups�� 
��
jvE�O��,E�O���,FOkE�O��k/�,E�O� 0�� �[�\[Z�\Z�2E�Y �E�O�b  �����6FY hO �l��-j kh 	�kE�O��,�[�\[�/\�i/2�,E�O� 3�� �[�\[Z�\Z�2E�Y �E�O�b  ����jv��6FY hO�kE�O���/�,kE�O� 0�� �[�\[Z�\Z�2E�Y �E�O�b  �����6FY h[OY�aO���,FO�� ������������ 0 _replacetext _replaceText�� ����� �  �������� 0 thetext theText�� 0 fortext forText�� 0 newtext newText��  � ������������������������������ 0 thetext theText�� 0 fortext forText�� 0 newtext newText�� 0 oldtids oldTIDs�� 0 
resultlist 
resultList�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 i  �� 0 	foundtext 	foundText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 
resulttext 
resultText� ��������������������������
�� 
ascr
�� 
txdl
�� 
kocl
�� 
scpt
�� .corecnte****       ****
� 
citm
� 
leng
� 
cobj
� 
ctxt� 0 replacetext replaceText� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  
� 
errn
� 
erob
� 
errt� � "0 astextparameter asTextParameter��(��,E�O���,FO�kv��l j �jvk��k/�,mvE[�k/E�Z[�l/E�Z[�m/E�ZO�� �[�\[Z�\Z�2�6FY hO �l��-j kh �kE�O��,�[�\[�/\�i/2�,E�O�� �[�\[Z�\Z�2E�Y �E�O ��k+ 
�&�6FW X  )����a a �%O�kE�O���/�,kE�O�� �[�\[Z�\Z�2�6FY h[OY�rOa ��,FY b  �a l+ E�O��-E�O���,FO��&E�O���,FO�� ������
� .Txt:Srchnull���     ctxt� 0 thetext theText� ���
� 
For_� 0 fortext forText� ���
� 
Usin� {���� 0 matchformat matchFormat�  
� SerECmpI� ���
� 
Repl� {���� 0 newtext newText�  
� 
msng� ���
� 
Retu� {���� 0 resultformat resultFormat�  
� RetEMatT�  � ������������ 0 thetext theText� 0 fortext forText� 0 matchformat matchFormat� 0 newtext newText� 0 resultformat resultFormat� &0 includenonmatches includeNonMatches�  0 includematches includeMatches� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 2:��F��W��\��������������������������������~�}�|�{��z�	 �y		&	+	>	N�x�w	�	�	�	��v�	��u�t�� "0 astextparameter asTextParameter
�� 
leng
�� 
ctxt�� �� .0 throwinvalidparameter throwInvalidParameter
�� 
msng
�� RetEMatT
�� 
pcls�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 
�� 
cobj
�� RetEUmaT
�� RetEAllT�� >0 throwinvalidconstantparameter throwInvalidConstantParameter
� SerECmpI�~ 0 	_findtext 	_findText
�} SerECmpP�| 0 _findpattern _findPattern
�{ SerECmpC
�z SerECmpE
�y SerECmpD�x 0 _replacetext _replaceText�w "0 _replacepattern _replacePattern�v 0 etext eText� �s�r�
�s 
errn�r 0 enumber eNumber� �q�p�
�q 
erob�p 0 efrom eFrom� �o�n�m
�o 
errt�n 
0 eto eTo�m  �u �t 
0 _error  �cNb  ��l+ E�Ob  ��l+ E�O��,j  b  �����+ Y hO�� S��,j  $��  jvY �b  �k�j��a kvY hO��  felvE[a k/E�Z[a l/E�ZY S�a   eflvE[a k/E�Z[a l/E�ZY 1�a   eelvE[a k/E�Z[a l/E�ZY b  �a l+ O�a   a a  *�����+ VY ��a   *�����+ Y ~�a   a g *�����+ VY a�a   a a   *�����+ VY B�a !  -�a "  b  �a #�a $�+ Y hO*�����+ Y b  �a %l+ Y ���,j  	a &Y hO�a   a a  *���m+ 'VY ��a   *���m+ (Y {�a   a a   *���m+ 'VY ]�a   a g *���m+ 'VY A�a !  ,�a )  b  �a *�a +�+ Y hO*���m+ 'Y b  �a ,l+ W X - .*a /����a 0+ 1� �l	��k�j���i
�l .Txt:EPatnull���     ctxt�k 0 thetext theText�j  � �h�g�f�e�d�h 0 thetext theText�g 0 etext eText�f 0 enumber eNumber�e 0 efrom eFrom�d 
0 eto eTo� �c�b	��a�`�_�^�
�]�\
�c misccura�b *0 nsregularexpression NSRegularExpression�a "0 astextparameter asTextParameter�` 40 escapedpatternforstring_ escapedPatternForString_
�_ 
ctxt�^ 0 etext eText� �[�Z�
�[ 
errn�Z 0 enumber eNumber� �Y�X�
�Y 
erob�X 0 efrom eFrom� �W�V�U
�W 
errt�V 
0 eto eTo�U  �] �\ 
0 _error  �i + ��,b  ��l+ k+ �&W X  *衢���+ 
� �T
�S�R���Q
�T .Txt:ETemnull���     ctxt�S 0 thetext theText�R  � �P�O�N�M�L�P 0 thetext theText�O 0 etext eText�N 0 enumber eNumber�M 0 efrom eFrom�L 
0 eto eTo� 
%�K
(�J
+�I�H�
7�G�F�K "0 astextparameter asTextParameter�J 0 
_splittext 
_splitText�I 0 	_jointext 	_joinText�H 0 etext eText� �E�D�
�E 
errn�D 0 enumber eNumber� �C�B�
�C 
erob�B 0 efrom eFrom� �A�@�?
�A 
errt�@ 
0 eto eTo�?  �G �F 
0 _error  �Q . **b  ��l+ �l+ �l+ W X  *衢���+ 
� �>
S�=�<���;
�> .Txt:UppTnull���     ctxt�= 0 thetext theText�< �:��9
�: 
Loca� {�8�7�6�8 0 
localecode 
localeCode�7  
�6 
msng�9  � �5�4�3�2�1�0�/�5 0 thetext theText�4 0 
localecode 
localeCode�3 0 
asocstring 
asocString�2 0 etext eText�1 0 enumber eNumber�0 0 efrom eFrom�/ 
0 eto eTo� 
k�.�-�,�+�*
��)�(�'�
��&�%�. "0 astextparameter asTextParameter�- 0 
asnsstring 
asNSString
�, 
msng�+ "0 uppercasestring uppercaseString
�* 
ctxt�) *0 asnslocaleparameter asNSLocaleParameter�( 80 uppercasestringwithlocale_ uppercaseStringWithLocale_�' 0 etext eText� �$�#�
�$ 
errn�# 0 enumber eNumber� �"�!�
�" 
erob�! 0 efrom eFrom� � ��
�  
errt� 
0 eto eTo�  �& �% 
0 _error  �; Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+ � �
������
� .Txt:CapTnull���     ctxt� 0 thetext theText� ���
� 
Loca� {���� 0 
localecode 
localeCode�  
� 
msng�  � �������� 0 thetext theText� 0 
localecode 
localeCode� 0 
asocstring 
asocString� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 
�����
�	
�����
���� "0 astextparameter asTextParameter� 0 
asnsstring 
asNSString
� 
msng�
 &0 capitalizedstring capitalizedString
�	 
ctxt� *0 asnslocaleparameter asNSLocaleParameter� <0 capitalizedstringwithlocale_ capitalizedStringWithLocale_� 0 etext eText� �� 
� 
errn� 0 enumber eNumber  �� 
� 
erob�  0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  � � 
0 _error  � Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+ � ��
�������
�� .Txt:LowTnull���     ctxt�� 0 thetext theText�� ����
�� 
Loca {�������� 0 
localecode 
localeCode��  
�� 
msng��   ���������������� 0 thetext theText�� 0 
localecode 
localeCode�� 0 
asocstring 
asocString�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo ����������*������6������ "0 astextparameter asTextParameter�� 0 
asnsstring 
asNSString
�� 
msng�� "0 lowercasestring lowercaseString
�� 
ctxt�� *0 asnslocaleparameter asNSLocaleParameter�� 80 lowercasestringwithlocale_ lowercaseStringWithLocale_�� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+ � ��F����	��
�� .Txt:FTxtnull���     ctxt�� 0 templatetext templateText�� ��
��
�� 
Usin
 {�������� 0 	thevalues 	theValues��  ��  ��   ������������������ 0 templatetext templateText�� 0 	thevalues 	theValues�� 0 templateitems templateItems�� 0 i  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo	 PQ_������������������������������������� "0 astextparameter asTextParameter�� ,0 _parseformattemplate _parseFormatTemplate
�� 
kocl
�� 
scpt
�� .corecnte****       ****
�� 
leng
�� 
cobj�� 0 getitem getItem
�� 
ctxt�� "0 aslistparameter asListParameter
�� 
long� 0 etext eText ��
� 
errn� 0 enumber eNumber ��
� 
erob� 0 efrom eFrom ���
� 
errt� 
0 eto eTo�  
� 
errn
� 
erob
� 
errt� � 0 	_jointext 	_joinText� � 
0 _error  �� � ��� �*b  ��l+ k+ E�OlE�O k�kv��l k  ( "l��,Elh ���/Ek+ 
�&��/F[OY��Y 4b  ��l+ E�O #l��,Elh ���/E�&/E�&��/F[OY��W &X  )a �a �a �a a ��/%a %�%O*�a l+ VW X  *a ����a + � �����
� .Txt:Normnull���     ctxt� 0 thetext theText� �
� 
NoFo {��� 0 nopts nOpts�   ��   �
� LiBrLiOX ��
� 
Loca {��� 0 
localecode 
localeCode�  �   ������������ 0 thetext theText� 0 nopts nOpts� 0 
localecode 
localeCode� 0 	linebreak 	lineBreak� 0 
asocstring 
asocString� 0 foldingflags foldingFlags� 0 didnormalize didNormalize� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo I�$��4��������u������������������~>�}\t��|�{�z�y���x���w�v�uM�t�sh�r�q��p�o��n�m�l��k�j� "0 astextparameter asTextParameter� "0 aslistparameter asListParameter
� 
leng
� LiBrLiOX
� 
cpar
� 
lnfd� 0 	_jointext 	_joinText
� 
msng
� LiBrLiCM
� 
errn�f
� 
ret 
� LiBrLiWi� 0 
asnsstring 
asNSString
� NoFoNoCa
� NoFoNoDi� �
� NoFoNoWi� � *0 asnslocaleparameter asNSLocaleParameter� H0 "stringbyfoldingwithoptions_locale_ "stringByFoldingWithOptions_locale_
� NoFoNoSp
� misccura� 60 nsregularexpressionsearch NSRegularExpressionSearch� 
0 length  � �~ �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_
�} 
spac
�| NoFoNoSP
�{ NoFoNoTP
�z NoFoNoAO
�y 
bool�x H0 "stringbyapplyingtransform_reverse_ "stringByApplyingTransform_reverse_
�w NoFoNo_C�v N0 %precomposedstringwithcanonicalmapping %precomposedStringWithCanonicalMapping
�u NoFoNo_D�t L0 $decomposedstringwithcanonicalmapping $decomposedStringWithCanonicalMapping
�s NoFoNoKC�r V0 )precomposedstringwithcompatibilitymapping )precomposedStringWithCompatibilityMapping
�q NoFoNoKD�p T0 (decomposedstringwithcompatibilitymapping (decomposedStringWithCompatibilityMapping�o 0 etext eText �i�h�g
�i 
errn�hf�g  
�n 
list�m .0 throwinvalidparameter throwInvalidParameter
�l 
ctxt �f�e
�f 
errn�e 0 enumber eNumber �d�c
�d 
erob�c 0 efrom eFrom �b�a�`
�b 
errt�a 
0 eto eTo�`  �k �j 
0 _error  ��kb  ��l+ E�Ob  ��l+ E�O��,j  �Y hO��kv  *��-�l+ 	Y hO�jv  �Y hO���kv �E�Y �E�O��kv 0�� )��l�Y hO��,k  *��-�l+ 	Y hO�E�Y hO�a kv 6�� )��la Y hO��,k  *��-��%l+ 	Y hO��%E�Y hOb  �k+ E�OjE�O�a kv 
�kE�Y hO�a kv �a E�Y hO�a kv �a E�Y hO�j ��b  �a l+ l+ E�Y hO�a kv ��a a a a ,j�j+  lva !+ "E�O��  #�a #_ $a a ,j�j+  lva !+ "E�Y =�a %�a a ,j�j+  lva !+ "E�O�a &_ $a a ,j�j+  lva !+ "E�Y (�� !�a '�a a ,j�j+  lva !+ "E�Y hO�a (kv 5�a )kv
 �a *kva +& )��la ,Y hO�a -fl+ .E�Y i�a )kv '�a *kv )��la /Y hO�a 0fl+ .E�Y :�a *kv /�a 1fl+ .E�O�a 2a 3a a ,j�j+  lva !+ "E�Y hO�a 4kv �j+ 5E�OeE�Y fE�O�a 6kv !� )��la 7Y hO�j+ 8E�OeE�Y hO�a 9kv !� )��la :Y hO�j+ ;E�OeE�Y hO�a <kv !� )��la =Y hO�j+ >E�OeE�Y hW X ? @b  �a Aa B�a !+ CO�a D&W X ? E*a F����a G+ H� �_��^�]�\
�_ .Txt:PadTnull���     ctxt�^ 0 thetext theText�] �[�Z
�[ 
toPl�Z 0 	textwidth 	textWidth �Y
�Y 
Char {�X�W��X 0 padtext padText�W   �V�U
�V 
From {�T�S�R�T 0 whichend whichEnd�S  
�R LeTrLCha�U   �Q�P�O�N�M�L�K�J�I�H�G�Q 0 thetext theText�P 0 	textwidth 	textWidth�O 0 padtext padText�N 0 whichend whichEnd�M 0 
widthtoadd 
widthToAdd�L 0 padsize padSize�K 0 	padoffset 	padOffset�J 0 etext eText�I 0 enumber eNumber�H 0 efrom eFrom�G 
0 eto eTo ��F��E�D�C�B�A�@�?�>��=�<��;�:�F "0 astextparameter asTextParameter�E (0 asintegerparameter asIntegerParameter
�D 
leng
�C 
ctxt�B �A .0 throwinvalidparameter throwInvalidParameter
�@ LeTrLCha
�? LeTrTCha
�> LeTrBCha�= >0 throwinvalidconstantparameter throwInvalidConstantParameter�< 0 etext eText �9�8 
�9 
errn�8 0 enumber eNumber  �7�6!
�7 
erob�6 0 efrom eFrom! �5�4�3
�5 
errt�4 
0 eto eTo�3  �; �: 
0 _error  �\b  ��l+ E�Ob  ��l+ E�O���,E�O�j �Y hOb  ��l+ E�O��,E�O��,j  b  �����+ 
Y hO h��,����%E�[OY��O��  �[�\[Zk\Z�2�%Y s��  ��,�#E�O��[�\[Zk�\Z��2%Y P��  ?�k �[�\[Zk\Z�l"2�%E�Y hO��,�#E�O��[�\[Zk�\Z��kl"2%Y b  ��l+ W X  *a ����a + � �2��1�0"#�/
�2 .Txt:SliTnull���     ctxt�1 0 thetext theText�0 �.$%
�. 
FIdx$ {�-�,�+�- 0 
startindex 
startIndex�,  
�+ 
msng% �*&�)
�* 
TIdx& {�(�'�&�( 0 endindex endIndex�'  
�& 
msng�)  " �%�$�#�"�!� ���% 0 thetext theText�$ 0 
startindex 
startIndex�# 0 endindex endIndex�" 0 	thelength 	theLength�! 0 etext eText�  0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo#  ��������
��-2G���Uix}����' ��� "0 astextparameter asTextParameter
� 
leng
� 
long� � .0 throwinvalidparameter throwInvalidParameter
� 
msng� (0 asintegerparameter asIntegerParameter
� 
ctxt
� 
errn��[
� 
bool� 0 etext eText' ��(
� 
errn� 0 enumber eNumber( ��)
� 
erob� 0 efrom eFrom) ��
�	
� 
errt�
 
0 eto eTo�	  � � 
0 _error  �/��b  ��l+ E�O��,E�O�j  7�j  b  �����+ Y hO�j  b  �����+ Y hO�Y hO�� ]b  ��l+ E�O�j  b  �����+ Y hO��  -��' �Y �� 	a Y �[a \[Z�\Zi2EY hY ��  )a a la Y hO�� cb  �a l+ E�O�j  b  �a �a �+ Y hO��  -��' 	a Y �� �Y �[a \[Zk\Z�2EY hY hO�j �k�E�Y hO�j �k�E�Y hO��
 �k	 	�ka &a &
 ��	 	��a &a & 	a Y hO�k kE�Y �� �E�Y hO�k kE�Y �� �E�Y hO�[a \[Z�\Z�2EW X  *a ����a + � ���*+�
� .Txt:TrmTnull���     ctxt� 0 thetext theText� �,�
� 
From, {��� � 0 whichend whichEnd�  
�  LeTrBCha�  * ������������������ 0 thetext theText�� 0 whichend whichEnd�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo+ %��������<��@ALO����u�����-������� "0 astextparameter asTextParameter
�� LeTrLCha
�� LeTrTCha
�� LeTrBCha�� >0 throwinvalidconstantparameter throwInvalidConstantParameter
�� 
cobj
�� 
cha 
�� 
ctxt�� 0 etext eText- ����.
�� 
errn�� 0 enumber eNumber. ����/
�� 
erob�� 0 efrom eFrom/ ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  � � �b  ��l+ E�O���mv�kv b  ��l+ Y hO�� {��  �Y hOkilvE[�k/E�Z[�l/E�ZO��lv�kv  h��/� �kE�[OY��Y hO��lv�kv  h��/� �kE�[OY��Y hO�[�\[Z�\Z�2EVW X  *a ����a + � �������01���� .0 _aslinebreakparameter _asLineBreakParameter�� ��2�� 2  ������ 0 linebreaktype lineBreakType�� 0 parametername parameterName��  0 ������ 0 linebreaktype lineBreakType�� 0 parametername parameterName1 ������������
�� LiBrLiOX
�� 
lnfd
�� LiBrLiCM
�� 
ret 
�� LiBrLiWi�� >0 throwinvalidconstantparameter throwInvalidConstantParameter�� 0��  �EY %��  �Y ��  	��%Y b  ��l+ � �������34���� 0 
_splittext 
_splitText�� ��5�� 5  ������ 0 thetext theText�� 0 theseparator theSeparator��  3 �������������� 0 thetext theText�� 0 theseparator theSeparator�� 0 delimiterlist delimiterList�� 0 aref aRef�� 0 oldtids oldTIDs�� 0 
resultlist 
resultList4 ��������������6���������� 0 aslist asList
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pcnt
�� 
ctxt��  6 ���
� 
errn��\�  �� �� 60 throwinvalidparametertype throwInvalidParameterType
�� 
ascr
� 
txdl
� 
citm�� _b  �k+  E�O 5�[��l kh  ��,�&��,FW X  b  �����+ [OY��O��,E�O���,FO��-E�O���,FO�� �C��78�� 0 _splitpattern _splitPattern� �9� 9  ��� 0 thetext theText� 0 patterntext patternText�  7 
����������� 0 thetext theText� 0 patterntext patternText� 0 asocpattern asocPattern� 0 
asocstring 
asocString� &0 asocnonmatchstart asocNonMatchStart� 0 
resultlist 
resultList�  0 asocmatcharray asocMatchArray� 0 i  �  0 asocmatchrange asocMatchRange�  0 asocmatchstart asocMatchStart8 ����]�g���������������
� 
kocl
� 
list
� .corecnte****       ****
� 
Sepa
� .Txt:JoiTnull���     ****� B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter� ,0 asnormalizednsstring asNormalizedNSString� 
0 length  � @0 matchesinstring_options_range_ matchesInString_options_range_� 	0 count  �  0 objectatindex_ objectAtIndex_� 0 rangeatindex_ rangeAtIndex_� 0 location  � � *0 substringwithrange_ substringWithRange_
� 
ctxt� *0 substringfromindex_ substringFromIndex_
� 
leng
� 
cobj
� 
bool� Ρkv��l k  ���l E�Y hO*��l+ E�Ob  �k+ E�OjE�OjvE�O��jj�j+ 	lvm+ 
E�O Hj�j+ kkh ��k+ jk+ E�O�j+ E�O��驤�k+ a &�6FO��j+ 	E�[OY��O��k+ a &�6FO�a ,k 	 �a k/a ,j a & jvY hO�� � ��:;�� 0 	_jointext 	_joinText� �<� <  ��� 0 thelist theList� 0 separatortext separatorText�  : ����� 0 thelist theList� 0 separatortext separatorText� 0 oldtids oldTIDs� 0 
resulttext 
resultText; 
����=-�2��
� 
ascr
� 
txdl
� 
ctxt�  = ���
� 
errn��\�  
� 
list� � .0 throwinvalidparameter throwInvalidParameter� 9��,E�O���,FO 
��&E�W X  ���,FOb  �����+ 	O���,FO�� �J��~>?�}
� .Txt:SplTnull���     ctxt� 0 thetext theText�~ �|@A
�| 
Sepa@ {�{�z�y�{ 0 theseparator theSeparator�z  
�y 
msngA �xB�w
�x 
UsinB {�v�u�t�v 0 matchformat matchFormat�u  
�t SerECmpI�w  > �s�r�q�p�o�n�m�s 0 thetext theText�r 0 theseparator theSeparator�q 0 matchformat matchFormat�p 0 etext eText�o 0 enumber eNumber�n 0 efrom eFrom�m 
0 eto eTo? k�l�k�j�i��h�g���f�e�d��c���b��a�`C��_�^�l "0 astextparameter asTextParameter
�k 
leng
�j 
msng
�i .Txt:TrmTnull���     ctxt�h 0 _splitpattern _splitPattern
�g SerECmpI�f 0 
_splittext 
_splitText
�e SerECmpP
�d SerECmpC
�c SerECmpE
�b SerECmpD�a >0 throwinvalidconstantparameter throwInvalidConstantParameter�` 0 etext eTextC �]�\D
�] 
errn�\ 0 enumber eNumberD �[�ZE
�[ 
erob�Z 0 efrom eFromE �Y�X�W
�Y 
errt�X 
0 eto eTo�W  �_ �^ 
0 _error  �} � �b  ��l+ E�O��,j  jvY hO��  *�j �l+ Y z��  �� *��l+ 
VY c��  *��l+ Y R��  �g *��l+ 
VY ;��  �a  *��l+ 
VY "�a   *��l+ 
Y b  �a l+ W X  *a ����a + � �V��U�TFG�S
�V .Txt:JoiTnull���     ****�U 0 thelist theList�T �RH�Q
�R 
SepaH {�P�O��P 0 separatortext separatorText�O  �Q  F �N�M�L�K�J�I�N 0 thelist theList�M 0 separatortext separatorText�L 0 etext eText�K 0 enumber eNumber�J 0 efrom eFrom�I 
0 eto eToG 
�H�G�F�EI �D�C�H "0 aslistparameter asListParameter�G "0 astextparameter asTextParameter�F 0 	_jointext 	_joinText�E 0 etext eTextI �B�AJ
�B 
errn�A 0 enumber eNumberJ �@�?K
�@ 
erob�? 0 efrom eFromK �>�=�<
�> 
errt�= 
0 eto eTo�<  �D �C 
0 _error  �S 2 !*b  ��l+ b  ��l+ l+ W X  *碣���+ 	� �;0�:�9LM�8
�; .Txt:SplPnull���     ctxt�: 0 thetext theText�9  L �7�6�5�4�3�7 0 thetext theText�6 0 etext eText�5 0 enumber eNumber�4 0 efrom eFrom�3 
0 eto eToM >�2�1�0NJ�/�.�2 "0 astextparameter asTextParameter
�1 
cpar�0 0 etext eTextN �-�,O
�- 
errn�, 0 enumber eNumberO �+�*P
�+ 
erob�* 0 efrom eFromP �)�(�'
�) 
errt�( 
0 eto eTo�'  �/ �. 
0 _error  �8 % b  ��l+ �-EW X  *塢���+ � �&Z�%�$QR�#
�& .Txt:JoiPnull���     ****�% 0 thelist theList�$ �"S�!
�" 
LiBrS {� ���  0 linebreaktype lineBreakType�  
� LiBrLiOX�!  Q ������� 0 thelist theList� 0 linebreaktype lineBreakType� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToR 
n�u���T���� "0 aslistparameter asListParameter� .0 _aslinebreakparameter _asLineBreakParameter� 0 	_jointext 	_joinText� 0 etext eTextT ��U
� 
errn� 0 enumber eNumberU ��V
� 
erob� 0 efrom eFromV ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �# . *b  ��l+ *��l+ l+ W X  *碣���+ 	 ascr  ��ޭ