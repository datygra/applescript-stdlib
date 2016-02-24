FasdUAS 1.101.10   ��   ��    k             l      ��  ��   TN Text -- commonly-used text processing commands

Notes: 

- When matching text item delimiters in text value, AppleScript uses the current scope's existing considering/ignoring case, diacriticals, hyphens, punctuation, white space and numeric strings settings; thus, wrapping a `search text` command in different considering/ignoring blocks can produce different results. For example, `search text "fud" for "F" will normally match the first character since AppleScript uses case-insensitive matching by default, whereas enclosing it in a `considering case` block will cause the same command to return zero matches. Conversely, `search text "f ud" for "fu"` will normally return zero matches as AppleScript considers white space by default, but when enclosed in an `ignoring white space` block will match the first three characters: "f u". This is how AppleScript is designed to work, but users need to be reminded of this as considering/ignoring blocks affect ALL script handlers called within that block, including nested calls (and all to any osax and application handlers that understand considering/ignoring attributes).

- Unlike AS text values, NSString and NSRegularExpression don't ignore normalization differences when comparing for equality, so `search text`, `split text`, etc. must normalize input and pattern text; this means that result text may have different normalization to input.


TO DO:

- move localization commands to Date? might be more appropriate there, grouped with time zone support

- decide if predefined considering/ignoring options in `search text`, etc. should consider or ignore diacriticals and numeric strings; once decided, use same combinations for List library's text comparator for consistency? (currently Text library's `case [in]sensitivity` options consider diacriticals for equality whereas List library ignores them for ordering)


- what about `normalize text` command that wraps NSString's stringByFoldingWithOptions:locale:? (e.g. for removing diacriticals); might also want to incorporate unicode normalization into this rather than having separate precompose/decompose commands

- implement `precompose/decompose characters TEXT [with/without compatibility mapping]` commands? One could argue this is just out of scope for stdlib as AS itself does the sensible thing when dealing with composed vs decomposed glyphs, treating them as logically equal. The problem is when AS interfaces with other systems that aren't (including shell and NSString), at which point AS code should normalize text before handing it off to ensure consistent behavior.

	- AS preserves composed vs decomposed unicode chars as-is (getting `id` produces different results) but is smart enough to compare them as equal; however, it doesn't normalize when reading/writing or crossing ASOC bridge so written files will vary and NSString (which is old-school UTF16) compares them as not-equal, so any operations involving NSString's `isEqual[ToString]:` will need to normalize both strings first to ensure consistent behavior using one of the following NSString methods:
	
		decomposedStringWithCanonicalMapping (Unicode Normalization Form D)
		decomposedStringWithCompatibilityMapping (Unicode Normalization Form KD)
		precomposedStringWithCanonicalMapping (Unicode Normalization Form C)
		precomposedStringWithCompatibilityMapping (Unicode Normalization Form KC)

 	- note that Satimage.osax provides a `normalize unicode` command, although it only covers 2 of 4 forms


- what, if any, additional localization info (via NSLocale) might be relevant/useful to AS users? if there's much more, consider moving to its own Localization library; bear in mind that NSLocale instances and other Cocoa objects generally shouldn't be returned to user as ASOC objects cause problems for autosave, script persistence, etc; instead, use localeIdentifier strings and convert to/from NSLocale at point of use

     � 	 	�   T e x t   - -   c o m m o n l y - u s e d   t e x t   p r o c e s s i n g   c o m m a n d s 
 
 N o t e s :   
 
 -   W h e n   m a t c h i n g   t e x t   i t e m   d e l i m i t e r s   i n   t e x t   v a l u e ,   A p p l e S c r i p t   u s e s   t h e   c u r r e n t   s c o p e ' s   e x i s t i n g   c o n s i d e r i n g / i g n o r i n g   c a s e ,   d i a c r i t i c a l s ,   h y p h e n s ,   p u n c t u a t i o n ,   w h i t e   s p a c e   a n d   n u m e r i c   s t r i n g s   s e t t i n g s ;   t h u s ,   w r a p p i n g   a   ` s e a r c h   t e x t `   c o m m a n d   i n   d i f f e r e n t   c o n s i d e r i n g / i g n o r i n g   b l o c k s   c a n   p r o d u c e   d i f f e r e n t   r e s u l t s .   F o r   e x a m p l e ,   ` s e a r c h   t e x t   " f u d "   f o r   " F "   w i l l   n o r m a l l y   m a t c h   t h e   f i r s t   c h a r a c t e r   s i n c e   A p p l e S c r i p t   u s e s   c a s e - i n s e n s i t i v e   m a t c h i n g   b y   d e f a u l t ,   w h e r e a s   e n c l o s i n g   i t   i n   a   ` c o n s i d e r i n g   c a s e `   b l o c k   w i l l   c a u s e   t h e   s a m e   c o m m a n d   t o   r e t u r n   z e r o   m a t c h e s .   C o n v e r s e l y ,   ` s e a r c h   t e x t   " f   u d "   f o r   " f u " `   w i l l   n o r m a l l y   r e t u r n   z e r o   m a t c h e s   a s   A p p l e S c r i p t   c o n s i d e r s   w h i t e   s p a c e   b y   d e f a u l t ,   b u t   w h e n   e n c l o s e d   i n   a n   ` i g n o r i n g   w h i t e   s p a c e `   b l o c k   w i l l   m a t c h   t h e   f i r s t   t h r e e   c h a r a c t e r s :   " f   u " .   T h i s   i s   h o w   A p p l e S c r i p t   i s   d e s i g n e d   t o   w o r k ,   b u t   u s e r s   n e e d   t o   b e   r e m i n d e d   o f   t h i s   a s   c o n s i d e r i n g / i g n o r i n g   b l o c k s   a f f e c t   A L L   s c r i p t   h a n d l e r s   c a l l e d   w i t h i n   t h a t   b l o c k ,   i n c l u d i n g   n e s t e d   c a l l s   ( a n d   a l l   t o   a n y   o s a x   a n d   a p p l i c a t i o n   h a n d l e r s   t h a t   u n d e r s t a n d   c o n s i d e r i n g / i g n o r i n g   a t t r i b u t e s ) . 
 
 -   U n l i k e   A S   t e x t   v a l u e s ,   N S S t r i n g   a n d   N S R e g u l a r E x p r e s s i o n   d o n ' t   i g n o r e   n o r m a l i z a t i o n   d i f f e r e n c e s   w h e n   c o m p a r i n g   f o r   e q u a l i t y ,   s o   ` s e a r c h   t e x t ` ,   ` s p l i t   t e x t ` ,   e t c .   m u s t   n o r m a l i z e   i n p u t   a n d   p a t t e r n   t e x t ;   t h i s   m e a n s   t h a t   r e s u l t   t e x t   m a y   h a v e   d i f f e r e n t   n o r m a l i z a t i o n   t o   i n p u t . 
 
 
 T O   D O : 
 
 -   m o v e   l o c a l i z a t i o n   c o m m a n d s   t o   D a t e ?   m i g h t   b e   m o r e   a p p r o p r i a t e   t h e r e ,   g r o u p e d   w i t h   t i m e   z o n e   s u p p o r t 
 
 -   d e c i d e   i f   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   i n   ` s e a r c h   t e x t ` ,   e t c .   s h o u l d   c o n s i d e r   o r   i g n o r e   d i a c r i t i c a l s   a n d   n u m e r i c   s t r i n g s ;   o n c e   d e c i d e d ,   u s e   s a m e   c o m b i n a t i o n s   f o r   L i s t   l i b r a r y ' s   t e x t   c o m p a r a t o r   f o r   c o n s i s t e n c y ?   ( c u r r e n t l y   T e x t   l i b r a r y ' s   ` c a s e   [ i n ] s e n s i t i v i t y `   o p t i o n s   c o n s i d e r   d i a c r i t i c a l s   f o r   e q u a l i t y   w h e r e a s   L i s t   l i b r a r y   i g n o r e s   t h e m   f o r   o r d e r i n g ) 
 
 
 -   w h a t   a b o u t   ` n o r m a l i z e   t e x t `   c o m m a n d   t h a t   w r a p s   N S S t r i n g ' s   s t r i n g B y F o l d i n g W i t h O p t i o n s : l o c a l e : ?   ( e . g .   f o r   r e m o v i n g   d i a c r i t i c a l s ) ;   m i g h t   a l s o   w a n t   t o   i n c o r p o r a t e   u n i c o d e   n o r m a l i z a t i o n   i n t o   t h i s   r a t h e r   t h a n   h a v i n g   s e p a r a t e   p r e c o m p o s e / d e c o m p o s e   c o m m a n d s 
 
 -   i m p l e m e n t   ` p r e c o m p o s e / d e c o m p o s e   c h a r a c t e r s   T E X T   [ w i t h / w i t h o u t   c o m p a t i b i l i t y   m a p p i n g ] `   c o m m a n d s ?   O n e   c o u l d   a r g u e   t h i s   i s   j u s t   o u t   o f   s c o p e   f o r   s t d l i b   a s   A S   i t s e l f   d o e s   t h e   s e n s i b l e   t h i n g   w h e n   d e a l i n g   w i t h   c o m p o s e d   v s   d e c o m p o s e d   g l y p h s ,   t r e a t i n g   t h e m   a s   l o g i c a l l y   e q u a l .   T h e   p r o b l e m   i s   w h e n   A S   i n t e r f a c e s   w i t h   o t h e r   s y s t e m s   t h a t   a r e n ' t   ( i n c l u d i n g   s h e l l   a n d   N S S t r i n g ) ,   a t   w h i c h   p o i n t   A S   c o d e   s h o u l d   n o r m a l i z e   t e x t   b e f o r e   h a n d i n g   i t   o f f   t o   e n s u r e   c o n s i s t e n t   b e h a v i o r . 
 
 	 -   A S   p r e s e r v e s   c o m p o s e d   v s   d e c o m p o s e d   u n i c o d e   c h a r s   a s - i s   ( g e t t i n g   ` i d `   p r o d u c e s   d i f f e r e n t   r e s u l t s )   b u t   i s   s m a r t   e n o u g h   t o   c o m p a r e   t h e m   a s   e q u a l ;   h o w e v e r ,   i t   d o e s n ' t   n o r m a l i z e   w h e n   r e a d i n g / w r i t i n g   o r   c r o s s i n g   A S O C   b r i d g e   s o   w r i t t e n   f i l e s   w i l l   v a r y   a n d   N S S t r i n g   ( w h i c h   i s   o l d - s c h o o l   U T F 1 6 )   c o m p a r e s   t h e m   a s   n o t - e q u a l ,   s o   a n y   o p e r a t i o n s   i n v o l v i n g   N S S t r i n g ' s   ` i s E q u a l [ T o S t r i n g ] : `   w i l l   n e e d   t o   n o r m a l i z e   b o t h   s t r i n g s   f i r s t   t o   e n s u r e   c o n s i s t e n t   b e h a v i o r   u s i n g   o n e   o f   t h e   f o l l o w i n g   N S S t r i n g   m e t h o d s : 
 	 
 	 	 d e c o m p o s e d S t r i n g W i t h C a n o n i c a l M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   D ) 
 	 	 d e c o m p o s e d S t r i n g W i t h C o m p a t i b i l i t y M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   K D ) 
 	 	 p r e c o m p o s e d S t r i n g W i t h C a n o n i c a l M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   C ) 
 	 	 p r e c o m p o s e d S t r i n g W i t h C o m p a t i b i l i t y M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   K C ) 
 
   	 -   n o t e   t h a t   S a t i m a g e . o s a x   p r o v i d e s   a   ` n o r m a l i z e   u n i c o d e `   c o m m a n d ,   a l t h o u g h   i t   o n l y   c o v e r s   2   o f   4   f o r m s 
 
 
 -   w h a t ,   i f   a n y ,   a d d i t i o n a l   l o c a l i z a t i o n   i n f o   ( v i a   N S L o c a l e )   m i g h t   b e   r e l e v a n t / u s e f u l   t o   A S   u s e r s ?   i f   t h e r e ' s   m u c h   m o r e ,   c o n s i d e r   m o v i n g   t o   i t s   o w n   L o c a l i z a t i o n   l i b r a r y ;   b e a r   i n   m i n d   t h a t   N S L o c a l e   i n s t a n c e s   a n d   o t h e r   C o c o a   o b j e c t s   g e n e r a l l y   s h o u l d n ' t   b e   r e t u r n e d   t o   u s e r   a s   A S O C   o b j e c t s   c a u s e   p r o b l e m s   f o r   a u t o s a v e ,   s c r i p t   p e r s i s t e n c e ,   e t c ;   i n s t e a d ,   u s e   l o c a l e I d e n t i f i e r   s t r i n g s   a n d   c o n v e r t   t o / f r o m   N S L o c a l e   a t   p o i n t   o f   u s e 
 
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      record types     �      r e c o r d   t y p e s     !   l     ��������  ��  ��   !  " # " j    �� $�� (0 _unmatchedtexttype _UnmatchedTextType $ m    ��
�� 
TxtU #  % & % j    �� '�� $0 _matchedtexttype _MatchedTextType ' m    ��
�� 
TxtM &  ( ) ( j    �� *�� &0 _matchedgrouptype _MatchedGroupType * m    ��
�� 
TxtG )  + , + l     ��������  ��  ��   ,  - . - l     ��������  ��  ��   .  / 0 / l     �� 1 2��   1 J D--------------------------------------------------------------------    2 � 3 3 � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 0  4 5 4 l     �� 6 7��   6   support    7 � 8 8    s u p p o r t 5  9 : 9 l     ��������  ��  ��   :  ; < ; l      = > ? = j    �� @�� 0 _support   @ N     A A 4    �� B
�� 
scpt B m     C C � D D  T y p e S u p p o r t > "  used for parameter checking    ? � E E 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g <  F G F l     ��������  ��  ��   G  H I H l     ��������  ��  ��   I  J K J i    L M L I      �� N���� 
0 _error   N  O P O o      ���� 0 handlername handlerName P  Q R Q o      ���� 0 etext eText R  S T S o      ���� 0 enumber eNumber T  U V U o      ���� 0 efrom eFrom V  W�� W o      ���� 
0 eto eTo��  ��   M n     X Y X I    �� Z���� &0 throwcommanderror throwCommandError Z  [ \ [ m     ] ] � ^ ^  T e x t \  _ ` _ o    ���� 0 handlername handlerName `  a b a o    ���� 0 etext eText b  c d c o    	���� 0 enumber eNumber d  e f e o   	 
���� 0 efrom eFrom f  g�� g o   
 ���� 
0 eto eTo��  ��   Y o     ���� 0 _support   K  h i h l     ��������  ��  ��   i  j k j l     �� l m��   l J D--------------------------------------------------------------------    m � n n � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - k  o p o l     �� q r��   q   Find and Replace Suite    r � s s .   F i n d   a n d   R e p l a c e   S u i t e p  t u t l     ��������  ��  ��   u  v w v l     �� x y��   x   find pattern    y � z z    f i n d   p a t t e r n w  { | { l     ��������  ��  ��   |  } ~ } i   "  �  I      �� ����� $0 _matchinforecord _matchInfoRecord �  � � � o      ���� 0 
asocstring 
asocString �  � � � o      ����  0 asocmatchrange asocMatchRange �  � � � o      ���� 0 
textoffset 
textOffset �  ��� � o      ���� 0 
recordtype 
recordType��  ��   � k     # � �  � � � r     
 � � � c      � � � l     ����� � n     � � � I    �� ����� *0 substringwithrange_ substringWithRange_ �  ��� � o    ����  0 asocmatchrange asocMatchRange��  ��   � o     ���� 0 
asocstring 
asocString��  ��   � m    ��
�� 
ctxt � o      ���� 0 	foundtext 	foundText �  � � � l    � � � � r     � � � [     � � � o    ���� 0 
textoffset 
textOffset � l    ����� � n     � � � 1    ��
�� 
leng � o    ���� 0 	foundtext 	foundText��  ��   � o      ����  0 nexttextoffset nextTextOffset � : 4 calculate the start index of the next AS text range    � � � � h   c a l c u l a t e   t h e   s t a r t   i n d e x   o f   t h e   n e x t   A S   t e x t   r a n g e �  � � � l   �� � ���   �
 note: record keys are identifiers, not keywords, as 1. library-defined keywords are a huge pain to use outside of `tell script...` blocks and 2. importing the library's terminology into the global namespace via `use script...` is an excellent way to create keyword conflicts; only the class value is a keyword since Script Editor/OSAKit don't correctly handle records that use non-typename values (e.g. `{class:"matched text",...}`), but this shouldn't impact usability as it's really only used for informational purposes    � � � �   n o t e :   r e c o r d   k e y s   a r e   i d e n t i f i e r s ,   n o t   k e y w o r d s ,   a s   1 .   l i b r a r y - d e f i n e d   k e y w o r d s   a r e   a   h u g e   p a i n   t o   u s e   o u t s i d e   o f   ` t e l l   s c r i p t . . . `   b l o c k s   a n d   2 .   i m p o r t i n g   t h e   l i b r a r y ' s   t e r m i n o l o g y   i n t o   t h e   g l o b a l   n a m e s p a c e   v i a   ` u s e   s c r i p t . . . `   i s   a n   e x c e l l e n t   w a y   t o   c r e a t e   k e y w o r d   c o n f l i c t s ;   o n l y   t h e   c l a s s   v a l u e   i s   a   k e y w o r d   s i n c e   S c r i p t   E d i t o r / O S A K i t   d o n ' t   c o r r e c t l y   h a n d l e   r e c o r d s   t h a t   u s e   n o n - t y p e n a m e   v a l u e s   ( e . g .   ` { c l a s s : " m a t c h e d   t e x t " , . . . } ` ) ,   b u t   t h i s   s h o u l d n ' t   i m p a c t   u s a b i l i t y   a s   i t ' s   r e a l l y   o n l y   u s e d   f o r   i n f o r m a t i o n a l   p u r p o s e s �  ��� � L    # � � J    " � �  � � � K     � � �� � �
�� 
pcls � o    ���� 0 
recordtype 
recordType � �� � ��� 0 
startindex 
startIndex � o    ���� 0 
textoffset 
textOffset � �� � ��� 0 endindex endIndex � \     � � � o    ����  0 nexttextoffset nextTextOffset � m    ����  � �� ����� 0 	foundtext 	foundText � o    ���� 0 	foundtext 	foundText��   �  ��� � o     ����  0 nexttextoffset nextTextOffset��  ��   ~  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i  # & � � � I      �� ����� 0 _matchrecords _matchRecords �  � � � o      ���� 0 
asocstring 
asocString �  � � � o      ����  0 asocmatchrange asocMatchRange �  � � � o      ����  0 asocstartindex asocStartIndex �  � � � o      ���� 0 
textoffset 
textOffset �  � � � o      ���� (0 nonmatchrecordtype nonMatchRecordType �  ��� � o      ���� "0 matchrecordtype matchRecordType��  ��   � k     V � �  � � � l     �� � ���   �TN important: NSString character indexes aren't guaranteed to be same as AS character indexes (AS sensibly counts glyphs but NSString only counts UTF16 codepoints, and a glyph may be composed of more than one codepoint), so reconstruct both non-matching and matching AS text values, and calculate accurate AS character ranges from those    � � � ��   i m p o r t a n t :   N S S t r i n g   c h a r a c t e r   i n d e x e s   a r e n ' t   g u a r a n t e e d   t o   b e   s a m e   a s   A S   c h a r a c t e r   i n d e x e s   ( A S   s e n s i b l y   c o u n t s   g l y p h s   b u t   N S S t r i n g   o n l y   c o u n t s   U T F 1 6   c o d e p o i n t s ,   a n d   a   g l y p h   m a y   b e   c o m p o s e d   o f   m o r e   t h a n   o n e   c o d e p o i n t ) ,   s o   r e c o n s t r u c t   b o t h   n o n - m a t c h i n g   a n d   m a t c h i n g   A S   t e x t   v a l u e s ,   a n d   c a l c u l a t e   a c c u r a t e   A S   c h a r a c t e r   r a n g e s   f r o m   t h o s e �  � � � r      � � � n     � � � I    �������� 0 location  ��  ��   � o     ��  0 asocmatchrange asocMatchRange � o      �~�~  0 asocmatchstart asocMatchStart �  � � � r     � � � [     � � � o    	�}�}  0 asocmatchstart asocMatchStart � l  	  ��|�{ � n  	  � � � I   
 �z�y�x�z 
0 length  �y  �x   � o   	 
�w�w  0 asocmatchrange asocMatchRange�|  �{   � o      �v�v 0 asocmatchend asocMatchEnd �  � � � r     � � � K     � � �u � ��u 0 location   � o    �t�t  0 asocstartindex asocStartIndex � �s ��r�s 
0 length   � \     � � � o    �q�q  0 asocmatchstart asocMatchStart � o    �p�p  0 asocstartindex asocStartIndex�r   � o      �o�o &0 asocnonmatchrange asocNonMatchRange �  � � � r    5 � � � I      �n ��m�n $0 _matchinforecord _matchInfoRecord �  � � � o    �l�l 0 
asocstring 
asocString �  � � � o     �k�k &0 asocnonmatchrange asocNonMatchRange �  � � � o     !�j�j 0 
textoffset 
textOffset �  ��i � o   ! "�h�h (0 nonmatchrecordtype nonMatchRecordType�i  �m   � J       � �  � � � o      �g�g 0 nonmatchinfo nonMatchInfo �  ��f � o      �e�e 0 
textoffset 
textOffset�f   �  � � � r   6 N � � � I      �d ��c�d $0 _matchinforecord _matchInfoRecord �  �  � o   7 8�b�b 0 
asocstring 
asocString   o   8 9�a�a  0 asocmatchrange asocMatchRange  o   9 :�`�` 0 
textoffset 
textOffset �_ o   : ;�^�^ "0 matchrecordtype matchRecordType�_  �c   � J        o      �]�] 0 	matchinfo 	matchInfo 	�\	 o      �[�[ 0 
textoffset 
textOffset�\   � 
�Z
 L   O V J   O U  o   O P�Y�Y 0 nonmatchinfo nonMatchInfo  o   P Q�X�X 0 	matchinfo 	matchInfo  o   Q R�W�W 0 asocmatchend asocMatchEnd �V o   R S�U�U 0 
textoffset 
textOffset�V  �Z   �  l     �T�S�R�T  �S  �R    l     �Q�P�O�Q  �P  �O    i  ' * I      �N�M�N &0 _matchedgrouplist _matchedGroupList  o      �L�L 0 
asocstring 
asocString   o      �K�K 0 	asocmatch 	asocMatch  !"! o      �J�J 0 
textoffset 
textOffset" #�I# o      �H�H &0 includenonmatches includeNonMatches�I  �M   k     �$$ %&% r     '(' J     �G�G  ( o      �F�F "0 submatchresults subMatchResults& )*) r    +,+ \    -.- l   
/�E�D/ n   
010 I    
�C�B�A�C  0 numberofranges numberOfRanges�B  �A  1 o    �@�@ 0 	asocmatch 	asocMatch�E  �D  . m   
 �?�? , o      �>�> 0 groupindexes groupIndexes* 232 Z    �45�=�<4 ?    676 o    �;�; 0 groupindexes groupIndexes7 m    �:�:  5 k    �88 9:9 r    ;<; n   =>= I    �9?�8�9 0 rangeatindex_ rangeAtIndex_? @�7@ m    �6�6  �7  �8  > o    �5�5 0 	asocmatch 	asocMatch< o      �4�4 (0 asocfullmatchrange asocFullMatchRange: ABA r    %CDC n   #EFE I    #�3�2�1�3 0 location  �2  �1  F o    �0�0 (0 asocfullmatchrange asocFullMatchRangeD o      �/�/ &0 asocnonmatchstart asocNonMatchStartB GHG r   & /IJI [   & -KLK o   & '�.�. &0 asocnonmatchstart asocNonMatchStartL l  ' ,M�-�,M n  ' ,NON I   ( ,�+�*�)�+ 
0 length  �*  �)  O o   ' (�(�( (0 asocfullmatchrange asocFullMatchRange�-  �,  J o      �'�' $0 asocfullmatchend asocFullMatchEndH PQP Y   0 �R�&ST�%R k   : �UU VWV r   : oXYX I      �$Z�#�$ 0 _matchrecords _matchRecordsZ [\[ o   ; <�"�" 0 
asocstring 
asocString\ ]^] n  < B_`_ I   = B�!a� �! 0 rangeatindex_ rangeAtIndex_a b�b o   = >�� 0 i  �  �   ` o   < =�� 0 	asocmatch 	asocMatch^ cdc o   B C�� &0 asocnonmatchstart asocNonMatchStartd efe o   C D�� 0 
textoffset 
textOffsetf ghg o   D I�� (0 _unmatchedtexttype _UnmatchedTextTypeh i�i o   I N�� &0 _matchedgrouptype _MatchedGroupType�  �#  Y J      jj klk o      �� 0 nonmatchinfo nonMatchInfol mnm o      �� 0 	matchinfo 	matchInfon opo o      �� &0 asocnonmatchstart asocNonMatchStartp q�q o      �� 0 
textoffset 
textOffset�  W rsr Z  p |tu��t o   p q�� &0 includenonmatches includeNonMatchesu r   t xvwv o   t u�� 0 nonmatchinfo nonMatchInfow n      xyx  ;   v wy o   u v�� "0 submatchresults subMatchResults�  �  s z�z r   } �{|{ o   } ~�� 0 	matchinfo 	matchInfo| n      }~}  ;    �~ o   ~ �� "0 submatchresults subMatchResults�  �& 0 i  S m   3 4�
�
 T o   4 5�	�	 0 groupindexes groupIndexes�%  Q � Z   � ������ o   � ��� &0 includenonmatches includeNonMatches� k   � ��� ��� r   � ���� K   � ��� ���� 0 location  � o   � ��� &0 asocnonmatchstart asocNonMatchStart� ���� 
0 length  � \   � ���� o   � �� �  $0 asocfullmatchend asocFullMatchEnd� o   � ����� &0 asocnonmatchstart asocNonMatchStart�  � o      ���� &0 asocnonmatchrange asocNonMatchRange� ���� r   � ���� n   � ���� 4   � ����
�� 
cobj� m   � ����� � I   � �������� $0 _matchinforecord _matchInfoRecord� ��� o   � ����� 0 
asocstring 
asocString� ��� o   � ����� &0 asocnonmatchrange asocNonMatchRange� ��� o   � ����� 0 
textoffset 
textOffset� ���� o   � ����� (0 _unmatchedtexttype _UnmatchedTextType��  ��  � n      ���  ;   � �� o   � ����� "0 submatchresults subMatchResults��  �  �  �  �=  �<  3 ���� L   � ��� o   � ����� "0 submatchresults subMatchResults��   ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  + .��� I      ������� 0 _findpattern _findPattern� ��� o      ���� 0 thetext theText� ��� o      ���� 0 patterntext patternText� ��� o      ���� &0 includenonmatches includeNonMatches� ���� o      ����  0 includematches includeMatches��  ��  � k    �� ��� r     ��� n    ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    ���� &0 includenonmatches includeNonMatches� ���� m    �� ���  u n m a t c h e d   t e x t��  ��  � o     ���� 0 _support  � o      ���� &0 includenonmatches includeNonMatches� ��� r    ��� n   ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    ����  0 includematches includeMatches� ���� m    �� ���  m a t c h e d   t e x t��  ��  � o    ���� 0 _support  � o      ����  0 includematches includeMatches� ��� r    *��� n   (��� I   ! (������� @0 asnsregularexpressionparameter asNSRegularExpressionParameter� ��� o   ! "���� 0 patterntext patternText� ��� m   " #����  � ���� m   # $�� ���  f o r��  ��  � o    !���� 0 _support  � o      ���� 0 asocpattern asocPattern� ��� r   + 7��� n  + 5��� I   0 5������� ,0 asnormalizednsstring asNormalizedNSString� ���� o   0 1���� 0 thetext theText��  ��  � o   + 0���� 0 _support  � o      ���� 0 
asocstring 
asocString� ��� l  8 ;���� r   8 ;��� m   8 9����  � o      ���� &0 asocnonmatchstart asocNonMatchStart� G A used to calculate NSRanges for non-matching portions of NSString   � ��� �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n g� ��� l  < ?���� r   < ?��� m   < =���� � o      ���� 0 
textoffset 
textOffset� B < used to calculate correct AppleScript start and end indexes   � ��� x   u s e d   t o   c a l c u l a t e   c o r r e c t   A p p l e S c r i p t   s t a r t   a n d   e n d   i n d e x e s� ��� r   @ D��� J   @ B����  � o      ���� 0 
resultlist 
resultList� ��� l  E E������  � @ : iterate over each non-matched + matched range in NSString   � ��� t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n g� ��� r   E V��� n  E T��� I   F T������� @0 matchesinstring_options_range_ matchesInString_options_range_�    o   F G���� 0 
asocstring 
asocString  m   G H����   �� J   H P  m   H I����   �� n  I N	
	 I   J N�������� 
0 length  ��  ��  
 o   I J���� 0 
asocstring 
asocString��  ��  ��  � o   E F���� 0 asocpattern asocPattern� o      ����  0 asocmatcharray asocMatchArray�  Y   W ����� k   g �  r   g o l  g m���� n  g m I   h m������  0 objectatindex_ objectAtIndex_ �� o   h i���� 0 i  ��  ��   o   g h����  0 asocmatcharray asocMatchArray��  ��   o      ���� 0 	asocmatch 	asocMatch  l  p p����   � � the first range in match identifies the text matched by the entire pattern, so generate records for full match and its preceding (unmatched) text    �$   t h e   f i r s t   r a n g e   i n   m a t c h   i d e n t i f i e s   t h e   t e x t   m a t c h e d   b y   t h e   e n t i r e   p a t t e r n ,   s o   g e n e r a t e   r e c o r d s   f o r   f u l l   m a t c h   a n d   i t s   p r e c e d i n g   ( u n m a t c h e d )   t e x t   r   p �!"! I      ��#���� 0 _matchrecords _matchRecords# $%$ o   q r���� 0 
asocstring 
asocString% &'& n  r x()( I   s x��*���� 0 rangeatindex_ rangeAtIndex_* +��+ m   s t����  ��  ��  ) o   r s���� 0 	asocmatch 	asocMatch' ,-, o   x y���� &0 asocnonmatchstart asocNonMatchStart- ./. o   y z���� 0 
textoffset 
textOffset/ 010 o   z ���� (0 _unmatchedtexttype _UnmatchedTextType1 2��2 o    ����� $0 _matchedtexttype _MatchedTextType��  ��  " J      33 454 o      ���� 0 nonmatchinfo nonMatchInfo5 676 o      ���� 0 	matchinfo 	matchInfo7 898 o      ���� &0 asocnonmatchstart asocNonMatchStart9 :��: o      ���� 0 
textoffset 
textOffset��    ;<; Z  � �=>����= o   � ����� &0 includenonmatches includeNonMatches> r   � �?@? o   � ����� 0 nonmatchinfo nonMatchInfo@ n      ABA  ;   � �B o   � ����� 0 
resultlist 
resultList��  ��  < C��C Z   � �DE����D o   � �����  0 includematches includeMatchesE k   � �FF GHG l  � ���IJ��  I any additional ranges in match identify text matched by group references within regexp pattern, e.g. "([0-9]{4})-([0-9]{2})-([0-9]{2})" will match `YYYY-MM-DD` style date strings, returning the entire text match, plus sub-matches representing year, month and day text   J �KK   a n y   a d d i t i o n a l   r a n g e s   i n   m a t c h   i d e n t i f y   t e x t   m a t c h e d   b y   g r o u p   r e f e r e n c e s   w i t h i n   r e g e x p   p a t t e r n ,   e . g .   " ( [ 0 - 9 ] { 4 } ) - ( [ 0 - 9 ] { 2 } ) - ( [ 0 - 9 ] { 2 } ) "   w i l l   m a t c h   ` Y Y Y Y - M M - D D `   s t y l e   d a t e   s t r i n g s ,   r e t u r n i n g   t h e   e n t i r e   t e x t   m a t c h ,   p l u s   s u b - m a t c h e s   r e p r e s e n t i n g   y e a r ,   m o n t h   a n d   d a y   t e x tH L��L r   � �MNM b   � �OPO o   � ����� 0 	matchinfo 	matchInfoP K   � �QQ ��R���� 0 foundgroups foundGroupsR I   � ���S���� &0 _matchedgrouplist _matchedGroupListS TUT o   � ����� 0 
asocstring 
asocStringU VWV o   � ����� 0 	asocmatch 	asocMatchW XYX n  � �Z[Z o   � ����� 0 
startindex 
startIndex[ o   � ����� 0 	matchinfo 	matchInfoY \��\ o   � ����� &0 includenonmatches includeNonMatches��  ��  ��  N n      ]^]  ;   � �^ o   � ����� 0 
resultlist 
resultList��  ��  ��  ��  �� 0 i   m   Z [��   \   [ b_`_ l  [ `a�~�}a n  [ `bcb I   \ `�|�{�z�| 	0 count  �{  �z  c o   [ \�y�y  0 asocmatcharray asocMatchArray�~  �}  ` m   ` a�x�x ��   ded l  � ��wfg�w  f "  add final non-matched range   g �hh 8   a d d   f i n a l   n o n - m a t c h e d   r a n g ee iji Z   �
kl�v�uk o   � ��t�t &0 includenonmatches includeNonMatchesl k   �mm non r   � �pqp c   � �rsr l  � �t�s�rt n  � �uvu I   � ��qw�p�q *0 substringfromindex_ substringFromIndex_w x�ox o   � ��n�n &0 asocnonmatchstart asocNonMatchStart�o  �p  v o   � ��m�m 0 
asocstring 
asocString�s  �r  s m   � ��l
�l 
ctxtq o      �k�k 0 	foundtext 	foundTexto y�jy r   �z{z K   �|| �i}~
�i 
pcls} o   � ��h�h (0 _unmatchedtexttype _UnmatchedTextType~ �g��g 0 
startindex 
startIndex o   � ��f�f 0 
textoffset 
textOffset� �e���e 0 endindex endIndex� n   � ���� 1   � ��d
�d 
leng� o   � ��c�c 0 thetext theText� �b��a�b 0 	foundtext 	foundText� o   � ��`�` 0 	foundtext 	foundText�a  { n      ���  ;  � o  �_�_ 0 
resultlist 
resultList�j  �v  �u  j ��^� L  �� o  �]�] 0 
resultlist 
resultList�^  � ��� l     �\�[�Z�\  �[  �Z  � ��� l     �Y�X�W�Y  �X  �W  � ��� l     �V���V  �  -----   � ��� 
 - - - - -� ��� l     �U���U  �   replace pattern   � ���     r e p l a c e   p a t t e r n� ��� l     �T�S�R�T  �S  �R  � ��� i  / 2��� I      �Q��P�Q "0 _replacepattern _replacePattern� ��� o      �O�O 0 thetext theText� ��� o      �N�N 0 patterntext patternText� ��M� o      �L�L 0 templatetext templateText�M  �P  � k    L�� ��� r     ��� n    
��� I    
�K��J�K ,0 asnormalizednsstring asNormalizedNSString� ��I� o    �H�H 0 thetext theText�I  �J  � o     �G�G 0 _support  � o      �F�F 0 
asocstring 
asocString� ��� r    ��� n   ��� I    �E��D�E @0 asnsregularexpressionparameter asNSRegularExpressionParameter� ��� o    �C�C 0 patterntext patternText� ��� m    �B�B  � ��A� m    �� ���  f o r�A  �D  � o    �@�@ 0 _support  � o      �?�? 0 asocpattern asocPattern� ��>� Z   L���=�� >    '��� l   %��<�;� I   %�:��
�: .corecnte****       ****� J    �� ��9� o    �8�8 0 templatetext templateText�9  � �7��6
�7 
kocl� m     !�5
�5 
scpt�6  �<  �;  � m   % &�4�4  � k   *8�� ��� r   * F��� J   * 0�� ��� J   * ,�3�3  � ��� m   , -�2�2  � ��1� m   - .�0�0 �1  � J      �� ��� o      �/�/ 0 
resultlist 
resultList� ��� o      �.�. &0 asocnonmatchstart asocNonMatchStart� ��-� o      �,�, 0 
textoffset 
textOffset�-  � ��� r   G X��� n  G V��� I   H V�+��*�+ @0 matchesinstring_options_range_ matchesInString_options_range_� ��� o   H I�)�) 0 
asocstring 
asocString� ��� m   I J�(�(  � ��'� J   J R�� ��� m   J K�&�&  � ��%� n  K P��� I   L P�$�#�"�$ 
0 length  �#  �"  � o   K L�!�! 0 
asocstring 
asocString�%  �'  �*  � o   G H� �  0 asocpattern asocPattern� o      ��  0 asocmatcharray asocMatchArray� ��� Y   Y ������� k   i ��� ��� r   i q��� l  i o���� n  i o��� I   j o����  0 objectatindex_ objectAtIndex_� ��� o   j k�� 0 i  �  �  � o   i j��  0 asocmatcharray asocMatchArray�  �  � o      �� 0 	asocmatch 	asocMatch� ��� r   r ���� I      ���� 0 _matchrecords _matchRecords� ��� o   s t�� 0 
asocstring 
asocString�    n  t z I   u z��� 0 rangeatindex_ rangeAtIndex_ � m   u v��  �  �   o   t u�� 0 	asocmatch 	asocMatch  o   z {�� &0 asocnonmatchstart asocNonMatchStart 	 o   { |�� 0 
textoffset 
textOffset	 

 o   | ��
�
 (0 _unmatchedtexttype _UnmatchedTextType �	 o   � ��� $0 _matchedtexttype _MatchedTextType�	  �  � J        o      �� 0 nonmatchinfo nonMatchInfo  o      �� 0 	matchinfo 	matchInfo  o      �� &0 asocnonmatchstart asocNonMatchStart � o      �� 0 
textoffset 
textOffset�  �  r   � � n  � � o   � ��� 0 	foundtext 	foundText o   � ��� 0 nonmatchinfo nonMatchInfo n        ;   � � o   � �� �  0 
resultlist 
resultList  r   � �  I   � ���!���� &0 _matchedgrouplist _matchedGroupList! "#" o   � ����� 0 
asocstring 
asocString# $%$ o   � ����� 0 	asocmatch 	asocMatch% &'& n  � �()( o   � ����� 0 
startindex 
startIndex) o   � ����� 0 	matchinfo 	matchInfo' *��* m   � ���
�� boovtrue��  ��    o      ���� 0 matchedgroups matchedGroups +��+ Q   � �,-., r   � �/0/ c   � �121 n  � �343 I   � ���5����  0 replacepattern replacePattern5 676 n  � �898 o   � ����� 0 	foundtext 	foundText9 o   � ����� 0 	matchinfo 	matchInfo7 :��: o   � ����� 0 matchedgroups matchedGroups��  ��  4 o   � ����� 0 templatetext templateText2 m   � ���
�� 
ctxt0 n      ;<;  ;   � �< o   � ����� 0 
resultlist 
resultList- R      ��=>
�� .ascrerr ****      � ****= o      ���� 0 etext eText> ��?@
�� 
errn? o      ���� 0 enumber eNumber@ ��AB
�� 
erobA o      ���� 0 efrom eFromB ��C��
�� 
errtC o      ���� 
0 eto eTo��  . R   � ���DE
�� .ascrerr ****      � ****D b   � �FGF m   � �HH �II � A n   e r r o r   o c c u r r e d   w h e n   c a l l i n g   t h e    r e p l a c e   p a t t e r n    s c r i p t   o b j e c t :  G o   � ����� 0 etext eTextE ��JK
�� 
errnJ o   � ����� 0 enumber eNumberK ��LM
�� 
erobL o   � ����� 0 efrom eFromM ��N��
�� 
errtN o   � ����� 
0 eto eTo��  ��  � 0 i  � m   \ ]����  � \   ] dOPO l  ] bQ����Q n  ] bRSR I   ^ b�������� 	0 count  ��  ��  S o   ] ^����  0 asocmatcharray asocMatchArray��  ��  P m   b c���� �  � TUT l  � ���VW��  V "  add final non-matched range   W �XX 8   a d d   f i n a l   n o n - m a t c h e d   r a n g eU YZY r   �[\[ c   �]^] l  � �_����_ n  � �`a` I   � ���b���� *0 substringfromindex_ substringFromIndex_b c��c o   � ����� &0 asocnonmatchstart asocNonMatchStart��  ��  a o   � ����� 0 
asocstring 
asocString��  ��  ^ m   ���
�� 
ctxt\ n      ded  ;  e o  ���� 0 
resultlist 
resultListZ fgf r  hih n jkj 1  	��
�� 
txdlk 1  	��
�� 
ascri o      ���� 0 oldtids oldTIDsg lml r  non m  pp �qq  o n     rsr 1  ��
�� 
txdls 1  ��
�� 
ascrm tut r  'vwv c  #xyx o  ���� 0 
resultlist 
resultListy m  "��
�� 
ctxtw o      ���� 0 
resulttext 
resultTextu z{z r  (3|}| o  (+���� 0 oldtids oldTIDs} n     ~~ 1  .2��
�� 
txdl 1  +.��
�� 
ascr{ ���� L  48�� o  47���� 0 
resulttext 
resultText��  �=  � L  ;L�� n ;K��� I  <K������� |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_� ��� l 
<=������ o  <=���� 0 
asocstring 
asocString��  ��  � ��� m  =>����  � ��� J  >F�� ��� m  >?����  � ���� n ?D��� I  @D�������� 
0 length  ��  ��  � o  ?@���� 0 
asocstring 
asocString��  � ���� o  FG���� 0 templatetext templateText��  ��  � o  ;<���� 0 asocpattern asocPattern�>  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ������  �  
 find text   � ���    f i n d   t e x t� ��� l     ��������  ��  ��  � ��� i  3 6��� I      ������� 0 	_findtext 	_findText� ��� o      ���� 0 thetext theText� ��� o      ���� 0 fortext forText� ��� o      ���� &0 includenonmatches includeNonMatches� ���� o      ����  0 includematches includeMatches��  ��  � k    (�� ��� l    ���� Z    ������� =    ��� o     ���� 0 fortext forText� m    �� ���  � R    ����
�� .ascrerr ****      � ****� m    �� ��� � I n v a l i d    f o r    p a r a m e t e r   ( t e x t   i s   e m p t y ,   o r   o n l y   c o n t a i n s   c h a r a c t e r s   i g n o r e d   b y   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s )� ����
�� 
errn� m    	�����Y� �����
�� 
erob� o   
 ���� 0 fortext forText��  ��  ��  ��� checks if all characters in forText are ignored by current considering/ignoring settings (the alternative would be to return each character as a non-match separated by a zero-length match, but that's probably not what the user intended); note that unlike `aString's length = 0`, which is what library code normally uses to check for empty text, on this occasion we do want to take into account the current considering/ignoring settings so deliberately use `forText is ""` here. For example, when ignoring punctuation, searching for the TID `"!?"` is no different to searching for `""`, because all of its characters are being ignored when comparing the text being searched against the text being searched for. Thus, a simple `forText is ""` test can be used to check in advance if the text contains any matchable characters under the current considering/ignoring settings, and report a meaningful error if not.   � ���   c h e c k s   i f   a l l   c h a r a c t e r s   i n   f o r T e x t   a r e   i g n o r e d   b y   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   ( t h e   a l t e r n a t i v e   w o u l d   b e   t o   r e t u r n   e a c h   c h a r a c t e r   a s   a   n o n - m a t c h   s e p a r a t e d   b y   a   z e r o - l e n g t h   m a t c h ,   b u t   t h a t ' s   p r o b a b l y   n o t   w h a t   t h e   u s e r   i n t e n d e d ) ;   n o t e   t h a t   u n l i k e   ` a S t r i n g ' s   l e n g t h   =   0 ` ,   w h i c h   i s   w h a t   l i b r a r y   c o d e   n o r m a l l y   u s e s   t o   c h e c k   f o r   e m p t y   t e x t ,   o n   t h i s   o c c a s i o n   w e   d o   w a n t   t o   t a k e   i n t o   a c c o u n t   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   s o   d e l i b e r a t e l y   u s e   ` f o r T e x t   i s   " " `   h e r e .   F o r   e x a m p l e ,   w h e n   i g n o r i n g   p u n c t u a t i o n ,   s e a r c h i n g   f o r   t h e   T I D   ` " ! ? " `   i s   n o   d i f f e r e n t   t o   s e a r c h i n g   f o r   ` " " ` ,   b e c a u s e   a l l   o f   i t s   c h a r a c t e r s   a r e   b e i n g   i g n o r e d   w h e n   c o m p a r i n g   t h e   t e x t   b e i n g   s e a r c h e d   a g a i n s t   t h e   t e x t   b e i n g   s e a r c h e d   f o r .   T h u s ,   a   s i m p l e   ` f o r T e x t   i s   " " `   t e s t   c a n   b e   u s e d   t o   c h e c k   i n   a d v a n c e   i f   t h e   t e x t   c o n t a i n s   a n y   m a t c h a b l e   c h a r a c t e r s   u n d e r   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s ,   a n d   r e p o r t   a   m e a n i n g f u l   e r r o r   i f   n o t .� ��� r    ��� J    ����  � o      ���� 0 
resultlist 
resultList� ��� r    ��� n   ��� 1    ��
�� 
txdl� 1    ��
�� 
ascr� o      ���� 0 oldtids oldTIDs� ��� r    #��� o    ���� 0 fortext forText� n     ��� 1     "��
�� 
txdl� 1     ��
�� 
ascr� ��� r   $ '��� m   $ %���� � o      ���� 0 
startindex 
startIndex� ��� r   ( 0��� n   ( .��� 1   , .��
�� 
leng� n   ( ,��� 4   ) ,���
�� 
citm� m   * +���� � o   ( )���� 0 thetext theText� o      ���� 0 endindex endIndex� ��� Z   1 f������� o   1 2���� &0 includenonmatches includeNonMatches� k   5 b�� ��� Z   5 N����� B   5 8��� o   5 6�~�~ 0 
startindex 
startIndex� o   6 7�}�} 0 endindex endIndex� r   ; H��� n   ; F��� 7  < F�|��
�| 
ctxt� o   @ B�{�{ 0 
startindex 
startIndex� o   C E�z�z 0 endindex endIndex� o   ; <�y�y 0 thetext theText� o      �x�x 0 	foundtext 	foundText�  � r   K N��� m   K L�� ���  � o      �w�w 0 	foundtext 	foundText� ��v� r   O b��� K   O _�� �u��
�u 
pcls� o   P U�t�t (0 _unmatchedtexttype _UnmatchedTextType� �s���s 0 
startindex 
startIndex� o   V W�r�r 0 
startindex 
startIndex� �q� �q 0 endindex endIndex� o   X Y�p�p 0 endindex endIndex  �o�n�o 0 	foundtext 	foundText o   Z [�m�m 0 	foundtext 	foundText�n  � n        ;   ` a o   _ `�l�l 0 
resultlist 
resultList�v  ��  ��  �  Y   g�k�j k   w		 

 r   w | [   w z o   w x�i�i 0 endindex endIndex m   x y�h�h  o      �g�g 0 
startindex 
startIndex  r   } � \   } � l  } ��f�e n   } � 1   ~ ��d
�d 
leng o   } ~�c�c 0 thetext theText�f  �e   l  � ��b�a n   � � 1   � ��`
�` 
leng n   � � 7  � ��_
�_ 
ctxt l  � � �^�]  4   � ��\!
�\ 
citm! o   � ��[�[ 0 i  �^  �]   l  � �"�Z�Y" 4   � ��X#
�X 
citm# m   � ��W�W���Z  �Y   o   � ��V�V 0 thetext theText�b  �a   o      �U�U 0 endindex endIndex $%$ Z   � �&'�T�S& o   � ��R�R  0 includematches includeMatches' k   � �(( )*) Z   � �+,�Q-+ B   � �./. o   � ��P�P 0 
startindex 
startIndex/ o   � ��O�O 0 endindex endIndex, r   � �010 n   � �232 7  � ��N45
�N 
ctxt4 o   � ��M�M 0 
startindex 
startIndex5 o   � ��L�L 0 endindex endIndex3 o   � ��K�K 0 thetext theText1 o      �J�J 0 	foundtext 	foundText�Q  - r   � �676 m   � �88 �99  7 o      �I�I 0 	foundtext 	foundText* :�H: r   � �;<; K   � �== �G>?
�G 
pcls> o   � ��F�F $0 _matchedtexttype _MatchedTextType? �E@A�E 0 
startindex 
startIndex@ o   � ��D�D 0 
startindex 
startIndexA �CBC�C 0 endindex endIndexB o   � ��B�B 0 endindex endIndexC �ADE�A 0 	foundtext 	foundTextD o   � ��@�@ 0 	foundtext 	foundTextE �?F�>�? 0 foundgroups foundGroupsF J   � ��=�=  �>  < n      GHG  ;   � �H o   � ��<�< 0 
resultlist 
resultList�H  �T  �S  % IJI r   � �KLK [   � �MNM o   � ��;�; 0 endindex endIndexN m   � ��:�: L o      �9�9 0 
startindex 
startIndexJ OPO r   � �QRQ \   � �STS [   � �UVU o   � ��8�8 0 
startindex 
startIndexV l  � �W�7�6W n   � �XYX 1   � ��5
�5 
lengY n   � �Z[Z 4   � ��4\
�4 
citm\ o   � ��3�3 0 i  [ o   � ��2�2 0 thetext theText�7  �6  T m   � ��1�1 R o      �0�0 0 endindex endIndexP ]�/] Z   �^_�.�-^ o   � ��,�, &0 includenonmatches includeNonMatches_ k   �`` aba Z   �cd�+ec B   � �fgf o   � ��*�* 0 
startindex 
startIndexg o   � ��)�) 0 endindex endIndexd r   � �hih n   � �jkj 7  � ��(lm
�( 
ctxtl o   � ��'�' 0 
startindex 
startIndexm o   � ��&�& 0 endindex endIndexk o   � ��%�% 0 thetext theTexti o      �$�$ 0 	foundtext 	foundText�+  e r   �non m   � pp �qq  o o      �#�# 0 	foundtext 	foundTextb r�"r r  sts K  uu �!vw
�! 
pclsv o  	� �  (0 _unmatchedtexttype _UnmatchedTextTypew �xy� 0 
startindex 
startIndexx o  
�� 0 
startindex 
startIndexy �z{� 0 endindex endIndexz o  �� 0 endindex endIndex{ �|�� 0 	foundtext 	foundText| o  �� 0 	foundtext 	foundText�  t n      }~}  ;  ~ o  �� 0 
resultlist 
resultList�"  �.  �-  �/  �k 0 i   m   j k��  I  k r��
� .corecnte****       **** n   k n��� 2  l n�
� 
citm� o   k l�� 0 thetext theText�  �j   ��� r   %��� o   !�� 0 oldtids oldTIDs� n     ��� 1  "$�
� 
txdl� 1  !"�
� 
ascr� ��� L  &(�� o  &'�� 0 
resultlist 
resultList�  � ��� l     ����  �  �  � ��� l     �
�	��
  �	  �  � ��� l     ����  �  -----   � ��� 
 - - - - -� ��� l     ����  �   replace text   � ���    r e p l a c e   t e x t� ��� l     ����  �  �  � ��� i  7 :��� I      ���� 0 _replacetext _replaceText� ��� o      � �  0 thetext theText� ��� o      ���� 0 fortext forText� ���� o      ���� 0 newtext newText��  �  � k    <�� ��� Z    ������� =    ��� o     ���� 0 fortext forText� m    �� ���  � R    ����
�� .ascrerr ****      � ****� m    �� ��� � I n v a l i d    f o r    p a r a m e t e r   ( t e x t   i s   e m p t y ,   o r   o n l y   c o n t a i n s   c h a r a c t e r s   i g n o r e d   b y   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s )� ����
�� 
errn� m    	�����Y� �����
�� 
erob� o   
 ���� 0 fortext forText��  ��  ��  � ��� r    ��� n   ��� 1    ��
�� 
txdl� 1    ��
�� 
ascr� o      ���� 0 oldtids oldTIDs� ��� r    ��� o    ���� 0 fortext forText� n     ��� 1    ��
�� 
txdl� 1    ��
�� 
ascr� ��� Z   -������ >    *��� l   (������ I   (����
�� .corecnte****       ****� J    "�� ���� o     ���� 0 newtext newText��  � �����
�� 
kocl� m   # $��
�� 
scpt��  ��  ��  � m   ( )����  � k   -�� ��� r   - N��� J   - 8�� ��� J   - /����  � ��� m   / 0���� � ���� n   0 6��� 1   4 6��
�� 
leng� n   0 4��� 4   1 4���
�� 
citm� m   2 3���� � o   0 1���� 0 thetext theText��  � J      �� ��� o      ���� 0 
resultlist 
resultList� ��� o      ���� 0 
startindex 
startIndex� ���� o      ���� 0 endindex endIndex��  � ��� Z  O g������� B   O R��� o   O P���� 0 
startindex 
startIndex� o   P Q���� 0 endindex endIndex� r   U c��� n   U `��� 7  V `����
�� 
ctxt� o   Z \���� 0 
startindex 
startIndex� o   ] _���� 0 endindex endIndex� o   U V���� 0 thetext theText� n      ���  ;   a b� o   ` a���� 0 
resultlist 
resultList��  ��  � ��� Y   h�������� k   x�� ��� r   x }��� [   x {��� o   x y���� 0 endindex endIndex� m   y z���� � o      ���� 0 
startindex 
startIndex� ��� r   ~ �� � \   ~ � l  ~ ����� n   ~ � 1    ���
�� 
leng o   ~ ���� 0 thetext theText��  ��   l  � ����� n   � � 1   � ���
�� 
leng n   � �	
	 7  � ���
�� 
ctxt l  � ����� 4   � ���
�� 
citm o   � ����� 0 i  ��  ��   l  � ����� 4   � ���
�� 
citm m   � ���������  ��  
 o   � ����� 0 thetext theText��  ��    o      ���� 0 endindex endIndex�  Z   � ��� B   � � o   � ����� 0 
startindex 
startIndex o   � ����� 0 endindex endIndex r   � � n   � � 7  � ���
�� 
ctxt o   � ����� 0 
startindex 
startIndex o   � ����� 0 endindex endIndex o   � ����� 0 thetext theText o      ���� 0 	foundtext 	foundText��   r   � � m   � �   �!!   o      ���� 0 	foundtext 	foundText "#" Q   � �$%&$ r   � �'(' c   � �)*) n  � �+,+ I   � ���-���� 0 replacetext replaceText- .��. o   � ����� 0 	foundtext 	foundText��  ��  , o   � ����� 0 newtext newText* m   � ���
�� 
ctxt( n      /0/  ;   � �0 o   � ����� 0 
resultlist 
resultList% R      ��12
�� .ascrerr ****      � ****1 o      ���� 0 etext eText2 ��34
�� 
errn3 o      ���� 0 enumber eNumber4 ��56
�� 
erob5 o      ���� 0 efrom eFrom6 ��7��
�� 
errt7 o      ���� 
0 eto eTo��  & R   � ���89
�� .ascrerr ****      � ****8 b   � �:;: m   � �<< �== � A n   e r r o r   o c c u r r e d   w h e n   c a l l i n g   t h e    r e p l a c e   t e x t    s c r i p t   o b j e c t :  ; o   � ����� 0 etext eText9 ��>?
�� 
errn> o   � ����� 0 enumber eNumber? ��@A
�� 
erob@ o   � ����� 0 efrom eFromA ��B��
�� 
errtB o   � ����� 
0 eto eTo��  # CDC r   � �EFE [   � �GHG o   � ����� 0 endindex endIndexH m   � ����� F o      ���� 0 
startindex 
startIndexD IJI r   � �KLK \   � �MNM [   � �OPO o   � ����� 0 
startindex 
startIndexP l  � �Q����Q n   � �RSR 1   � ���
�� 
lengS n   � �TUT 4   � ���V
�� 
citmV o   � ����� 0 i  U o   � ����� 0 thetext theText��  ��  N m   � ����� L o      ���� 0 endindex endIndexJ W��W Z  �XY����X B   � �Z[Z o   � ����� 0 
startindex 
startIndex[ o   � ����� 0 endindex endIndexY r   � �\]\ n   � �^_^ 7  � ���`a
�� 
ctxt` o   � ����� 0 
startindex 
startIndexa o   � ����� 0 endindex endIndex_ o   � ����� 0 thetext theText] n      bcb  ;   � �c o   � ����� 0 
resultlist 
resultList��  ��  ��  �� 0 i  � m   k l���� � I  l s�d�~
� .corecnte****       ****d n   l oefe 2  m o�}
�} 
citmf o   l m�|�| 0 thetext theText�~  ��  � g�{g r  hih m  jj �kk  i n     lml 1  �z
�z 
txdlm 1  �y
�y 
ascr�{  ��  � l -nopn k  -qq rsr l �xtu�x  t   replace with text   u �vv $   r e p l a c e   w i t h   t e x ts wxw r  !yzy n {|{ I  �w}�v�w "0 astextparameter asTextParameter} ~~ o  �u�u 0 newtext newText ��t� m  �� ���  r e p l a c i n g   w i t h�t  �v  | o  �s�s 0 _support  z o      �r�r 0 newtext newTextx ��� l "'���� r  "'��� n "%��� 2 #%�q
�q 
citm� o  "#�p�p 0 thetext theText� o      �o�o 0 
resultlist 
resultList� J D note: TID-based matching uses current considering/ignoring settings   � ��� �   n o t e :   T I D - b a s e d   m a t c h i n g   u s e s   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s� ��n� r  (-��� o  ()�m�m 0 newtext newText� n     ��� 1  *,�l
�l 
txdl� 1  )*�k
�k 
ascr�n  o * $ replace with callback-supplied text   p ��� H   r e p l a c e   w i t h   c a l l b a c k - s u p p l i e d   t e x t� ��� r  .3��� c  .1��� o  ./�j�j 0 
resultlist 
resultList� m  /0�i
�i 
ctxt� o      �h�h 0 
resulttext 
resultText� ��� r  49��� o  45�g�g 0 oldtids oldTIDs� n     ��� 1  68�f
�f 
txdl� 1  56�e
�e 
ascr� ��d� L  :<�� o  :;�c�c 0 
resulttext 
resultText�d  � ��� l     �b�a�`�b  �a  �`  � ��� l     �_�^�]�_  �^  �]  � ��� l     �\���\  �  -----   � ��� 
 - - - - -� ��� l     �[�Z�Y�[  �Z  �Y  � ��� i  ; >��� I     �X��
�X .Txt:Srchnull���     ctxt� o      �W�W 0 thetext theText� �V��
�V 
For_� o      �U�U 0 fortext forText� �T��
�T 
Usin� |�S�R��Q��S  �R  � o      �P�P 0 matchformat matchFormat�Q  � l 
    ��O�N� l     ��M�L� m      �K
�K SerECmpI�M  �L  �O  �N  � �J��
�J 
Repl� |�I�H��G��I  �H  � o      �F�F 0 newtext newText�G  � l     ��E�D� m      �C
�C 
msng�E  �D  � �B��A
�B 
Retu� |�@�?��>��@  �?  � o      �=�= 0 resultformat resultFormat�>  � l     ��<�;� m      �:
�: RetEMatT�<  �;  �A  � Q    ����� k   ��� ��� r    ��� n   ��� I    �9��8�9 "0 astextparameter asTextParameter� ��� o    	�7�7 0 thetext theText� ��6� m   	 
�� ���  �6  �8  � o    �5�5 0 _support  � o      �4�4 0 thetext theText� ��� r    ��� n   ��� I    �3��2�3 "0 astextparameter asTextParameter� ��� o    �1�1 0 fortext forText� ��0� m    �� ���  f o r�0  �2  � o    �/�/ 0 _support  � o      �.�. 0 fortext forText� ��� Z   3���-�,� =    $��� n    "��� 1     "�+
�+ 
leng� o     �*�* 0 fortext forText� m   " #�)�)  � R   ' /�(��
�( .ascrerr ****      � ****� m   - .�� ��� t I n v a l i d    f o r    p a r a m e t e r   ( e x p e c t e d   o n e   o r   m o r e   c h a r a c t e r s ) .� �'��
�' 
errn� m   ) *�&�&�Y� �%��$
�% 
erob� o   + ,�#�# 0 fortext forText�$  �-  �,  � ��"� Z   4����!�� =  4 7��� o   4 5� �  0 newtext newText� m   5 6�
� 
msng� l  :,���� k   :,�� ��� Z   : ������ =  : =��� o   : ;�� 0 resultformat resultFormat� m   ; <�
� RetEMatT� r   @ S   J   @ D  m   @ A�
� boovfals � m   A B�
� boovtrue�   J        o      �� &0 includenonmatches includeNonMatches 	�	 o      ��  0 includematches includeMatches�  � 

 =  V Y o   V W�� 0 resultformat resultFormat m   W X�
� RetEUmaT  r   \ o J   \ `  m   \ ]�
� boovtrue � m   ] ^�
� boovfals�   J        o      �� &0 includenonmatches includeNonMatches � o      ��  0 includematches includeMatches�    =  r u o   r s�� 0 resultformat resultFormat m   s t�
� RetEAllT � r   x �  J   x |!! "#" m   x y�
� boovtrue# $�
$ m   y z�	
�	 boovtrue�
    J      %% &'& o      �� &0 includenonmatches includeNonMatches' (�( o      ��  0 includematches includeMatches�  �  � n  � �)*) I   � ��+�� >0 throwinvalidconstantparameter throwInvalidConstantParameter+ ,-, o   � ��� 0 resultformat resultFormat- .�. m   � �// �00  r e t u r n i n g�  �  * o   � ��� 0 _support  � 1� 1 Z   �,23452 =  � �676 o   � ����� 0 matchformat matchFormat7 m   � ���
�� SerECmpI3 P   � �89:8 L   � �;; I   � ���<���� 0 	_findtext 	_findText< =>= o   � ����� 0 thetext theText> ?@? o   � ����� 0 fortext forText@ ABA o   � ����� &0 includenonmatches includeNonMatchesB C��C o   � �����  0 includematches includeMatches��  ��  9 ��D
�� consdiacD ��E
�� conshyphE ��F
�� conspuncF ��G
�� conswhitG ����
�� consnume��  : ����
�� conscase��  4 HIH =  � �JKJ o   � ����� 0 matchformat matchFormatK m   � ���
�� SerECmpPI LML L   � �NN I   � ���O���� 0 _findpattern _findPatternO PQP o   � ����� 0 thetext theTextQ RSR o   � ����� 0 fortext forTextS TUT o   � ����� &0 includenonmatches includeNonMatchesU V��V o   � �����  0 includematches includeMatches��  ��  M WXW =  � �YZY o   � ����� 0 matchformat matchFormatZ m   � ���
�� SerECmpCX [\[ P   � �]^��] L   � �__ I   � ���`���� 0 	_findtext 	_findText` aba o   � ����� 0 thetext theTextb cdc o   � ����� 0 fortext forTextd efe o   � ����� &0 includenonmatches includeNonMatchesf g��g o   � �����  0 includematches includeMatches��  ��  ^ ��h
�� conscaseh ��i
�� consdiaci ��j
�� conshyphj ��k
�� conspunck ��l
�� conswhitl ����
�� consnume��  ��  \ mnm =  � �opo o   � ����� 0 matchformat matchFormatp m   � ���
�� SerECmpEn qrq P   �stus L   �vv I   ���w���� 0 	_findtext 	_findTextw xyx o   � ����� 0 thetext theTexty z{z o   � ����� 0 fortext forText{ |}| o   � ���� &0 includenonmatches includeNonMatches} ~��~ o   ����  0 includematches includeMatches��  ��  t ��
�� conscase ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  u ����
�� consnume��  r ��� = 
��� o  
���� 0 matchformat matchFormat� m  ��
�� SerECmpD� ���� L  �� I  ������� 0 	_findtext 	_findText� ��� o  ���� 0 thetext theText� ��� o  ���� 0 fortext forText� ��� o  ���� &0 includenonmatches includeNonMatches� ���� o  ����  0 includematches includeMatches��  ��  ��  5 n ,��� I  $,������� >0 throwinvalidconstantparameter throwInvalidConstantParameter� ��� o  $%���� 0 matchformat matchFormat� ���� m  %(�� ��� 
 u s i n g��  ��  � o  $���� 0 _support  �   �   find matches   � ���    f i n d   m a t c h e s�!  � l /����� Z  /������ = /4��� o  /0���� 0 matchformat matchFormat� m  03��
�� SerECmpI� P  7J���� L  @I�� I  @H������� 0 _replacetext _replaceText� ��� o  AB���� 0 thetext theText� ��� o  BC���� 0 fortext forText� ���� o  CD���� 0 newtext newText��  ��  � ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ���
�� conswhit� ����
�� consnume��  � ����
�� conscase��  � ��� = MR��� o  MN���� 0 matchformat matchFormat� m  NQ��
�� SerECmpP� ��� L  U^�� I  U]������� "0 _replacepattern _replacePattern� ��� o  VW���� 0 thetext theText� ��� o  WX���� 0 fortext forText� ���� o  XY���� 0 newtext newText��  ��  � ��� = af��� o  ab���� 0 matchformat matchFormat� m  be��
�� SerECmpE� ��� P  i|���� L  r{�� I  rz������� 0 _replacetext _replaceText� ��� o  st���� 0 thetext theText� ��� o  tu���� 0 fortext forText� ���� o  uv���� 0 newtext newText��  ��  � ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  � ����
�� consnume��  � ��� = ���� o  ����� 0 matchformat matchFormat� m  ����
�� SerECmpC� ��� P  ������� L  ���� I  ��������� 0 _replacetext _replaceText� ��� o  ������ 0 thetext theText� ��� o  ������ 0 fortext forText� ���� o  ������ 0 newtext newText��  ��  � ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ��
� conswhit� �~�}
�~ consnume�}  ��  � ��� = ����� o  ���|�| 0 matchformat matchFormat� m  ���{
�{ SerECmpD� ��z� L  ���� I  ���y��x�y 0 _replacetext _replaceText� ��� o  ���w�w 0 thetext theText� ��� o  ���v�v 0 fortext forText� ��u� o  ���t�t 0 newtext newText�u  �x  �z  � n ����� I  ���s��r�s >0 throwinvalidconstantparameter throwInvalidConstantParameter� ��� o  ���q�q 0 matchformat matchFormat� ��p� m  ���� ��� 
 u s i n g�p  �r  � o  ���o�o 0 _support  �   replace matches   � ���     r e p l a c e   m a t c h e s�"  � R      �n��
�n .ascrerr ****      � ****� o      �m�m 0 etext eText� �l��
�l 
errn� o      �k�k 0 enumber eNumber� �j� 
�j 
erob� o      �i�i 0 efrom eFrom  �h�g
�h 
errt o      �f�f 
0 eto eTo�g  � I  ���e�d�e 
0 _error    m  �� �  s e a r c h   t e x t  o  ���c�c 0 etext eText 	
	 o  ���b�b 0 enumber eNumber
  o  ���a�a 0 efrom eFrom �` o  ���_�_ 
0 eto eTo�`  �d  �  l     �^�]�\�^  �]  �\    l     �[�Z�Y�[  �Z  �Y    i  ? B I     �X�W
�X .Txt:EPatnull���     ctxt o      �V�V 0 thetext theText�W   Q     * L     c     l   �U�T n    I    �S �R�S 40 escapedpatternforstring_ escapedPatternForString_  !�Q! l   "�P�O" n   #$# I    �N%�M�N "0 astextparameter asTextParameter% &'& o    �L�L 0 thetext theText' (�K( m    )) �**  �K  �M  $ o    �J�J 0 _support  �P  �O  �Q  �R   n   +,+ o    �I�I *0 nsregularexpression NSRegularExpression, m    �H
�H misccura�U  �T   m    �G
�G 
ctxt R      �F-.
�F .ascrerr ****      � ****- o      �E�E 0 etext eText. �D/0
�D 
errn/ o      �C�C 0 enumber eNumber0 �B12
�B 
erob1 o      �A�A 0 efrom eFrom2 �@3�?
�@ 
errt3 o      �>�> 
0 eto eTo�?   I     *�=4�<�= 
0 _error  4 565 m   ! "77 �88  e s c a p e   p a t t e r n6 9:9 o   " #�;�; 0 etext eText: ;<; o   # $�:�: 0 enumber eNumber< =>= o   $ %�9�9 0 efrom eFrom> ?�8? o   % &�7�7 
0 eto eTo�8  �<   @A@ l     �6�5�4�6  �5  �4  A BCB l     �3�2�1�3  �2  �1  C DED i  C FFGF I     �0H�/
�0 .Txt:ETemnull���     ctxtH o      �.�. 0 thetext theText�/  G Q     *IJKI L    LL c    MNM l   O�-�,O n   PQP I    �+R�*�+ 60 escapedtemplateforstring_ escapedTemplateForString_R S�)S l   T�(�'T n   UVU I    �&W�%�& "0 astextparameter asTextParameterW XYX o    �$�$ 0 thetext theTextY Z�#Z m    [[ �\\  �#  �%  V o    �"�" 0 _support  �(  �'  �)  �*  Q n   ]^] o    �!�! *0 nsregularexpression NSRegularExpression^ m    � 
�  misccura�-  �,  N m    �
� 
ctxtJ R      �_`
� .ascrerr ****      � ****_ o      �� 0 etext eText` �ab
� 
errna o      �� 0 enumber eNumberb �cd
� 
erobc o      �� 0 efrom eFromd �e�
� 
errte o      �� 
0 eto eTo�  K I     *�f�� 
0 _error  f ghg m   ! "ii �jj  e s c a p e   t e m p l a t eh klk o   " #�� 0 etext eTextl mnm o   # $�� 0 enumber eNumbern opo o   $ %�� 0 efrom eFromp q�q o   % &�� 
0 eto eTo�  �  E rsr l     ����  �  �  s tut l     ��
�	�  �
  �	  u vwv l     �xy�  x J D--------------------------------------------------------------------   y �zz � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -w {|{ l     �}~�  }   Conversion Suite   ~ � "   C o n v e r s i o n   S u i t e| ��� l     ����  �  �  � ��� i  G J��� I     ���
� .Txt:UppTnull���     ctxt� o      �� 0 thetext theText� ��� 
� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � l     ������ m      ��
�� 
msng��  ��  �   � Q     P���� k    >�� ��� r    ��� n   ��� I    ������� 0 
asnsstring 
asNSString� ���� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    ���� 0 thetext theText� ���� m    �� ���  ��  ��  � o    ���� 0 _support  ��  ��  � o    ���� 0 _support  � o      ���� 0 
asocstring 
asocString� ���� Z    >������ =   ��� o    ���� 0 
localecode 
localeCode� m    ��
�� 
msng� L     (�� c     '��� l    %������ n    %��� I   ! %�������� "0 uppercasestring uppercaseString��  ��  � o     !���� 0 
asocstring 
asocString��  ��  � m   % &��
�� 
ctxt��  � L   + >�� c   + =��� l  + ;������ n  + ;��� I   , ;������� 80 uppercasestringwithlocale_ uppercaseStringWithLocale_� ���� l  , 7������ n  , 7��� I   1 7������� *0 asnslocaleparameter asNSLocaleParameter� ��� o   1 2���� 0 
localecode 
localeCode� ���� m   2 3�� ���  f o r   l o c a l e��  ��  � o   , 1���� 0 _support  ��  ��  ��  ��  � o   + ,���� 0 
asocstring 
asocString��  ��  � m   ; <��
�� 
ctxt��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I   F P������� 
0 _error  � ��� m   G H�� ���  u p p e r c a s e   t e x t� ��� o   H I���� 0 etext eText� ��� o   I J���� 0 enumber eNumber� ��� o   J K���� 0 efrom eFrom� ���� o   K L���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  K N��� I     ����
�� .Txt:CapTnull���     ctxt� o      ���� 0 thetext theText� �����
�� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � l     ������ m      ��
�� 
msng��  ��  ��  � Q     P���� k    >�� ��� r    ��� n   ��� I    ������� 0 
asnsstring 
asNSString� ���� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    ���� 0 thetext theText� ���� m    �� ���  ��  ��  � o    ���� 0 _support  ��  ��  � o    ���� 0 _support  � o      ���� 0 
asocstring 
asocString� ���� Z    >������ =   ��� o    ���� 0 
localecode 
localeCode� m    ��
�� 
msng� L     (�� c     '��� l    %������ n    %��� I   ! %�������� &0 capitalizedstring capitalizedString��  ��  � o     !���� 0 
asocstring 
asocString��  ��  � m   % &��
�� 
ctxt��  � L   + >�� c   + =� � l  + ;���� n  + ; I   , ;������ <0 capitalizedstringwithlocale_ capitalizedStringWithLocale_ �� l  , 7���� n  , 7 I   1 7��	���� *0 asnslocaleparameter asNSLocaleParameter	 

 o   1 2���� 0 
localecode 
localeCode �� m   2 3 �  f o r   l o c a l e��  ��   o   , 1���� 0 _support  ��  ��  ��  ��   o   + ,���� 0 
asocstring 
asocString��  ��    m   ; <��
�� 
ctxt��  � R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��  � I   F P������ 
0 _error    m   G H �  c a p i t a l i z e   t e x t  o   H I���� 0 etext eText  o   I J���� 0 enumber eNumber   o   J K���� 0 efrom eFrom  !��! o   K L���� 
0 eto eTo��  ��  � "#" l     �������  ��  �  # $%$ l     �~�}�|�~  �}  �|  % &'& i  O R()( I     �{*+
�{ .Txt:LowTnull���     ctxt* o      �z�z 0 thetext theText+ �y,�x
�y 
Loca, |�w�v-�u.�w  �v  - o      �t�t 0 
localecode 
localeCode�u  . l     /�s�r/ m      �q
�q 
msng�s  �r  �x  ) Q     P0120 k    >33 454 r    676 n   898 I    �p:�o�p 0 
asnsstring 
asNSString: ;�n; n   <=< I    �m>�l�m "0 astextparameter asTextParameter> ?@? o    �k�k 0 thetext theText@ A�jA m    BB �CC  �j  �l  = o    �i�i 0 _support  �n  �o  9 o    �h�h 0 _support  7 o      �g�g 0 
asocstring 
asocString5 D�fD Z    >EF�eGE =   HIH o    �d�d 0 
localecode 
localeCodeI m    �c
�c 
msngF L     (JJ c     'KLK l    %M�b�aM n    %NON I   ! %�`�_�^�` "0 lowercasestring lowercaseString�_  �^  O o     !�]�] 0 
asocstring 
asocString�b  �a  L m   % &�\
�\ 
ctxt�e  G L   + >PP c   + =QRQ l  + ;S�[�ZS n  + ;TUT I   , ;�YV�X�Y 80 lowercasestringwithlocale_ lowercaseStringWithLocale_V W�WW l  , 7X�V�UX n  , 7YZY I   1 7�T[�S�T *0 asnslocaleparameter asNSLocaleParameter[ \]\ o   1 2�R�R 0 
localecode 
localeCode] ^�Q^ m   2 3__ �``  f o r   l o c a l e�Q  �S  Z o   , 1�P�P 0 _support  �V  �U  �W  �X  U o   + ,�O�O 0 
asocstring 
asocString�[  �Z  R m   ; <�N
�N 
ctxt�f  1 R      �Mab
�M .ascrerr ****      � ****a o      �L�L 0 etext eTextb �Kcd
�K 
errnc o      �J�J 0 enumber eNumberd �Ief
�I 
erobe o      �H�H 0 efrom eFromf �Gg�F
�G 
errtg o      �E�E 
0 eto eTo�F  2 I   F P�Dh�C�D 
0 _error  h iji m   G Hkk �ll  l o w e r c a s e   t e x tj mnm o   H I�B�B 0 etext eTextn opo o   I J�A�A 0 enumber eNumberp qrq o   J K�@�@ 0 efrom eFromr s�?s o   K L�>�> 
0 eto eTo�?  �C  ' tut l     �=�<�;�=  �<  �;  u vwv l     �:�9�8�:  �9  �8  w xyx i  S Vz{z I     �7|}
�7 .Txt:FTxtnull���     ctxt| o      �6�6 0 templatetext templateText} �5~�4
�5 
Usin~ o      �3�3 0 	thevalues 	theValues�4  { k    Q ��� l     �2���2  � � � note: templateText uses same `$n` (where n=1-9) notation as `search text`'s replacement templates, with `\$` to escape as necessary ($ not followed by a digit will appear as-is)   � ���d   n o t e :   t e m p l a t e T e x t   u s e s   s a m e   ` $ n `   ( w h e r e   n = 1 - 9 )   n o t a t i o n   a s   ` s e a r c h   t e x t ` ' s   r e p l a c e m e n t   t e m p l a t e s ,   w i t h   ` \ $ `   t o   e s c a p e   a s   n e c e s s a r y   ( $   n o t   f o l l o w e d   b y   a   d i g i t   w i l l   a p p e a r   a s - i s )� ��1� Q    Q���� P   7���� k   6�� ��� r    ��� n   ��� I    �0��/�0 "0 aslistparameter asListParameter� ��.� o    �-�- 0 	thevalues 	theValues�.  �/  � o    �,�, 0 _support  � o      �+�+ 0 	thevalues 	theValues� ��� r    !��� n   ��� I    �*��)�* Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_� ��� m    �� ���  \ \ . | \ $ [ 1 - 9 ]� ��� m    �(�(  � ��'� l   ��&�%� m    �$
�$ 
msng�&  �%  �'  �)  � n   ��� o    �#�# *0 nsregularexpression NSRegularExpression� m    �"
�" misccura� o      �!�! 0 asocpattern asocPattern� ��� r   " .��� n  " ,��� I   ' ,� ���  0 
asnsstring 
asNSString� ��� o   ' (�� 0 templatetext templateText�  �  � o   " '�� 0 _support  � o      �� 0 
asocstring 
asocString� ��� r   / @��� l  / >���� n  / >��� I   0 >���� @0 matchesinstring_options_range_ matchesInString_options_range_� ��� o   0 1�� 0 
asocstring 
asocString� ��� m   1 2��  � ��� J   2 :�� ��� m   2 3��  � ��� n  3 8��� I   4 8���� 
0 length  �  �  � o   3 4�� 0 
asocstring 
asocString�  �  �  � o   / 0�� 0 asocpattern asocPattern�  �  � o      ��  0 asocmatcharray asocMatchArray� ��� r   A E��� J   A C��  � o      �
�
 0 resulttexts resultTexts� ��� r   F I��� m   F G�	�	  � o      �� 0 
startindex 
startIndex� ��� Y   J ������� k   Z ��� ��� r   Z g��� l  Z e���� n  Z e��� I   ` e���� 0 rangeatindex_ rangeAtIndex_� ��� m   ` a� �   �  �  � l  Z `������ n  Z `��� I   [ `�������  0 objectatindex_ objectAtIndex_� ���� o   [ \���� 0 i  ��  ��  � o   Z [����  0 asocmatcharray asocMatchArray��  ��  �  �  � o      ���� 0 
matchrange 
matchRange� ��� r   h ���� c   h }��� l  h y������ n  h y��� I   i y������� *0 substringwithrange_ substringWithRange_� ���� K   i u�� ������ 0 location  � o   j k���� 0 
startindex 
startIndex� ������� 
0 length  � l  l s������ \   l s��� l  l q������ n  l q��� I   m q�������� 0 location  ��  ��  � o   l m���� 0 
matchrange 
matchRange��  ��  � o   q r���� 0 
startindex 
startIndex��  ��  ��  ��  ��  � o   h i���� 0 
asocstring 
asocString��  ��  � m   y |��
�� 
ctxt� n      ���  ;   ~ � o   } ~���� 0 resulttexts resultTexts� ��� r   � ���� c   � ���� l  � ������� n  � ���� I   � �������� *0 substringwithrange_ substringWithRange_� ���� o   � ����� 0 
matchrange 
matchRange��  ��  � o   � ����� 0 
asocstring 
asocString��  ��  � m   � ���
�� 
ctxt� o      ���� 0 thetoken theToken� �	 � Z   � �		��		 =  � �			 o   � ����� 0 thetoken theToken	 m   � �		 �		  \ \	 l  � �				
	 r   � �			 o   � ����� 0 thetoken theToken	 n      			  ;   � �	 o   � ����� 0 resulttexts resultTexts		 ( " found backslash-escaped character   	
 �		 D   f o u n d   b a c k s l a s h - e s c a p e d   c h a r a c t e r��  	 l  � �				 k   � �		 			 r   � �			 c   � �			 n  � �			 4  � ���	
�� 
cha 	 m   � �������	 o   � ����� 0 thetoken theToken	 m   � ���
�� 
long	 o      ���� 0 	itemindex 	itemIndex	 			 l  � �		 	!	 r   � �	"	#	" n   � �	$	%	$ 4   � ���	&
�� 
cobj	& o   � ����� 0 	itemindex 	itemIndex	% o   � ����� 0 	thevalues 	theValues	# o      ���� 0 theitem theItem	  2 , this will raise error -1728 if out of range   	! �	'	' X   t h i s   w i l l   r a i s e   e r r o r   - 1 7 2 8   i f   o u t   o f   r a n g e	 	(��	( Q   � �	)	*	+	) r   � �	,	-	, c   � �	.	/	. o   � ����� 0 theitem theItem	/ m   � ���
�� 
ctxt	- n      	0	1	0  ;   � �	1 o   � ����� 0 resulttexts resultTexts	* R      ����	2
�� .ascrerr ****      � ****��  	2 ��	3��
�� 
errn	3 d      	4	4 m      �������  	+ R   � ���	5	6
�� .ascrerr ****      � ****	5 b   � �	7	8	7 b   � �	9	:	9 m   � �	;	; �	<	< & C a n  t   c o n v e r t   i t e m  	: o   � ����� 0 	itemindex 	itemIndex	8 m   � �	=	= �	>	>    t o   t e x t .	6 ��	?	@
�� 
errn	? m   � ������\	@ ��	A	B
�� 
erob	A l  � �	C����	C N   � �	D	D n   � �	E	F	E 4   � ���	G
�� 
cobj	G o   � ����� 0 	itemindex 	itemIndex	F o   � ����� 0 	thevalues 	theValues��  ��  	B ��	H��
�� 
errt	H m   � ���
�� 
ctxt��  ��  	  	 found $n   	 �	I	I    f o u n d   $ n	  	J��	J r   � �	K	L	K [   � �	M	N	M l  � �	O����	O n  � �	P	Q	P I   � ��������� 0 location  ��  ��  	Q o   � ����� 0 
matchrange 
matchRange��  ��  	N l  � �	R����	R n  � �	S	T	S I   � ��������� 
0 length  ��  ��  	T o   � ����� 0 
matchrange 
matchRange��  ��  	L o      ���� 0 
startindex 
startIndex��  � 0 i  � m   M N����  � l  N U	U����	U \   N U	V	W	V l  N S	X����	X n  N S	Y	Z	Y I   O S�������� 	0 count  ��  ��  	Z o   N O����  0 asocmatcharray asocMatchArray��  ��  	W m   S T���� ��  ��  �  � 	[	\	[ r   �	]	^	] c   �	_	`	_ l  �	a����	a n  �	b	c	b I   ���	d���� *0 substringfromindex_ substringFromIndex_	d 	e��	e o   � ���� 0 
startindex 
startIndex��  ��  	c o   � ����� 0 
asocstring 
asocString��  ��  	` m  ��
�� 
ctxt	^ n      	f	g	f  ;  	
	g o  	���� 0 resulttexts resultTexts	\ 	h	i	h r  	j	k	j n 	l	m	l 1  ��
�� 
txdl	m 1  ��
�� 
ascr	k o      ���� 0 oldtids oldTIDs	i 	n	o	n r  !	p	q	p m  	r	r �	s	s  	q n     	t	u	t 1   ��
�� 
txdl	u 1  ��
�� 
ascr	o 	v	w	v r  ")	x	y	x c  "'	z	{	z o  "#���� 0 resulttexts resultTexts	{ m  #&��
�� 
ctxt	y o      ���� 0 
resulttext 
resultText	w 	|	}	| r  *3	~		~ o  *+���� 0 oldtids oldTIDs	 n     	�	�	� 1  .2��
�� 
txdl	� 1  +.��
�� 
ascr	} 	���	� L  46	�	� o  45���� 0 
resulttext 
resultText��  � ��	�
�� conscase	� ��	�
�� consdiac	� ��	�
�� conshyph	� ��	�
�� conspunc	� ����
�� conswhit��  � ����
�� consnume��  � R      ��	�	�
�� .ascrerr ****      � ****	� o      �� 0 etext eText	� �~	�	�
�~ 
errn	� o      �}�} 0 enumber eNumber	� �|	�	�
�| 
erob	� o      �{�{ 0 efrom eFrom	� �z	��y
�z 
errt	� o      �x�x 
0 eto eTo�y  � I  ?Q�w	��v�w 
0 _error  	� 	�	�	� m  @C	�	� �	�	�  f o r m a t   t e x t	� 	�	�	� o  CD�u�u 0 etext eText	� 	�	�	� o  DE�t�t 0 enumber eNumber	� 	�	�	� o  EH�s�s 0 efrom eFrom	� 	��r	� o  HK�q�q 
0 eto eTo�r  �v  �1  y 	�	�	� l     �p�o�n�p  �o  �n  	� 	�	�	� l     �m�l�k�m  �l  �k  	� 	�	�	� i  W Z	�	�	� I     �j	�	�
�j .Txt:NLiBnull���     ctxt	� o      �i�i 0 thetext theText	� �h	��g
�h 
LiBr	� |�f�e	��d	��f  �e  	� o      �c�c 0 linebreaktype lineBreakType�d  	� l     	��b�a	� m      �`
�` LiBrLiOX�b  �a  �g  	� Q     .	�	�	�	� L    	�	� I    �_	��^�_ 0 	_jointext 	_joinText	� 	�	�	� n   	�	�	� 2   �]
�] 
cpar	� n   	�	�	� I   	 �\	��[�\ "0 astextparameter asTextParameter	� 	�	�	� o   	 
�Z�Z 0 thetext theText	� 	��Y	� m   
 	�	� �	�	�  �Y  �[  	� o    	�X�X 0 _support  	� 	��W	� I    �V	��U�V 0 
_linebreak  	� 	��T	� o    �S�S 0 linebreaktype lineBreakType�T  �U  �W  �^  	� R      �R	�	�
�R .ascrerr ****      � ****	� o      �Q�Q 0 etext eText	� �P	�	�
�P 
errn	� o      �O�O 0 enumber eNumber	� �N	�	�
�N 
erob	� o      �M�M 0 efrom eFrom	� �L	��K
�L 
errt	� o      �J�J 
0 eto eTo�K  	� I   $ .�I	��H�I 
0 _error  	� 	�	�	� m   % &	�	� �	�	� * n o r m a l i z e   l i n e   b r e a k s	� 	�	�	� o   & '�G�G 0 etext eText	� 	�	�	� o   ' (�F�F 0 enumber eNumber	� 	�	�	� o   ( )�E�E 0 efrom eFrom	� 	��D	� o   ) *�C�C 
0 eto eTo�D  �H  	� 	�	�	� l     �B�A�@�B  �A  �@  	� 	�	�	� l     �?�>�=�?  �>  �=  	� 	�	�	� i  [ ^	�	�	� I     �<	�	�
�< .Txt:PadTnull���     ctxt	� o      �;�; 0 thetext theText	� �:	�	�
�: 
toPl	� o      �9�9 0 	textwidth 	textWidth	� �8	�	�
�8 
Char	� |�7�6	��5	��7  �6  	� o      �4�4 0 padtext padText�5  	� l     	��3�2	� m      	�	� �	�	�                                  �3  �2  	� �1	��0
�1 
From	� |�/�.	��-	��/  �.  	� o      �,�, 0 whichend whichEnd�-  	� l     	��+�*	� m      �)
�) LeTrLCha�+  �*  �0  	� Q    	�	�	�	� k    �	�	� 	�	�	� r    	�	�	� n   	�	�	� I    �(	��'�( "0 astextparameter asTextParameter	� 	�	�	� o    	�&�& 0 thetext theText	� 	��%	� m   	 
	�	� �	�	�  �%  �'  	� o    �$�$ 0 _support  	� o      �#�# 0 thetext theText	� 	�	�	� r    	�	�	� n   	�	�	� I    �"	��!�" (0 asintegerparameter asIntegerParameter	� 	�	�	� o    � �  0 	textwidth 	textWidth	� 
 �
  m    

 �

  t o   p l a c e s�  �!  	� o    �� 0 _support  	� o      �� 0 	textwidth 	textWidth	� 


 r    &


 \    $


 o     �� 0 	textwidth 	textWidth
 l    #
	��
	 n    #




 1   ! #�
� 
leng
 o     !�� 0 thetext theText�  �  
 o      �� 0 
widthtoadd 
widthToAdd
 


 Z  ' 3

��
 B   ' *


 o   ' (�� 0 
widthtoadd 
widthToAdd
 m   ( )��  
 L   - /

 o   - .�� 0 thetext theText�  �  
 


 r   4 A


 n  4 ?


 I   9 ?�
�� "0 astextparameter asTextParameter
 


 o   9 :�� 0 padtext padText
 
�
 m   : ;

 �

 
 u s i n g�  �  
 o   4 9�� 0 _support  
 o      �� 0 padtext padText
 

 
 r   B G
!
"
! n  B E
#
$
# 1   C E�
� 
leng
$ o   B C�
�
 0 padtext padText
" o      �	�	 0 padsize padSize
  
%
&
% Z  H \
'
(��
' =   H M
)
*
) n  H K
+
,
+ 1   I K�
� 
leng
, o   H I�� 0 padtext padText
* m   K L��  
( R   P X�
-
.
� .ascrerr ****      � ****
- m   V W
/
/ �
0
0 f I n v a l i d    u s i n g    p a r a m e t e r   ( e m p t y   t e x t   n o t   a l l o w e d ) .
. �
1
2
� 
errn
1 m   R S���Y
2 � 
3��
�  
erob
3 o   T U���� 0 padtext padText��  �  �  
& 
4
5
4 V   ] s
6
7
6 r   i n
8
9
8 b   i l
:
;
: o   i j���� 0 padtext padText
; o   j k���� 0 padtext padText
9 o      ���� 0 padtext padText
7 A   a h
<
=
< n  a d
>
?
> 1   b d��
�� 
leng
? o   a b���� 0 padtext padText
= l  d g
@����
@ [   d g
A
B
A o   d e���� 0 
widthtoadd 
widthToAdd
B o   e f���� 0 padsize padSize��  ��  
5 
C��
C Z   t �
D
E
F
G
D =  t w
H
I
H o   t u���� 0 whichend whichEnd
I m   u v��
�� LeTrLCha
E L   z �
J
J b   z �
K
L
K l  z �
M����
M n  z �
N
O
N 7  { ���
P
Q
�� 
ctxt
P m    ����� 
Q o   � ����� 0 
widthtoadd 
widthToAdd
O o   z {���� 0 padtext padText��  ��  
L o   � ����� 0 thetext theText
F 
R
S
R =  � �
T
U
T o   � ����� 0 whichend whichEnd
U m   � ���
�� LeTrTCha
S 
V
W
V k   � �
X
X 
Y
Z
Y r   � �
[
\
[ `   � �
]
^
] l  � �
_����
_ n  � �
`
a
` 1   � ���
�� 
leng
a o   � ����� 0 thetext theText��  ��  
^ o   � ����� 0 padsize padSize
\ o      ���� 0 	padoffset 	padOffset
Z 
b��
b L   � �
c
c b   � �
d
e
d o   � ����� 0 thetext theText
e l  � �
f����
f n  � �
g
h
g 7  � ���
i
j
�� 
ctxt
i l  � �
k����
k [   � �
l
m
l m   � ����� 
m o   � ����� 0 	padoffset 	padOffset��  ��  
j l  � �
n����
n [   � �
o
p
o o   � ����� 0 	padoffset 	padOffset
p o   � ����� 0 
widthtoadd 
widthToAdd��  ��  
h o   � ����� 0 padtext padText��  ��  ��  
W 
q
r
q =  � �
s
t
s o   � ����� 0 whichend whichEnd
t m   � ���
�� LeTrBCha
r 
u��
u k   � �
v
v 
w
x
w Z  � �
y
z����
y ?   � �
{
|
{ o   � ����� 0 
widthtoadd 
widthToAdd
| m   � ����� 
z r   � �
}
~
} b   � �

�
 n  � �
�
�
� 7  � ���
�
�
�� 
ctxt
� m   � ����� 
� l  � �
�����
� _   � �
�
�
� o   � ����� 0 
widthtoadd 
widthToAdd
� m   � ����� ��  ��  
� o   � ����� 0 padtext padText
� o   � ����� 0 thetext theText
~ o      ���� 0 thetext theText��  ��  
x 
�
�
� r   � �
�
�
� `   � �
�
�
� l  � �
�����
� n  � �
�
�
� 1   � ���
�� 
leng
� o   � ����� 0 thetext theText��  ��  
� o   � ����� 0 padsize padSize
� o      ���� 0 	padoffset 	padOffset
� 
���
� L   � �
�
� b   � �
�
�
� o   � ����� 0 thetext theText
� l  � �
�����
� n  � �
�
�
� 7  � ���
�
�
�� 
ctxt
� l  � �
�����
� [   � �
�
�
� m   � ����� 
� o   � ����� 0 	padoffset 	padOffset��  ��  
� l  � �
�����
� [   � �
�
�
� o   � ����� 0 	padoffset 	padOffset
� _   � �
�
�
� l  � �
�����
� [   � �
�
�
� o   � ����� 0 
widthtoadd 
widthToAdd
� m   � ����� ��  ��  
� m   � ����� ��  ��  
� o   � ����� 0 padtext padText��  ��  ��  ��  
G n  � �
�
�
� I   � ���
����� >0 throwinvalidconstantparameter throwInvalidConstantParameter
� 
�
�
� o   � ����� 0 whichend whichEnd
� 
���
� m   � �
�
� �
�
�  a d d i n g��  ��  
� o   � ����� 0 _support  ��  	� R      ��
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
0 eto eTo��  	� I  ��
����� 
0 _error  
� 
�
�
� m  
�
� �
�
�  p a d   t e x t
� 
�
�
� o  	���� 0 etext eText
� 
�
�
� o  	
���� 0 enumber eNumber
� 
�
�
� o  
���� 0 efrom eFrom
� 
���
� o  ���� 
0 eto eTo��  ��  	� 
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
� i  _ b
�
�
� I     ��
�
�
�� .Txt:SliTnull���     ctxt
� o      ���� 0 thetext theText
� ��
�
�
�� 
FIdx
� |����
���
���  ��  
� o      ���� 0 
startindex 
startIndex��  
� l     
�����
� m      ��
�� 
msng��  ��  
� ��
���
�� 
TIdx
� |����
���
���  ��  
� o      ���� 0 endindex endIndex��  
� l     
�����
� m      �
� 
msng��  ��  ��  
� Q    �
�
�
�
� k   z
�
� 
�
�
� r    
�
�
� n   
�
�
� I    �~
��}�~ "0 astextparameter asTextParameter
� 
�
�
� o    	�|�| 0 thetext theText
� 
��{
� m   	 

�
� �
�
�  �{  �}  
� o    �z�z 0 _support  
� o      �y�y 0 thetext theText
� 
�
�
� r    
�
�
� n   
�
�
� 1    �x
�x 
leng
� o    �w�w 0 thetext theText
� o      �v�v 0 	thelength 	theLength
� 
�
�
� Z    
�
�
��u
� >   
�
�
� o    �t�t 0 
startindex 
startIndex
� m    �s
�s 
msng
� k    l
�
� 
�
�
� r    *
�
�
� n   (
�
�
� I   " (�r
��q�r (0 asintegerparameter asIntegerParameter
� 
�
�
� o   " #�p�p 0 
startindex 
startIndex
� 
��o
� m   # $
�
� �
�
�  f r o m�o  �q  
� o    "�n�n 0 _support  
� o      �m�m 0 
startindex 
startIndex
� 
�
�
� l  + +�l
� �l  
� J D note: index 0 is disallowed as it makes behavior confusing to users     � �   n o t e :   i n d e x   0   i s   d i s a l l o w e d   a s   i t   m a k e s   b e h a v i o r   c o n f u s i n g   t o   u s e r s
�  Z  + =�k�j =   + . o   + ,�i�i 0 
startindex 
startIndex m   , -�h�h   R   1 9�g	
�g .ascrerr ****      � **** m   7 8

 � Z I n v a l i d   i n d e x   (  f r o m    p a r a m e t e r   c a n n o t   b e   0 ) .	 �f
�f 
errn m   3 4�e�e�Y �d�c
�d 
erob o   5 6�b�b 0 
startindex 
startIndex�c  �k  �j   �a Z   > l�`�_ =  > A o   > ?�^�^ 0 endindex endIndex m   ? @�]
�] 
msng Z   D h A   D H o   D E�\�\ 0 
startindex 
startIndex d   E G o   E F�[�[ 0 	thelength 	theLength L   K M o   K L�Z�Z 0 thetext theText  ?   P S o   P Q�Y�Y 0 
startindex 
startIndex o   Q R�X�X 0 	thelength 	theLength  �W  L   V X!! m   V W"" �##  �W   L   [ h$$ n  [ g%&% 7  \ f�V'(
�V 
ctxt' o   ` b�U�U 0 
startindex 
startIndex( m   c e�T�T��& o   [ \�S�S 0 thetext theText�`  �_  �a  
� )*) =  o r+,+ o   o p�R�R 0 endindex endIndex, m   p q�Q
�Q 
msng* -�P- R   u {�O./
�O .ascrerr ****      � ****. m   y z00 �11 J M i s s i n g    f r o m    a n d / o r    t o    p a r a m e t e r ./ �N2�M
�N 
errn2 m   w x�L�L�[�M  �P  �u  
� 343 Z   � �56�K�J5 >  � �787 o   � ��I�I 0 endindex endIndex8 m   � ��H
�H 
msng6 k   � �99 :;: r   � �<=< n  � �>?> I   � ��G@�F�G (0 asintegerparameter asIntegerParameter@ ABA o   � ��E�E 0 endindex endIndexB C�DC m   � �DD �EE  t o�D  �F  ? o   � ��C�C 0 _support  = o      �B�B 0 endindex endIndex; FGF Z  � �HI�A�@H =   � �JKJ o   � ��?�? 0 endindex endIndexK m   � ��>�>  I R   � ��=LM
�= .ascrerr ****      � ****L m   � �NN �OO V I n v a l i d   i n d e x   (  t o    p a r a m e t e r   c a n n o t   b e   0 ) .M �<PQ
�< 
errnP m   � ��;�;�YQ �:R�9
�: 
erobR o   � ��8�8 0 endindex endIndex�9  �A  �@  G S�7S Z   � �TU�6�5T =  � �VWV o   � ��4�4 0 
startindex 
startIndexW m   � ��3
�3 
msngU Z   � �XYZ[X A   � �\]\ o   � ��2�2 0 endindex endIndex] d   � �^^ o   � ��1�1 0 	thelength 	theLengthY L   � �__ m   � �`` �aa  Z bcb ?   � �ded o   � ��0�0 0 endindex endIndexe o   � ��/�/ 0 	thelength 	theLengthc f�.f L   � �gg o   � ��-�- 0 thetext theText�.  [ L   � �hh n  � �iji 7  � ��,kl
�, 
ctxtk m   � ��+�+ l o   � ��*�* 0 endindex endIndexj o   � ��)�) 0 thetext theText�6  �5  �7  �K  �J  4 mnm l  � ��(op�(  o + % both start and end indexes are given   p �qq J   b o t h   s t a r t   a n d   e n d   i n d e x e s   a r e   g i v e nn rsr Z  � �tu�'�&t A   � �vwv o   � ��%�% 0 
startindex 
startIndexw m   � ��$�$  u r   � �xyx [   � �z{z [   � �|}| o   � ��#�# 0 	thelength 	theLength} m   � ��"�" { o   � ��!�! 0 
startindex 
startIndexy o      � �  0 
startindex 
startIndex�'  �&  s ~~ Z  ������ A   � ���� o   � ��� 0 endindex endIndex� m   � ���  � r   � ���� [   � ���� [   � ���� o   � ��� 0 	thelength 	theLength� m   � ��� � o   � ��� 0 endindex endIndex� o      �� 0 endindex endIndex�  �   ��� Z 8����� G  -��� G  ��� ?  ��� o  �� 0 
startindex 
startIndex� o  �� 0 endindex endIndex� F  ��� A  ��� o  	�� 0 
startindex 
startIndex� m  	
�� � A  ��� o  �� 0 endindex endIndex� l 
���� m  �� �  �  � F  )��� ?  ��� o  �� 0 
startindex 
startIndex� o  �� 0 	thelength 	theLength� ?  "%��� o  "#�� 0 endindex endIndex� o  #$�
�
 0 	thelength 	theLength� L  04�� m  03�� ���  �  �  � ��� Z  9R����	� A  9<��� o  9:�� 0 
startindex 
startIndex� m  :;�� � r  ?B��� m  ?@�� � o      �� 0 
startindex 
startIndex� ��� ?  EH��� o  EF�� 0 
startindex 
startIndex� o  FG�� 0 	thelength 	theLength� ��� r  KN��� o  KL�� 0 	thelength 	theLength� o      � �  0 
startindex 
startIndex�  �	  � ��� Z  Sl������ A  SV��� o  ST���� 0 endindex endIndex� m  TU���� � r  Y\��� m  YZ���� � o      ���� 0 endindex endIndex� ��� ?  _b��� o  _`���� 0 endindex endIndex� o  `a���� 0 	thelength 	theLength� ���� r  eh��� o  ef���� 0 	thelength 	theLength� o      ���� 0 endindex endIndex��  ��  � ���� L  mz�� n  my��� 7 nx����
�� 
ctxt� o  rt���� 0 
startindex 
startIndex� o  uw���� 0 endindex endIndex� o  mn���� 0 thetext theText��  
� R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  
� I  ��������� 
0 _error  � ��� m  ���� ���  s l i c e   t e x t� ��� o  ������ 0 etext eText� ��� o  ������ 0 enumber eNumber� ��� o  ������ 0 efrom eFrom� ���� o  ������ 
0 eto eTo��  ��  
� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  c f��� I     ����
�� .Txt:TrmTnull���     ctxt� o      ���� 0 thetext theText� �����
�� 
From� |����������  ��  � o      ���� 0 whichend whichEnd��  � l     ������ m      ��
�� LeTrBCha��  ��  ��  � Q     ����� k    ��� ��� r    ��� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    	���� 0 thetext theText� ���� m   	 
�� ���  ��  ��  � o    ���� 0 _support  � o      ���� 0 thetext theText� ��� Z    -������� H    �� E      J      m    ��
�� LeTrLCha  m    ��
�� LeTrTCha �� m    ��
�� LeTrBCha��   J     	��	 o    ���� 0 whichend whichEnd��  � n   )

 I   # )������ >0 throwinvalidconstantparameter throwInvalidConstantParameter  o   # $���� 0 whichend whichEnd �� m   $ % �  r e m o v i n g��  ��   o    #���� 0 _support  ��  ��  � �� P   . � k   3 �  l  3 ? Z  3 ?���� =  3 6 o   3 4���� 0 thetext theText m   4 5   �!!   L   9 ;"" m   9 :## �$$  ��  ��   H B check if theText is empty or contains white space characters only    �%% �   c h e c k   i f   t h e T e x t   i s   e m p t y   o r   c o n t a i n s   w h i t e   s p a c e   c h a r a c t e r s   o n l y &'& r   @ S()( J   @ D** +,+ m   @ A���� , -��- m   A B��������  ) J      .. /0/ o      ���� 0 
startindex 
startIndex0 1��1 o      ���� 0 endindex endIndex��  ' 232 Z   T x45����4 E  T \676 J   T X88 9:9 m   T U��
�� LeTrLCha: ;��; m   U V��
�� LeTrBCha��  7 J   X [<< =��= o   X Y���� 0 whichend whichEnd��  5 V   _ t>?> r   j o@A@ [   j mBCB o   j k���� 0 
startindex 
startIndexC m   k l���� A o      ���� 0 
startindex 
startIndex? =  c iDED n   c gFGF 4   d g��H
�� 
cha H o   e f���� 0 
startindex 
startIndexG o   c d���� 0 thetext theTextE m   g hII �JJ  ��  ��  3 KLK Z   y �MN����M E  y �OPO J   y }QQ RSR m   y z��
�� LeTrTChaS T��T m   z {��
�� LeTrBCha��  P J   } �UU V��V o   } ~���� 0 whichend whichEnd��  N V   � �WXW r   � �YZY \   � �[\[ o   � ����� 0 endindex endIndex\ m   � ����� Z o      ���� 0 endindex endIndexX =  � �]^] n   � �_`_ 4   � ���a
�� 
cha a o   � ����� 0 endindex endIndex` o   � ����� 0 thetext theText^ m   � �bb �cc  ��  ��  L d��d L   � �ee n   � �fgf 7  � ���hi
�� 
ctxth o   � ����� 0 
startindex 
startIndexi o   � ����� 0 endindex endIndexg o   � ����� 0 thetext theText��   ��j
�� conscasej ��k
�� consdiack ��l
�� conshyphl ����
�� conspunc��   ��m
�� consnumem ����
�� conswhit��  ��  � R      ��no
�� .ascrerr ****      � ****n o      ���� 0 etext eTexto ��pq
�� 
errnp o      ���� 0 enumber eNumberq ��rs
�� 
erobr o      ���� 0 efrom eFroms ��t��
�� 
errtt o      ���� 
0 eto eTo��  � I   � ���u���� 
0 _error  u vwv m   � �xx �yy  t r i m   t e x tw z{z o   � ����� 0 etext eText{ |}| o   � ��� 0 enumber eNumber} ~~ o   � ��~�~ 0 efrom eFrom ��}� o   � ��|�| 
0 eto eTo�}  ��  � ��� l     �{�z�y�{  �z  �y  � ��� l     �x�w�v�x  �w  �v  � ��� l     �u���u  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �t���t  �   Split and Join Suite   � ��� *   S p l i t   a n d   J o i n   S u i t e� ��� l     �s�r�q�s  �r  �q  � ��� i  g j��� I      �p��o�p 0 
_linebreak  � ��n� o      �m�m 0 linebreaktype lineBreakType�n  �o  � l    /���� Z     /����� =    ��� o     �l�l 0 linebreaktype lineBreakType� m    �k
�k LiBrLiOX� L    	�� 1    �j
�j 
lnfd� ��� =   ��� o    �i�i 0 linebreaktype lineBreakType� m    �h
�h LiBrLiCM� ��� L    �� o    �g
�g 
ret � ��� =   ��� o    �f�f 0 linebreaktype lineBreakType� m    �e
�e LiBrLiWi� ��d� L    !�� b     ��� o    �c
�c 
ret � 1    �b
�b 
lnfd�d  � n  $ /��� I   ) /�a��`�a >0 throwinvalidconstantparameter throwInvalidConstantParameter� ��� o   ) *�_�_ 0 linebreaktype lineBreakType� ��^� m   * +�� ��� 
 u s i n g�^  �`  � o   $ )�]�] 0 _support  � < 6 used by `join paragraphs` and `normalize line breaks`   � ��� l   u s e d   b y   ` j o i n   p a r a g r a p h s `   a n d   ` n o r m a l i z e   l i n e   b r e a k s `� ��� l     �\�[�Z�\  �[  �Z  � ��� l     �Y�X�W�Y  �X  �W  � ��� i  k n��� I      �V��U�V 0 
_splittext 
_splitText� ��� o      �T�T 0 thetext theText� ��S� o      �R�R 0 theseparator theSeparator�S  �U  � l    ^���� k     ^�� ��� r     ��� n    
��� I    
�Q��P�Q "0 aslistparameter asListParameter� ��O� o    �N�N 0 theseparator theSeparator�O  �P  � o     �M�M 0 _support  � o      �L�L 0 delimiterlist delimiterList� ��� X    C��K�� Q    >���� l    )���� r     )��� c     %��� n     #��� 1   ! #�J
�J 
pcnt� o     !�I�I 0 aref aRef� m   # $�H
�H 
ctxt� n      ��� 1   & (�G
�G 
pcnt� o   % &�F�F 0 aref aRef��� caution: AS silently ignores invalid TID values, so separator items must be explicitly validated to catch any user errors; for now, just coerce to text and catch errors, but might want to make it more rigorous in future (e.g. if a list of lists is given, should sublist be treated as an error instead of just coercing it to text, which is itself TIDs sensitive); see also existing TODO on TypeSupport's asTextParameter handler   � ���V   c a u t i o n :   A S   s i l e n t l y   i g n o r e s   i n v a l i d   T I D   v a l u e s ,   s o   s e p a r a t o r   i t e m s   m u s t   b e   e x p l i c i t l y   v a l i d a t e d   t o   c a t c h   a n y   u s e r   e r r o r s ;   f o r   n o w ,   j u s t   c o e r c e   t o   t e x t   a n d   c a t c h   e r r o r s ,   b u t   m i g h t   w a n t   t o   m a k e   i t   m o r e   r i g o r o u s   i n   f u t u r e   ( e . g .   i f   a   l i s t   o f   l i s t s   i s   g i v e n ,   s h o u l d   s u b l i s t   b e   t r e a t e d   a s   a n   e r r o r   i n s t e a d   o f   j u s t   c o e r c i n g   i t   t o   t e x t ,   w h i c h   i s   i t s e l f   T I D s   s e n s i t i v e ) ;   s e e   a l s o   e x i s t i n g   T O D O   o n   T y p e S u p p o r t ' s   a s T e x t P a r a m e t e r   h a n d l e r� R      �E�D�
�E .ascrerr ****      � ****�D  � �C��B
�C 
errn� d      �� m      �A�A��B  � n  1 >��� I   6 >�@��?�@ 60 throwinvalidparametertype throwInvalidParameterType� ��� o   6 7�>�> 0 aref aRef� ��� m   7 8�� ���  u s i n g   s e p a r a t o r� ��� m   8 9�=
�= 
ctxt� ��<� m   9 :�� ���  l i s t   o f   t e x t�<  �?  � o   1 6�;�; 0 _support  �K 0 aref aRef� o    �:�: 0 delimiterlist delimiterList� ��� r   D I��� n  D G��� 1   E G�9
�9 
txdl� 1   D E�8
�8 
ascr� o      �7�7 0 oldtids oldTIDs� ��� r   J O��� o   J K�6�6 0 delimiterlist delimiterList� n     � � 1   L N�5
�5 
txdl  1   K L�4
�4 
ascr�  r   P U n   P S 2  Q S�3
�3 
citm o   P Q�2�2 0 thetext theText o      �1�1 0 
resultlist 
resultList  r   V [	
	 o   V W�0�0 0 oldtids oldTIDs
 n      1   X Z�/
�/ 
txdl 1   W X�.
�. 
ascr �- L   \ ^ o   \ ]�,�, 0 
resultlist 
resultList�-  � � � used by `split text` to split text using one or more text item delimiters and current or predefined considering/ignoring settings   � �   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   o n e   o r   m o r e   t e x t   i t e m   d e l i m i t e r s   a n d   c u r r e n t   o r   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s�  l     �+�*�)�+  �*  �)    l     �(�'�&�(  �'  �&    i  o r I      �%�$�% 0 _splitpattern _splitPattern  o      �#�# 0 thetext theText �" o      �!�! 0 patterntext patternText�"  �$   l    � k     �  !  r     "#" n    $%$ I    � &��  @0 asnsregularexpressionparameter asNSRegularExpressionParameter& '(' o    �� 0 patterntext patternText( )*) m    ��  * +�+ m    ,, �--  a t�  �  % o     �� 0 _support  # o      �� 0 asocpattern asocPattern! ./. r    010 n   232 I    �4�� ,0 asnormalizednsstring asNormalizedNSString4 5�5 o    �� 0 thetext theText�  �  3 o    �� 0 _support  1 o      �� 0 
asocstring 
asocString/ 676 l   89:8 r    ;<; m    ��  < o      �� &0 asocnonmatchstart asocNonMatchStart9 G A used to calculate NSRanges for non-matching portions of NSString   : �== �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n g7 >?> r     $@A@ J     "��  A o      �� 0 
resultlist 
resultList? BCB l  % %�DE�  D @ : iterate over each non-matched + matched range in NSString   E �FF t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n gC GHG r   % 6IJI n  % 4KLK I   & 4�M�� @0 matchesinstring_options_range_ matchesInString_options_range_M NON o   & '�� 0 
asocstring 
asocStringO PQP m   ' (��  Q R�
R J   ( 0SS TUT m   ( )�	�	  U V�V n  ) .WXW I   * .���� 
0 length  �  �  X o   ) *�� 0 
asocstring 
asocString�  �
  �  L o   % &�� 0 asocpattern asocPatternJ o      ��  0 asocmatcharray asocMatchArrayH YZY Y   7 ~[�\]� [ k   G y^^ _`_ r   G Taba l  G Rc����c n  G Rded I   M R��f���� 0 rangeatindex_ rangeAtIndex_f g��g m   M N����  ��  ��  e l  G Mh����h n  G Miji I   H M��k����  0 objectatindex_ objectAtIndex_k l��l o   H I���� 0 i  ��  ��  j o   G H����  0 asocmatcharray asocMatchArray��  ��  ��  ��  b o      ����  0 asocmatchrange asocMatchRange` mnm r   U \opo n  U Zqrq I   V Z�������� 0 location  ��  ��  r o   U V����  0 asocmatchrange asocMatchRangep o      ����  0 asocmatchstart asocMatchStartn sts r   ] ouvu c   ] lwxw l  ] jy����y n  ] jz{z I   ^ j��|���� *0 substringwithrange_ substringWithRange_| }��} K   ^ f~~ ����� 0 location   o   _ `���� &0 asocnonmatchstart asocNonMatchStart� ������� 
0 length  � \   a d��� o   a b����  0 asocmatchstart asocMatchStart� o   b c���� &0 asocnonmatchstart asocNonMatchStart��  ��  ��  { o   ] ^���� 0 
asocstring 
asocString��  ��  x m   j k��
�� 
ctxtv n      ���  ;   m n� o   l m���� 0 
resultlist 
resultListt ���� r   p y��� [   p w��� o   p q����  0 asocmatchstart asocMatchStart� l  q v������ n  q v��� I   r v�������� 
0 length  ��  ��  � o   q r����  0 asocmatchrange asocMatchRange��  ��  � o      ���� &0 asocnonmatchstart asocNonMatchStart��  � 0 i  \ m   : ;����  ] \   ; B��� l  ; @������ n  ; @��� I   < @�������� 	0 count  ��  ��  � o   ; <����  0 asocmatcharray asocMatchArray��  ��  � m   @ A���� �   Z ��� l   ������  � "  add final non-matched range   � ��� 8   a d d   f i n a l   n o n - m a t c h e d   r a n g e� ��� r    ���� c    ���� l   ������� n   ���� I   � �������� *0 substringfromindex_ substringFromIndex_� ���� o   � ����� &0 asocnonmatchstart asocNonMatchStart��  ��  � o    ����� 0 
asocstring 
asocString��  ��  � m   � ���
�� 
ctxt� n      ���  ;   � �� o   � ����� 0 
resultlist 
resultList� ���� L   � ��� o   � ����� 0 
resultlist 
resultList��   Q K used by `split text` to split text using a regular expression as separator    ��� �   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   a   r e g u l a r   e x p r e s s i o n   a s   s e p a r a t o r ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  s v��� I      ������� 0 	_jointext 	_joinText� ��� o      ���� 0 thelist theList� ���� o      ���� 0 separatortext separatorText��  ��  � k     5�� ��� r     ��� n    ��� 1    ��
�� 
txdl� 1     ��
�� 
ascr� o      ���� 0 oldtids oldTIDs� ��� r    ��� o    ���� 0 delimiterlist delimiterList� n     ��� 1    
��
�� 
txdl� 1    ��
�� 
ascr� ��� Q    ,���� r    ��� c    ��� o    ���� 0 thelist theList� m    ��
�� 
ctxt� o      ���� 0 
resulttext 
resultText� R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � k    ,�� ��� r    !��� o    ���� 0 oldtids oldTIDs� n     ��� 1     ��
�� 
txdl� 1    ��
�� 
ascr� ���� R   " ,����
�� .ascrerr ****      � ****� m   * +�� ��� b I n v a l i d   d i r e c t   p a r a m e t e r   ( e x p e c t e d   l i s t   o f   t e x t ) .� ����
�� 
errn� m   $ %�����Y� ����
�� 
erob� o   & '���� 0 thelist theList� �����
�� 
errt� m   ( )��
�� 
list��  ��  � ��� r   - 2��� o   - .���� 0 oldtids oldTIDs� n     ��� 1   / 1��
�� 
txdl� 1   . /��
�� 
ascr� ���� L   3 5�� o   3 4���� 0 
resulttext 
resultText��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ��������  ��  ��  � ��� i  w z��� I     ����
�� .Txt:SplTnull���     ctxt� o      ���� 0 thetext theText� ����
�� 
Sepa� |����������  ��  � o      ���� 0 theseparator theSeparator��  � l     ������ m      ��
�� 
msng��  ��  � �����
�� 
Usin� |���������  ��  � o      �~�~ 0 matchformat matchFormat�  � l     ��}�|� m      �{
�{ SerECmpI�}  �|  ��  � k     �    l     �z�z  rl convenience handler for splitting text using TIDs that can also use a regular expression pattern as separator; note that this is similar to using `search text theText for theSeparator returning non matching text` (except that `search text` returns start and end indexes as well as text), but avoids some of the overhead and is an obvious complement to `join text`    ��   c o n v e n i e n c e   h a n d l e r   f o r   s p l i t t i n g   t e x t   u s i n g   T I D s   t h a t   c a n   a l s o   u s e   a   r e g u l a r   e x p r e s s i o n   p a t t e r n   a s   s e p a r a t o r ;   n o t e   t h a t   t h i s   i s   s i m i l a r   t o   u s i n g   ` s e a r c h   t e x t   t h e T e x t   f o r   t h e S e p a r a t o r   r e t u r n i n g   n o n   m a t c h i n g   t e x t `   ( e x c e p t   t h a t   ` s e a r c h   t e x t `   r e t u r n s   s t a r t   a n d   e n d   i n d e x e s   a s   w e l l   a s   t e x t ) ,   b u t   a v o i d s   s o m e   o f   t h e   o v e r h e a d   a n d   i s   a n   o b v i o u s   c o m p l e m e n t   t o   ` j o i n   t e x t ` �y Q     �	 k    }

  r     n    I    �x�w�x "0 astextparameter asTextParameter  o    	�v�v 0 thetext theText �u m   	 
 �  �u  �w   o    �t�t 0 _support   o      �s�s 0 thetext theText �r Z    } =    o    �q�q 0 theseparator theSeparator m    �p
�p 
msng l     L    !! I    �o"�n�o 0 _splitpattern _splitPattern" #$# o    �m�m 0 thetext theText$ %�l% m    && �''  \ s +�l  �n   g a if `at` parameter is omitted, splits on whitespace runs by default, ignoring any `using` options     �(( �   i f   ` a t `   p a r a m e t e r   i s   o m i t t e d ,   s p l i t s   o n   w h i t e s p a c e   r u n s   b y   d e f a u l t ,   i g n o r i n g   a n y   ` u s i n g `   o p t i o n s )*) =  " %+,+ o   " #�k�k 0 matchformat matchFormat, m   # $�j
�j SerECmpI* -.- P   ( 6/01/ L   - 522 I   - 4�i3�h�i 0 
_splittext 
_splitText3 454 o   . /�g�g 0 thetext theText5 6�f6 o   / 0�e�e 0 theseparator theSeparator�f  �h  0 �d7
�d consdiac7 �c8
�c conshyph8 �b9
�b conspunc9 �a:
�a conswhit: �`�_
�` consnume�_  1 �^�]
�^ conscase�]  . ;<; =  9 <=>= o   9 :�\�\ 0 matchformat matchFormat> m   : ;�[
�[ SerECmpP< ?@? L   ? GAA I   ? F�ZB�Y�Z 0 _splitpattern _splitPatternB CDC o   @ A�X�X 0 thetext theTextD E�WE o   A B�V�V 0 theseparator theSeparator�W  �Y  @ FGF =  J MHIH o   J K�U�U 0 matchformat matchFormatI m   K L�T
�T SerECmpCG JKJ P   P ^LM�SL L   U ]NN I   U \�RO�Q�R 0 
_splittext 
_splitTextO PQP o   V W�P�P 0 thetext theTextQ R�OR o   W X�N�N 0 theseparator theSeparator�O  �Q  M �MS
�M conscaseS �LT
�L consdiacT �KU
�K conshyphU �JV
�J conspuncV �IW
�I conswhitW �H�G
�H consnume�G  �S  K XYX =  a dZ[Z o   a b�F�F 0 matchformat matchFormat[ m   b c�E
�E SerECmpDY \�D\ L   g o]] I   g n�C^�B�C 0 
_splittext 
_splitText^ _`_ o   h i�A�A 0 thetext theText` a�@a o   i j�?�? 0 theseparator theSeparator�@  �B  �D   n  r }bcb I   w }�>d�=�> >0 throwinvalidconstantparameter throwInvalidConstantParameterd efe o   w x�<�< 0 matchformat matchFormatf g�;g m   x yhh �ii 
 u s i n g�;  �=  c o   r w�:�: 0 _support  �r   R      �9jk
�9 .ascrerr ****      � ****j o      �8�8 0 etext eTextk �7lm
�7 
errnl o      �6�6 0 enumber eNumberm �5no
�5 
erobn o      �4�4 0 efrom eFromo �3p�2
�3 
errtp o      �1�1 
0 eto eTo�2  	 I   � ��0q�/�0 
0 _error  q rsr m   � �tt �uu  s p l i t   t e x ts vwv o   � ��.�. 0 etext eTextw xyx o   � ��-�- 0 enumber eNumbery z{z o   � ��,�, 0 efrom eFrom{ |�+| o   � ��*�* 
0 eto eTo�+  �/  �y  � }~} l     �)�(�'�)  �(  �'  ~ � l     �&�%�$�&  �%  �$  � ��� i  { ~��� I     �#��
�# .Txt:JoiTnull���     ****� o      �"�" 0 thelist theList� �!�� 
�! 
Sepa� |������  �  � o      �� 0 separatortext separatorText�  � m      �� ���  �   � Q     0���� L    �� I    ���� 0 	_jointext 	_joinText� ��� n   ��� I   	 ���� "0 aslistparameter asListParameter� ��� o   	 
�� 0 thelist theList�  �  � o    	�� 0 _support  � ��� n   ��� I    ���� "0 astextparameter asTextParameter� ��� o    �� 0 separatortext separatorText� ��� m    �� ���  u s i n g   s e p a r a t o r�  �  � o    �� 0 _support  �  �  � R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� �
��
�
 
erob� o      �	�	 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  � I   & 0���� 
0 _error  � ��� m   ' (�� ���  j o i n   t e x t� ��� o   ( )�� 0 etext eText� ��� o   ) *�� 0 enumber eNumber� ��� o   * +�� 0 efrom eFrom� �� � o   + ,���� 
0 eto eTo�   �  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i   ���� I     �����
�� .Txt:SplPnull���     ctxt� o      ���� 0 thetext theText��  � Q     $���� L    �� n    ��� 2   ��
�� 
cpar� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    	���� 0 thetext theText� ���� m   	 
�� ���  ��  ��  � o    ���� 0 _support  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I    $������� 
0 _error  � ��� m    �� ���   s p l i t   p a r a g r a p h s� ��� o    ���� 0 etext eText� ��� o    ���� 0 enumber eNumber� ��� o    ���� 0 efrom eFrom� ���� o     ���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     ����
�� .Txt:JoiPnull���     ****� o      ���� 0 thelist theList� �����
�� 
LiBr� |����������  ��  � o      ���� 0 linebreaktype lineBreakType��  � l     ������ m      ��
�� LiBrLiOX��  ��  ��  � Q     +���� L    �� I    ������� 0 	_jointext 	_joinText� ��� n   ��� I   	 ������� "0 aslistparameter asListParameter� ���� o   	 
���� 0 thelist theList��  ��  � o    	���� 0 _support  � ���� I    ������� 0 
_linebreak  � ���� o    ���� 0 linebreaktype lineBreakType��  ��  ��  ��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I   ! +�� ���� 
0 _error     m   " # �  j o i n   p a r a g r a p h s  o   # $���� 0 etext eText  o   $ %���� 0 enumber eNumber 	
	 o   % &���� 0 efrom eFrom
 �� o   & '���� 
0 eto eTo��  ��  �  l     ��������  ��  ��   �� l     ��������  ��  ��  ��       "�������� !"#$%&'()*+,��    ����������������������������������������������������������������
�� 
pimr�� (0 _unmatchedtexttype _UnmatchedTextType�� $0 _matchedtexttype _MatchedTextType�� &0 _matchedgrouptype _MatchedGroupType�� 0 _support  �� 
0 _error  �� $0 _matchinforecord _matchInfoRecord�� 0 _matchrecords _matchRecords�� &0 _matchedgrouplist _matchedGroupList�� 0 _findpattern _findPattern�� "0 _replacepattern _replacePattern�� 0 	_findtext 	_findText�� 0 _replacetext _replaceText
�� .Txt:Srchnull���     ctxt
�� .Txt:EPatnull���     ctxt
�� .Txt:ETemnull���     ctxt
�� .Txt:UppTnull���     ctxt
�� .Txt:CapTnull���     ctxt
�� .Txt:LowTnull���     ctxt
�� .Txt:FTxtnull���     ctxt
�� .Txt:NLiBnull���     ctxt
�� .Txt:PadTnull���     ctxt
�� .Txt:SliTnull���     ctxt
�� .Txt:TrmTnull���     ctxt�� 0 
_linebreak  �� 0 
_splittext 
_splitText�� 0 _splitpattern _splitPattern�� 0 	_jointext 	_joinText
�� .Txt:SplTnull���     ctxt
�� .Txt:JoiTnull���     ****
�� .Txt:SplPnull���     ctxt
�� .Txt:JoiPnull���     **** ��-�� -  .. ��/��
�� 
cobj/ 00   �� 
�� 
frmk��  
�� 
TxtU
�� 
TxtM
�� 
TxtG 11   �� C
�� 
scpt �� M����23��� 
0 _error  �� �~4�~ 4  �}�|�{�z�y�} 0 handlername handlerName�| 0 etext eText�{ 0 enumber eNumber�z 0 efrom eFrom�y 
0 eto eTo��  2 �x�w�v�u�t�x 0 handlername handlerName�w 0 etext eText�v 0 enumber eNumber�u 0 efrom eFrom�t 
0 eto eTo3  ]�s�r�s �r &0 throwcommanderror throwCommandError� b  ࠡ����+  �q ��p�o56�n�q $0 _matchinforecord _matchInfoRecord�p �m7�m 7  �l�k�j�i�l 0 
asocstring 
asocString�k  0 asocmatchrange asocMatchRange�j 0 
textoffset 
textOffset�i 0 
recordtype 
recordType�o  5 �h�g�f�e�d�c�h 0 
asocstring 
asocString�g  0 asocmatchrange asocMatchRange�f 0 
textoffset 
textOffset�e 0 
recordtype 
recordType�d 0 	foundtext 	foundText�c  0 nexttextoffset nextTextOffset6 �b�a�`�_�^�]�\�[�b *0 substringwithrange_ substringWithRange_
�a 
ctxt
�` 
leng
�_ 
pcls�^ 0 
startindex 
startIndex�] 0 endindex endIndex�\ 0 	foundtext 	foundText�[ �n $��k+  �&E�O���,E�O���k���lv �Z ��Y�X89�W�Z 0 _matchrecords _matchRecords�Y �V:�V :  �U�T�S�R�Q�P�U 0 
asocstring 
asocString�T  0 asocmatchrange asocMatchRange�S  0 asocstartindex asocStartIndex�R 0 
textoffset 
textOffset�Q (0 nonmatchrecordtype nonMatchRecordType�P "0 matchrecordtype matchRecordType�X  8 �O�N�M�L�K�J�I�H�G�F�E�O 0 
asocstring 
asocString�N  0 asocmatchrange asocMatchRange�M  0 asocstartindex asocStartIndex�L 0 
textoffset 
textOffset�K (0 nonmatchrecordtype nonMatchRecordType�J "0 matchrecordtype matchRecordType�I  0 asocmatchstart asocMatchStart�H 0 asocmatchend asocMatchEnd�G &0 asocnonmatchrange asocNonMatchRange�F 0 nonmatchinfo nonMatchInfo�E 0 	matchinfo 	matchInfo9 �D�C�B�A�@�D 0 location  �C 
0 length  �B �A $0 _matchinforecord _matchInfoRecord
�@ 
cobj�W W�j+  E�O��j+ E�O�ᦢ�E�O*�����+ E[�k/E�Z[�l/E�ZO*�����+ E[�k/E�Z[�l/E�ZO�����v �?�>�=;<�<�? &0 _matchedgrouplist _matchedGroupList�> �;=�; =  �:�9�8�7�: 0 
asocstring 
asocString�9 0 	asocmatch 	asocMatch�8 0 
textoffset 
textOffset�7 &0 includenonmatches includeNonMatches�=  ; �6�5�4�3�2�1�0�/�.�-�,�+�*�6 0 
asocstring 
asocString�5 0 	asocmatch 	asocMatch�4 0 
textoffset 
textOffset�3 &0 includenonmatches includeNonMatches�2 "0 submatchresults subMatchResults�1 0 groupindexes groupIndexes�0 (0 asocfullmatchrange asocFullMatchRange�/ &0 asocnonmatchstart asocNonMatchStart�. $0 asocfullmatchend asocFullMatchEnd�- 0 i  �, 0 nonmatchinfo nonMatchInfo�+ 0 	matchinfo 	matchInfo�* &0 asocnonmatchrange asocNonMatchRange< 	�)�(�'�&�%�$�#�"�!�)  0 numberofranges numberOfRanges�( 0 rangeatindex_ rangeAtIndex_�' 0 location  �& 
0 length  �% �$ 0 _matchrecords _matchRecords
�# 
cobj�" �! $0 _matchinforecord _matchInfoRecord�< �jvE�O�j+  kE�O�j ��jk+ E�O�j+ E�O��j+ E�O Uk�kh 	*���k+ ��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO��6F[OY��O� #�㨧�E�O*���b  �+ �k/�6FY hY hO� � ���>?��  0 _findpattern _findPattern� �@� @  ����� 0 thetext theText� 0 patterntext patternText� &0 includenonmatches includeNonMatches�  0 includematches includeMatches�  > ��������������
�	� 0 thetext theText� 0 patterntext patternText� &0 includenonmatches includeNonMatches�  0 includematches includeMatches� 0 asocpattern asocPattern� 0 
asocstring 
asocString� &0 asocnonmatchstart asocNonMatchStart� 0 
textoffset 
textOffset� 0 
resultlist 
resultList�  0 asocmatcharray asocMatchArray� 0 i  � 0 	asocmatch 	asocMatch� 0 nonmatchinfo nonMatchInfo�
 0 	matchinfo 	matchInfo�	 0 	foundtext 	foundText? ������������ ��������������������������� (0 asbooleanparameter asBooleanParameter� @0 asnsregularexpressionparameter asNSRegularExpressionParameter� ,0 asnormalizednsstring asNormalizedNSString� 
0 length  � @0 matchesinstring_options_range_ matchesInString_options_range_� 	0 count  �  0 objectatindex_ objectAtIndex_� 0 rangeatindex_ rangeAtIndex_�  �� 0 _matchrecords _matchRecords
�� 
cobj�� �� 0 foundgroups foundGroups�� 0 
startindex 
startIndex�� &0 _matchedgrouplist _matchedGroupList�� *0 substringfromindex_ substringFromIndex_
�� 
ctxt
�� 
pcls�� 0 endindex endIndex
�� 
leng�� 0 	foundtext 	foundText�� �b  ��l+ E�Ob  ��l+ E�Ob  �j�m+ E�Ob  �k+ E�OjE�OkE�OjvE�O��jj�j+ lvm+ E�O }j�j+ kkh 
��k+ 	E�O*��jk+ 
��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO� ��*���a ,��+ l%�6FY h[OY��O� 1��k+ a &E�Oa b  a �a �a ,a �a �6FY hO� �������AB���� "0 _replacepattern _replacePattern�� ��C�� C  �������� 0 thetext theText�� 0 patterntext patternText�� 0 templatetext templateText��  A ������������������������������������������ 0 thetext theText�� 0 patterntext patternText�� 0 templatetext templateText�� 0 
asocstring 
asocString�� 0 asocpattern asocPattern�� 0 
resultlist 
resultList�� &0 asocnonmatchstart asocNonMatchStart�� 0 
textoffset 
textOffset��  0 asocmatcharray asocMatchArray�� 0 i  �� 0 	asocmatch 	asocMatch�� 0 nonmatchinfo nonMatchInfo�� 0 	matchinfo 	matchInfo�� 0 matchedgroups matchedGroups�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 oldtids oldTIDs�� 0 
resulttext 
resultTextB �����������������������������������������D������H������p���� ,0 asnormalizednsstring asNormalizedNSString�� @0 asnsregularexpressionparameter asNSRegularExpressionParameter
�� 
kocl
�� 
scpt
�� .corecnte****       ****
�� 
cobj�� 
0 length  �� @0 matchesinstring_options_range_ matchesInString_options_range_�� 	0 count  ��  0 objectatindex_ objectAtIndex_�� 0 rangeatindex_ rangeAtIndex_�� �� 0 _matchrecords _matchRecords�� �� 0 	foundtext 	foundText�� 0 
startindex 
startIndex�� &0 _matchedgrouplist _matchedGroupList��  0 replacepattern replacePattern
�� 
ctxt�� 0 etext eTextD ����E
�� 
errn�� 0 enumber eNumberE ����F
�� 
erob�� 0 efrom eFromF ������
�� 
errt�� 
0 eto eTo��  
�� 
errn
�� 
erob
�� 
errt�� *0 substringfromindex_ substringFromIndex_
�� 
ascr
�� 
txdl�� |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_��Mb  �k+  E�Ob  �j�m+ E�O�kv��l jjvjkmvE[�k/E�Z[�l/E�Z[�m/E�ZO��jj�j+ lvm+ E�O �j�j+ 	kkh 	��k+ 
E�O*��jk+ ��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO��,�6FO*���a ,e�+ E�O ���,�l+ a &�6FW X  )a �a ] a ] �a �%[OY�qO��k+ a &�6FO_ a ,E^ Oa _ a ,FO�a &E^ O] _ a ,FO] Y ��jj�j+ lv��+  �������GH���� 0 	_findtext 	_findText�� ��I�� I  ���������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches��  G 
���������������������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches�� 0 
resultlist 
resultList�� 0 oldtids oldTIDs�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 0 i  H ���������������������������������8����p
�� 
errn���Y
�� 
erob�� 
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
��)��  )�����Y hOjvE�O��,E�O���,FOkE�O��k/�,E�O� 2�� �[�\[Z�\Z�2E�Y �E�O�b  ����a �6FY hO �l��-j kh 	�kE�O��,�[�\[�/\�i/2�,E�O� 9�� �[�\[Z�\Z�2E�Y a E�O�b  ����a jva �6FY hO�kE�O���/�,kE�O� 4�� �[�\[Z�\Z�2E�Y a E�O�b  ����a �6FY h[OY�WO���,FO� �����JK��� 0 _replacetext _replaceText� �L� L  ���� 0 thetext theText� 0 fortext forText� 0 newtext newText�  J �����������~�}�|�{� 0 thetext theText� 0 fortext forText� 0 newtext newText� 0 oldtids oldTIDs� 0 
resultlist 
resultList� 0 
startindex 
startIndex� 0 endindex endIndex� 0 i  � 0 	foundtext 	foundText� 0 etext eText�~ 0 enumber eNumber�} 0 efrom eFrom�| 
0 eto eTo�{ 0 
resulttext 
resultTextK ��z�y�x�w��v�u�t�s�r�q�p�o�n �m�lM�k�j<j��i
�z 
errn�y�Y
�x 
erob�w 
�v 
ascr
�u 
txdl
�t 
kocl
�s 
scpt
�r .corecnte****       ****
�q 
citm
�p 
leng
�o 
cobj
�n 
ctxt�m 0 replacetext replaceText�l 0 etext eTextM �h�gN
�h 
errn�g 0 enumber eNumberN �f�eO
�f 
erob�e 0 efrom eFromO �d�c�b
�d 
errt�c 
0 eto eTo�b  
�k 
errt�j �i "0 astextparameter asTextParameter�=��  )�����Y hO��,E�O���,FO�kv��l 
j �jvk��k/�,mvE[�k/E�Z[�l/E�Z[�m/E�ZO�� �[�\[Z�\Z�2�6FY hO �l��-j 
kh �kE�O��,�[�\[�/\�i/2�,E�O�� �[�\[Z�\Z�2E�Y �E�O ��k+ �&�6FW X  )��a �a a �%O�kE�O���/�,kE�O�� �[�\[Z�\Z�2�6FY h[OY�pOa ��,FY b  �a l+ E�O��-E�O���,FO��&E�O���,FO� �a��`�_PQ�^
�a .Txt:Srchnull���     ctxt�` 0 thetext theText�_ �]�\R
�] 
For_�\ 0 fortext forTextR �[ST
�[ 
UsinS {�Z�Y�X�Z 0 matchformat matchFormat�Y  
�X SerECmpIT �WUV
�W 
ReplU {�V�U�T�V 0 newtext newText�U  
�T 
msngV �SW�R
�S 
RetuW {�Q�P�O�Q 0 resultformat resultFormat�P  
�O RetEMatT�R  P �N�M�L�K�J�I�H�G�F�E�D�N 0 thetext theText�M 0 fortext forText�L 0 matchformat matchFormat�K 0 newtext newText�J 0 resultformat resultFormat�I &0 includenonmatches includeNonMatches�H  0 includematches includeMatches�G 0 etext eText�F 0 enumber eNumber�E 0 efrom eFrom�D 
0 eto eToQ %��C��B�A�@�?�>��=�<�;�:�9/�8�79:�6�5�4�3^�2tu�1��0�/��.X�-�,�C "0 astextparameter asTextParameter
�B 
leng
�A 
errn�@�Y
�? 
erob�> 
�= 
msng
�< RetEMatT
�; 
cobj
�: RetEUmaT
�9 RetEAllT�8 >0 throwinvalidconstantparameter throwInvalidConstantParameter
�7 SerECmpI�6 0 	_findtext 	_findText
�5 SerECmpP�4 0 _findpattern _findPattern
�3 SerECmpC
�2 SerECmpE
�1 SerECmpD�0 0 _replacetext _replaceText�/ "0 _replacepattern _replacePattern�. 0 etext eTextX �+�*Y
�+ 
errn�* 0 enumber eNumberY �)�(Z
�) 
erob�( 0 efrom eFromZ �'�&�%
�' 
errt�& 
0 eto eTo�%  �- �, 
0 _error  �^��b  ��l+ E�Ob  ��l+ E�O��,j  )�����Y hO��  ���  felvE[�k/E�Z[�l/E�ZY E��  eflvE[�k/E�Z[�l/E�ZY )��  eelvE[�k/E�Z[�l/E�ZY b  ��l+ O�a   a a  *�����+ VY u�a   *�����+ Y `�a   a g *�����+ VY C�a   a a  *�����+ VY $�a   *�����+ Y b  �a l+ Y ��a   a a  *���m+ VY q�a   *���m+ Y ]�a   a a  *���m+ VY ?�a   a g *���m+ VY #�a   *���m+ Y b  �a l+ W X   !*a "����a #+ $ �$�#�"[\�!
�$ .Txt:EPatnull���     ctxt�# 0 thetext theText�"  [ � �����  0 thetext theText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo\ ��)����]7��
� misccura� *0 nsregularexpression NSRegularExpression� "0 astextparameter asTextParameter� 40 escapedpatternforstring_ escapedPatternForString_
� 
ctxt� 0 etext eText] ��^
� 
errn� 0 enumber eNumber^ ��_
� 
erob� 0 efrom eFrom_ ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �! + ��,b  ��l+ k+ �&W X  *衢���+ 
 �G��
`a�	
� .Txt:ETemnull���     ctxt� 0 thetext theText�
  ` ������ 0 thetext theText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToa ��[�� ����bi����
� misccura� *0 nsregularexpression NSRegularExpression� "0 astextparameter asTextParameter�  60 escapedtemplateforstring_ escapedTemplateForString_
�� 
ctxt�� 0 etext eTextb ����c
�� 
errn�� 0 enumber eNumberc ����d
�� 
erob�� 0 efrom eFromd ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �	 + ��,b  ��l+ k+ �&W X  *衢���+ 
 �������ef��
�� .Txt:UppTnull���     ctxt�� 0 thetext theText�� ��g��
�� 
Locag {�������� 0 
localecode 
localeCode��  
�� 
msng��  e ���������������� 0 thetext theText�� 0 
localecode 
localeCode�� 0 
asocstring 
asocString�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTof ������������������h������� "0 astextparameter asTextParameter�� 0 
asnsstring 
asNSString
�� 
msng�� "0 uppercasestring uppercaseString
�� 
ctxt�� *0 asnslocaleparameter asNSLocaleParameter�� 80 uppercasestringwithlocale_ uppercaseStringWithLocale_�� 0 etext eTexth ����i
�� 
errn�� 0 enumber eNumberi ����j
�� 
erob�� 0 efrom eFromj ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+  �������kl��
�� .Txt:CapTnull���     ctxt�� 0 thetext theText�� ��m��
�� 
Locam {�������� 0 
localecode 
localeCode��  
�� 
msng��  k ���������������� 0 thetext theText�� 0 
localecode 
localeCode�� 0 
asocstring 
asocString�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTol �������������n���� "0 astextparameter asTextParameter�� 0 
asnsstring 
asNSString
�� 
msng�� &0 capitalizedstring capitalizedString
� 
ctxt� *0 asnslocaleparameter asNSLocaleParameter� <0 capitalizedstringwithlocale_ capitalizedStringWithLocale_� 0 etext eTextn ��o
� 
errn� 0 enumber eNumbero ��p
� 
erob� 0 efrom eFromp ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �� Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+  �)��qr�
� .Txt:LowTnull���     ctxt� 0 thetext theText� �s�
� 
Locas {���� 0 
localecode 
localeCode�  
� 
msng�  q �������� 0 thetext theText� 0 
localecode 
localeCode� 0 
asocstring 
asocString� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTor B�����_���tk��� "0 astextparameter asTextParameter� 0 
asnsstring 
asNSString
� 
msng� "0 lowercasestring lowercaseString
� 
ctxt� *0 asnslocaleparameter asNSLocaleParameter� 80 lowercasestringwithlocale_ lowercaseStringWithLocale_� 0 etext eTextt ��u
� 
errn� 0 enumber eNumberu ��v
� 
erob� 0 efrom eFromv ���
� 
errt� 
0 eto eTo�  � � 
0 _error  � Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+   �{��wx�
� .Txt:FTxtnull���     ctxt� 0 templatetext templateText� ���
� 
Usin� 0 	thevalues 	theValues�  w �������������~�}�|�{�z�y� 0 templatetext templateText� 0 	thevalues 	theValues� 0 asocpattern asocPattern� 0 
asocstring 
asocString�  0 asocmatcharray asocMatchArray� 0 resulttexts resultTexts� 0 
startindex 
startIndex� 0 i  � 0 
matchrange 
matchRange� 0 thetoken theToken� 0 	itemindex 	itemIndex� 0 theitem theItem�~ 0 oldtids oldTIDs�} 0 
resulttext 
resultText�| 0 etext eText�{ 0 enumber eNumber�z 0 efrom eFrom�y 
0 eto eTox (���x�w�v��u�t�s�r�q�p�o�n�m�l�k�j	�i�h�g�fy�e�d�c�b�a	;	=�`�_�^	r�]z	��\�[�x "0 aslistparameter asListParameter
�w misccura�v *0 nsregularexpression NSRegularExpression
�u 
msng�t Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_�s 0 
asnsstring 
asNSString�r 
0 length  �q @0 matchesinstring_options_range_ matchesInString_options_range_�p 	0 count  �o  0 objectatindex_ objectAtIndex_�n 0 rangeatindex_ rangeAtIndex_�m 0 location  �l �k *0 substringwithrange_ substringWithRange_
�j 
ctxt
�i 
cha 
�h 
long
�g 
cobj�f  y �Z�Y�X
�Z 
errn�Y�\�X  
�e 
errn�d�\
�c 
erob
�b 
errt�a �` *0 substringfromindex_ substringFromIndex_
�_ 
ascr
�^ 
txdl�] 0 etext eTextz �W�V{
�W 
errn�V 0 enumber eNumber{ �U�T|
�U 
erob�T 0 efrom eFrom| �S�R�Q
�S 
errt�R 
0 eto eTo�Q  �\ �[ 
0 _error  �R9��1b  �k+ E�O��,�j�m+ E�Ob  �k+ E�O��jj�j+ 	lvm+ 
E�OjvE�OjE�O �j�j+ kkh ��k+ jk+ E�O���j+ ��k+ a &�6FO��k+ a &E�O�a   	��6FY O�a i/a &E�O�a �/E�O �a &�6FW +X  )a a a �a �/a a a a �%a %O�j+ �j+ 	E�[OY�\O��k+ a &�6FO_  a !,E�Oa "_  a !,FO�a &E�O�_  a !,FO�VW X # $*a %��] ] a &+ '! �P	��O�N}~�M
�P .Txt:NLiBnull���     ctxt�O 0 thetext theText�N �L�K
�L 
LiBr {�J�I�H�J 0 linebreaktype lineBreakType�I  
�H LiBrLiOX�K  } �G�F�E�D�C�B�G 0 thetext theText�F 0 linebreaktype lineBreakType�E 0 etext eText�D 0 enumber eNumber�C 0 efrom eFrom�B 
0 eto eTo~ 
	��A�@�?�>�=�	��<�;�A "0 astextparameter asTextParameter
�@ 
cpar�? 0 
_linebreak  �> 0 	_jointext 	_joinText�= 0 etext eText� �:�9�
�: 
errn�9 0 enumber eNumber� �8�7�
�8 
erob�7 0 efrom eFrom� �6�5�4
�6 
errt�5 
0 eto eTo�4  �< �; 
0 _error  �M / *b  ��l+ �-*�k+ l+ W X  *碣���+ 	" �3	��2�1���0
�3 .Txt:PadTnull���     ctxt�2 0 thetext theText�1 �/�.�
�/ 
toPl�. 0 	textwidth 	textWidth� �-��
�- 
Char� {�,�+	��, 0 padtext padText�+  � �*��)
�* 
From� {�(�'�&�( 0 whichend whichEnd�'  
�& LeTrLCha�)  � �%�$�#�"�!� ������% 0 thetext theText�$ 0 	textwidth 	textWidth�# 0 padtext padText�" 0 whichend whichEnd�! 0 
widthtoadd 
widthToAdd�  0 padsize padSize� 0 	padoffset 	padOffset� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 	��
��
����
/����
����
���� "0 astextparameter asTextParameter� (0 asintegerparameter asIntegerParameter
� 
leng
� 
errn��Y
� 
erob� 
� LeTrLCha
� 
ctxt
� LeTrTCha
� LeTrBCha� >0 throwinvalidconstantparameter throwInvalidConstantParameter� 0 etext eText� ��
�
� 
errn�
 0 enumber eNumber� �	��
�	 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �0 �b  ��l+ E�Ob  ��l+ E�O���,E�O�j �Y hOb  ��l+ E�O��,E�O��,j  )�����Y hO h��,����%E�[OY��O��  �[�\[Zk\Z�2�%Y s��  ��,�#E�O��[�\[Zk�\Z��2%Y P��  ?�k �[�\[Zk\Z�l"2�%E�Y hO��,�#E�O��[�\[Zk�\Z��kl"2%Y b  ��l+ W X  *a ����a + # �
������
� .Txt:SliTnull���     ctxt� 0 thetext theText� � ��
�  
FIdx� {�������� 0 
startindex 
startIndex��  
�� 
msng� �����
�� 
TIdx� {�������� 0 endindex endIndex��  
�� 
msng��  � ������������������ 0 thetext theText�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	thelength 	theLength�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� 
�������
�����������
"����0DN`������������� "0 astextparameter asTextParameter
�� 
leng
�� 
msng�� (0 asintegerparameter asIntegerParameter
�� 
errn���Y
�� 
erob�� 
�� 
ctxt���[
�� 
bool�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  ��|b  ��l+ E�O��,E�O�� Tb  ��l+ E�O�j  )�����Y hO��  )��' �Y �� �Y �[�\[Z�\Zi2EY hY ��  )��l�Y hO�� Xb  ��l+ E�O�j  )����a Y hO��  +��' 	a Y �� �Y �[�\[Zk\Z�2EY hY hO�j �k�E�Y hO�j �k�E�Y hO��
 �k	 	�ka &a &
 ��	 	��a &a & 	a Y hO�k kE�Y �� �E�Y hO�k kE�Y �� �E�Y hO�[�\[Z�\Z�2EW X  *a ����a + $ �����������
�� .Txt:TrmTnull���     ctxt�� 0 thetext theText�� �����
�� 
From� {�������� 0 whichend whichEnd��  
�� LeTrBCha��  � ������������������ 0 thetext theText�� 0 whichend whichEnd�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ����������� #����Ib�����x����� "0 astextparameter asTextParameter
�� LeTrLCha
�� LeTrTCha
�� LeTrBCha�� >0 throwinvalidconstantparameter throwInvalidConstantParameter
�� 
cobj
�� 
cha 
�� 
ctxt�� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  �� � 
0 _error  �� � �b  ��l+ E�O���mv�kv b  ��l+ Y hO�� {��  �Y hOkilvE[�k/E�Z[�l/E�ZO��lv�kv  h��/� �kE�[OY��Y hO��lv�kv  h��/� �kE�[OY��Y hO�[�\[Z�\Z�2EVW X  *a ����a + % �������� 0 
_linebreak  � ��� �  �� 0 linebreaktype lineBreakType�  � �� 0 linebreaktype lineBreakType� �������
� LiBrLiOX
� 
lnfd
� LiBrLiCM
� 
ret 
� LiBrLiWi� >0 throwinvalidconstantparameter throwInvalidConstantParameter� 0��  �EY %��  �Y ��  	��%Y b  ��l+ & �������� 0 
_splittext 
_splitText� ��� �  ��� 0 thetext theText� 0 theseparator theSeparator�  � ������� 0 thetext theText� 0 theseparator theSeparator� 0 delimiterlist delimiterList� 0 aref aRef� 0 oldtids oldTIDs� 0 
resultlist 
resultList� ���������������� "0 aslistparameter asListParameter
� 
kocl
� 
cobj
� .corecnte****       ****
� 
pcnt
� 
ctxt�  � ���
� 
errn��\�  � � 60 throwinvalidparametertype throwInvalidParameterType
� 
ascr
� 
txdl
� 
citm� _b  �k+  E�O 5�[��l kh  ��,�&��,FW X  b  �����+ [OY��O��,E�O���,FO��-E�O���,FO�' ������� 0 _splitpattern _splitPattern� ��� �  ��� 0 thetext theText� 0 patterntext patternText�  � 
����������~� 0 thetext theText� 0 patterntext patternText� 0 asocpattern asocPattern� 0 
asocstring 
asocString� &0 asocnonmatchstart asocNonMatchStart� 0 
resultlist 
resultList�  0 asocmatcharray asocMatchArray� 0 i  �  0 asocmatchrange asocMatchRange�~  0 asocmatchstart asocMatchStart� ,�}�|�{�z�y�x�w�v�u�t�s�r�} @0 asnsregularexpressionparameter asNSRegularExpressionParameter�| ,0 asnormalizednsstring asNormalizedNSString�{ 
0 length  �z @0 matchesinstring_options_range_ matchesInString_options_range_�y 	0 count  �x  0 objectatindex_ objectAtIndex_�w 0 rangeatindex_ rangeAtIndex_�v 0 location  �u �t *0 substringwithrange_ substringWithRange_
�s 
ctxt�r *0 substringfromindex_ substringFromIndex_� �b  �j�m+ E�Ob  �k+ E�OjE�OjvE�O��jj�j+ lvm+ E�O Fj�j+ kkh ��k+ jk+ E�O�j+ E�O��㩤�k+ 
�&�6FO��j+ E�[OY��O��k+ �&�6FO�( �q��p�o���n�q 0 	_jointext 	_joinText�p �m��m �  �l�k�l 0 thelist theList�k 0 separatortext separatorText�o  � �j�i�h�g�f�j 0 thelist theList�i 0 separatortext separatorText�h 0 oldtids oldTIDs�g 0 delimiterlist delimiterList�f 0 
resulttext 
resultText� �e�d�c�b��a�`�_�^�]�\�
�e 
ascr
�d 
txdl
�c 
ctxt�b  � �[�Z�Y
�[ 
errn�Z�\�Y  
�a 
errn�`�Y
�_ 
erob
�^ 
errt
�] 
list�\ �n 6��,E�O���,FO 
��&E�W X  ���,FO)�������O���,FO�) �X��W�V���U
�X .Txt:SplTnull���     ctxt�W 0 thetext theText�V �T��
�T 
Sepa� {�S�R�Q�S 0 theseparator theSeparator�R  
�Q 
msng� �P��O
�P 
Usin� {�N�M�L�N 0 matchformat matchFormat�M  
�L SerECmpI�O  � �K�J�I�H�G�F�E�K 0 thetext theText�J 0 theseparator theSeparator�I 0 matchformat matchFormat�H 0 etext eText�G 0 enumber eNumber�F 0 efrom eFrom�E 
0 eto eTo� �D�C&�B�A01�@�?�>M�=h�<�;�t�:�9�D "0 astextparameter asTextParameter
�C 
msng�B 0 _splitpattern _splitPattern
�A SerECmpI�@ 0 
_splittext 
_splitText
�? SerECmpP
�> SerECmpC
�= SerECmpD�< >0 throwinvalidconstantparameter throwInvalidConstantParameter�; 0 etext eText� �8�7�
�8 
errn�7 0 enumber eNumber� �6�5�
�6 
erob�5 0 efrom eFrom� �4�3�2
�4 
errt�3 
0 eto eTo�2  �: �9 
0 _error  �U � b  ��l+ E�O��  *��l+ Y ]��  �� *��l+ VY F��  *��l+ Y 5��  �g *��l+ VY ��  *��l+ Y b  ��l+ W X  *a ����a + * �1��0�/���.
�1 .Txt:JoiTnull���     ****�0 0 thelist theList�/ �-��,
�- 
Sepa� {�+�*��+ 0 separatortext separatorText�*  �,  � �)�(�'�&�%�$�) 0 thelist theList�( 0 separatortext separatorText�' 0 etext eText�& 0 enumber eNumber�% 0 efrom eFrom�$ 
0 eto eTo� 	�#��"�!� �����# "0 aslistparameter asListParameter�" "0 astextparameter asTextParameter�! 0 	_jointext 	_joinText�  0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �. 1  *b  �k+  b  ��l+ l+ W X  *梣���+ + �������
� .Txt:SplPnull���     ctxt� 0 thetext theText�  � ������ 0 thetext theText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� �������
�	� "0 astextparameter asTextParameter
� 
cpar� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  �
 �	 
0 _error  � % b  ��l+ �-EW X  *塢���+ , ��� ������
� .Txt:JoiPnull���     ****�  0 thelist theList�� �����
�� 
LiBr� {�������� 0 linebreaktype lineBreakType��  
�� LiBrLiOX��  � �������������� 0 thelist theList�� 0 linebreaktype lineBreakType�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ��������������� "0 aslistparameter asListParameter�� 0 
_linebreak  �� 0 	_jointext 	_joinText�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� , *b  �k+  *�k+ l+ W X  *墣���+  ascr  ��ޭ