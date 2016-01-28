FasdUAS 1.101.10   ��   ��    k             l      ��  ��    V P TestSupport -- handlers and constants used by TestLib's unit testing framework
     � 	 	 �   T e s t S u p p o r t   - -   h a n d l e r s   a n d   c o n s t a n t s   u s e d   b y   T e s t L i b ' s   u n i t   t e s t i n g   f r a m e w o r k 
   
  
 l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��     
 constants     �      c o n s t a n t s      l     ��������  ��  ��        h     �� �� 0 novalue NoValue  l     ��  ��   HB used as unique placeholder to indicate an omitted value; since it's a script object, AS will compare for identity (i.e. is it the same object instance), not merely logical equality, so it can never be confused for a user-supplied value, though with the caveat that it can't go outside the current AS instance or be passed through a `copy` command as then it will be copied and thus no longer match -- TO DO: would it be safe enough just to use `�class ���!�` (no value placeholder)? (note: omitted parameters must use `�class ���!� as default parameter values must be literals)     �  �   u s e d   a s   u n i q u e   p l a c e h o l d e r   t o   i n d i c a t e   a n   o m i t t e d   v a l u e ;   s i n c e   i t ' s   a   s c r i p t   o b j e c t ,   A S   w i l l   c o m p a r e   f o r   i d e n t i t y   ( i . e .   i s   i t   t h e   s a m e   o b j e c t   i n s t a n c e ) ,   n o t   m e r e l y   l o g i c a l   e q u a l i t y ,   s o   i t   c a n   n e v e r   b e   c o n f u s e d   f o r   a   u s e r - s u p p l i e d   v a l u e ,   t h o u g h   w i t h   t h e   c a v e a t   t h a t   i t   c a n ' t   g o   o u t s i d e   t h e   c u r r e n t   A S   i n s t a n c e   o r   b e   p a s s e d   t h r o u g h   a   ` c o p y `   c o m m a n d   a s   t h e n   i t   w i l l   b e   c o p i e d   a n d   t h u s   n o   l o n g e r   m a t c h   - -   T O   D O :   w o u l d   i t   b e   s a f e   e n o u g h   j u s t   t o   u s e   ` � c l a s s   � � � ! � `   ( n o   v a l u e   p l a c e h o l d e r ) ?   ( n o t e :   o m i t t e d   p a r a m e t e r s   m u s t   u s e   ` � c l a s s   � � � ! �   a s   d e f a u l t   p a r a m e t e r   v a l u e s   m u s t   b e   l i t e r a l s )      l     ��������  ��  ��       !   j    
�� "�� 0 _success _SUCCESS " m    	 # # � $ $  P A S S !  % & % j    �� '�� 0 _failure _FAILURE ' m     ( ( � ) )  F A I L &  * + * j    �� ,�� 0 _broken _BROKEN , m     - - � . .  B R O K E N   T E S T +  / 0 / l      1 2 3 1 j    �� 4�� 0 _skipped _SKIPPED 4 m     5 5 � 6 6  S K I P 2 7 1 currently not used by TestLib, only by `osatest`    3 � 7 7 b   c u r r e n t l y   n o t   u s e d   b y   T e s t L i b ,   o n l y   b y   ` o s a t e s t ` 0  8 9 8 l     ��������  ��  ��   9  : ; : l     �� < =��   < J D--------------------------------------------------------------------    = � > > � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ;  ? @ ? l     �� A B��   A t n expected/unexpected errors are trapped and their parameters stored in a 'caught error' record for portability    B � C C �   e x p e c t e d / u n e x p e c t e d   e r r o r s   a r e   t r a p p e d   a n d   t h e i r   p a r a m e t e r s   s t o r e d   i n   a   ' c a u g h t   e r r o r '   r e c o r d   f o r   p o r t a b i l i t y @  D E D l     ��������  ��  ��   E  F G F l      H I J H j    �� K�� $0 _caughterrortype _CaughtErrorType K m    ��
�� 
���� I2, the `class` property of error records passed to TestReport by `assert�` handlers; TestReport checks this record property to determine how to convert test data to its literal representation (unlike other records, which are converted wholesale, error info record properties are individually converted)    J � L LX   t h e   ` c l a s s `   p r o p e r t y   o f   e r r o r   r e c o r d s   p a s s e d   t o   T e s t R e p o r t   b y   ` a s s e r t & `   h a n d l e r s ;   T e s t R e p o r t   c h e c k s   t h i s   r e c o r d   p r o p e r t y   t o   d e t e r m i n e   h o w   t o   c o n v e r t   t e s t   d a t a   t o   i t s   l i t e r a l   r e p r e s e n t a t i o n   ( u n l i k e   o t h e r   r e c o r d s ,   w h i c h   a r e   c o n v e r t e d   w h o l e s a l e ,   e r r o r   i n f o   r e c o r d   p r o p e r t i e s   a r e   i n d i v i d u a l l y   c o n v e r t e d ) G  M N M l     ��������  ��  ��   N  O P O l     ��������  ��  ��   P  Q R Q i    S T S I      �� U���� .0 makecaughterrorrecord makeCaughtErrorRecord U  V W V o      ���� 0 etext eText W  X Y X o      ���� 0 enumber eNumber Y  Z [ Z o      ���� 0 efrom eFrom [  \ ] \ o      ���� 
0 eto eTo ]  ^�� ^ o      ���� 0 epartial ePartial��  ��   T L      _ _ K      ` ` �� a b
�� 
pcls a o    ���� $0 _caughterrortype _CaughtErrorType b �� c d�� 0 	errortext 	errorText c o    ���� 0 etext eText d �� e f�� 0 errornumber errorNumber e o   	 
���� 0 enumber eNumber f �� g h�� 0 
errorvalue 
errorValue g o    ���� 0 efrom eFrom h �� i j�� 0 expectedtype expectedType i o    ���� 
0 eto eTo j �� k���� 0 partialresult partialResult k o    ���� 0 epartial ePartial��   R  l m l l     ��������  ��  ��   m  n o n l     ��������  ��  ��   o  p q p j    &�� r�� *0 _defaulterrorrecord _defaultErrorRecord r I    %�� s���� .0 makecaughterrorrecord makeCaughtErrorRecord s  t u t o    ���� 0 novalue NoValue u  v w v o    ���� 0 novalue NoValue w  x y x o    ���� 0 novalue NoValue y  z { z o     ���� 0 novalue NoValue {  |�� | o     !���� 0 novalue NoValue��  ��   q  } ~ } l     ��������  ��  ��   ~   �  l     ��������  ��  ��   �  � � � i  ' * � � � I      �� ����� <0 normalizeexpectederrorrecord normalizeExpectedErrorRecord �  ��� � o      ���� 0 errorrecord errorRecord��  ��   � l    @ � � � � k     @ � �  � � � l     �� � ���   � � � make sure errorRecord contains at least one valid property and no invalid ones (note: this uses NoValue placeholders so isn't suitable for sending out of current AS instance)    � � � �^   m a k e   s u r e   e r r o r R e c o r d   c o n t a i n s   a t   l e a s t   o n e   v a l i d   p r o p e r t y   a n d   n o   i n v a l i d   o n e s   ( n o t e :   t h i s   u s e s   N o V a l u e   p l a c e h o l d e r s   s o   i s n ' t   s u i t a b l e   f o r   s e n d i n g   o u t   o f   c u r r e n t   A S   i n s t a n c e ) �  � � � Z     � ����� � =      � � � n     � � � 1    ��
�� 
leng � o     ���� 0 errorrecord errorRecord � m    ����   � R    �� � �
�� .ascrerr ****      � **** � m     � � � � � | I n v a l i d    i s    p a r a m e t e r   ( e r r o r   r e c o r d   c o n t a i n e d   n o   p r o p e r t i e s ) . � �� � �
�� 
errn � m   
 �����Y � �� � �
�� 
erob � o    ���� 0 errorrecord errorRecord � �� ���
�� 
errt � m    ��
�� 
reco��  ��  ��   �  � � � r      � � � b     � � � o    ���� 0 errorrecord errorRecord � o    ���� *0 _defaulterrorrecord _defaultErrorRecord � o      ���� $0 normalizedrecord normalizedRecord �  � � � Z  ! = � ����� � >   ! , � � � n  ! $ � � � 1   " $��
�� 
leng � o   ! "���� $0 normalizedrecord normalizedRecord � n  $ + � � � 1   ) +��
�� 
leng � o   $ )���� *0 _defaulterrorrecord _defaultErrorRecord � R   / 9�� � �
�� .ascrerr ****      � **** � m   7 8 � � � � � � I n v a l i d    i s    p a r a m e t e r   ( e r r o r   r e c o r d   c o n t a i n e d   u n r e c o g n i z e d   p r o p e r t i e s ) . � �� � �
�� 
errn � m   1 2�����Y � �� � �
�� 
erob � o   3 4���� 0 errorrecord errorRecord � �� ���
�� 
errt � m   5 6��
�� 
reco��  ��  ��   �  ��� � L   > @ � � o   > ?���� $0 normalizedrecord normalizedRecord��   � i c ensure error info record has all the correct properties and that at least one of them is populated    � � � � �   e n s u r e   e r r o r   i n f o   r e c o r d   h a s   a l l   t h e   c o r r e c t   p r o p e r t i e s   a n d   t h a t   a t   l e a s t   o n e   o f   t h e m   i s   p o p u l a t e d �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i  + . � � � I      �� ����� 20 formatcaughterrorrecord formatCaughtErrorRecord �  ��� � o      ���� 0 errorrecord errorRecord��  ��   � k     � � �  � � � r      � � � m      � � � � � 
 E r r o r � o      ���� 0 	errortext 	errorText �  � � � l   �� � ���   �jd TO DO: while fine for user-supplied 'expected error' records this is not ideal for formatting 'unexpected/incorrect' errors trapped by `on error...` clauses as AS populates unused error params with its own default values; thus all of the following will be included regardless; need to think about how to deal with that (not that there's an ideal solution)    � � � ��   T O   D O :   w h i l e   f i n e   f o r   u s e r - s u p p l i e d   ' e x p e c t e d   e r r o r '   r e c o r d s   t h i s   i s   n o t   i d e a l   f o r   f o r m a t t i n g   ' u n e x p e c t e d / i n c o r r e c t '   e r r o r s   t r a p p e d   b y   ` o n   e r r o r . . . `   c l a u s e s   a s   A S   p o p u l a t e s   u n u s e d   e r r o r   p a r a m s   w i t h   i t s   o w n   d e f a u l t   v a l u e s ;   t h u s   a l l   o f   t h e   f o l l o w i n g   w i l l   b e   i n c l u d e d   r e g a r d l e s s ;   n e e d   t o   t h i n k   a b o u t   h o w   t o   d e a l   w i t h   t h a t   ( n o t   t h a t   t h e r e ' s   a n   i d e a l   s o l u t i o n ) �  � � � Z    � ����� � >    � � � n    � � � o    �� 0 errornumber errorNumber � o    �~�~ 0 errorrecord errorRecord � o    �}�} 0 novalue NoValue � r     � � � b     � � � b     � � � o    �|�| 0 	errortext 	errorText � m     � � � � �    � n    � � � o    �{�{ 0 errornumber errorNumber � o    �z�z 0 errorrecord errorRecord � o      �y�y 0 	errortext 	errorText��  ��   �  � � � Z   7 � ��x�w � >   ' � � � n   ! � � � o    !�v�v 0 	errortext 	errorText � o    �u�u 0 errorrecord errorRecord � o   ! &�t�t 0 novalue NoValue � r   * 3 � � � b   * 1 � � � b   * - � � � o   * +�s�s 0 	errortext 	errorText � m   + , � � � � �  :   � n  - 0 � � � o   . 0�r�r 0 	errortext 	errorText � o   - .�q�q 0 errorrecord errorRecord � o      �p�p 0 	errortext 	errorText�x  �w   �  � � � Z  8 S � ��o�n � >  8 A � � � n  8 ; � � � o   9 ;�m�m 0 
errorvalue 
errorValue � o   8 9�l�l 0 errorrecord errorRecord � o   ; @�k�k 0 novalue NoValue � r   D O �  � b   D M b   D I b   D G o   D E�j�j 0 	errortext 	errorText 1   E F�i
�i 
lnfd m   G H � (                             f r o m :   n  I L	
	 o   J L�h�h 0 
errorvalue 
errorValue
 o   I J�g�g 0 errorrecord errorRecord  o      �f�f 0 	errortext 	errorText�o  �n   �  Z  T o�e�d >  T ] n  T W o   U W�c�c 0 expectedtype expectedType o   T U�b�b 0 errorrecord errorRecord o   W \�a�a 0 novalue NoValue r   ` k b   ` i b   ` e b   ` c o   ` a�`�` 0 	errortext 	errorText 1   a b�_
�_ 
lnfd m   c d � (                                 t o :   n  e h o   f h�^�^ 0 expectedtype expectedType o   e f�]�] 0 errorrecord errorRecord o      �\�\ 0 	errortext 	errorText�e  �d     Z  p �!"�[�Z! >  p y#$# n  p s%&% o   q s�Y�Y 0 partialresult partialResult& o   p q�X�X 0 errorrecord errorRecord$ o   s x�W�W 0 novalue NoValue" r   | �'(' b   | �)*) b   | �+,+ b   | -.- o   | }�V�V 0 	errortext 	errorText. 1   } ~�U
�U 
lnfd, m    �// �00 (         p a r t i a l   r e s u l t :  * n  � �121 o   � ��T�T 0 partialresult partialResult2 o   � ��S�S 0 errorrecord errorRecord( o      �R�R 0 	errortext 	errorText�[  �Z    3�Q3 L   � �44 o   � ��P�P 0 	errortext 	errorText�Q   � 565 l     �O�N�M�O  �N  �M  6 787 l     �L�K�J�L  �K  �J  8 9:9 i  / 2;<; I      �I=�H�I 0 istype isType= >?> o      �G�G 0 thevalue theValue? @�F@ o      �E�E 0 typename typeName�F  �H  < L     AA >     BCB l    	D�D�CD I    	�BEF
�B .corecnte****       ****E J     GG H�AH o     �@�@ 0 thevalue theValue�A  F �?I�>
�? 
koclI o    �=�= 0 typename typeName�>  �D  �C  C m   	 
�<�<  : JKJ l     �;�:�9�;  �:  �9  K LML l     �8�7�6�8  �7  �6  M NON l     �5PQ�5  P J D--------------------------------------------------------------------   Q �RR � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -O STS l     �4UV�4  U "  `assert test error` support   V �WW 8   ` a s s e r t   t e s t   e r r o r `   s u p p o r tT XYX l     �3�2�1�3  �2  �1  Y Z[Z i  3 6\]\ I      �0^�/�0 (0 sanitizeidentifier sanitizeIdentifier^ _�._ o      �-�- 0 aname aName�.  �/  ] P     s`ab` k    rcc ded Z   fg�,�+f =   hih o    �*�* 0 aname aNamei m    jj �kk  g L    ll m    mm �nn  | |�,  �+  e opo r    qrq m    ss �tt  r o      �)�) 0 res  p uvu r    wxw m    yy �zz 6 a b c d e f g h i j k l m n o p q r s t u v w x y z _x o      �(�( 0 
legalchars 
legalCharsv {|{ r    }~} m    �'
�' boovfals~ o      �&�& 0 usepipes usePipes| � X    _��%�� k   . Z�� ��� Z   . P���$�#� H   . 4�� E  . 3��� o   . /�"�" 0 
legalchars 
legalChars� n  / 2��� 1   0 2�!
�! 
pcnt� o   / 0� �  0 charref charRef� k   7 L�� ��� r   7 :��� m   7 8�
� boovtrue� o      �� 0 usepipes usePipes� ��� Z  ; L����� E  ; @��� m   ; <�� ���  \ |� n  < ?��� 1   = ?�
� 
pcnt� o   < =�� 0 charref charRef� r   C H��� b   C F��� m   C D�� ���  \� o   D E�� 0 charref charRef� o      �� 0 charref charRef�  �  �  �$  �#  � ��� r   Q V��� b   Q T��� o   Q R�� 0 res  � o   R S�� 0 charref charRef� o      �� 0 res  � ��� r   W Z��� m   W X�� ��� J a b c d e f g h i j k l m n o p q r s t u v w x y z _ 1 2 3 4 5 6 7 8 9 0� o      �� 0 
legalchars 
legalChars�  �% 0 charref charRef� o   ! "�� 0 aname aName� ��� Z  ` o����� o   ` a�� 0 usepipes usePipes� r   d k��� b   d i��� b   d g��� m   d e�� ���  |� o   e f�� 0 res  � m   g h�� ���  |� o      �� 0 res  �  �  � ��� L   p r�� o   p q�
�
 0 res  �  a �	�
�	 consdiac� ��
� conshyph� ��
� conspunc� ��
� conswhit�  b ��
� conscase� ��
� consnume�  [ ��� l     �� ���  �   ��  � ��� l     ��������  ��  ��  � ��� i  7 :��� I      �������  0 makecallobject makeCallObject� ��� o      ���� 0 handlername handlerName� ���� o      ����  0 parametercount parameterCount��  ��  � k     ]�� ��� r     ��� m     �� ���  � o      ���� 0 args  � ��� Z    >������ =    ��� o    ����  0 parametercount parameterCount� m    ���� � r   
 ��� m   
 �� ���  p a r a m e t e r O b j e c t� o      ���� 0 args  � ��� ?    ��� o    ����  0 parametercount parameterCount� m    ���� � ���� k    :�� ��� Y    ,�������� r     '��� b     %��� b     #��� o     !���� 0 args  � m   ! "�� ��� 2 ,   p a r a m e t e r O b j e c t ' s   i t e m  � o   # $���� 0 i  � o      ���� 0 args  �� 0 i  � m    ���� � o    ����  0 parametercount parameterCount��  � ���� r   - :��� n   - 8��� 7  . 8����
�� 
ctxt� m   2 4���� � m   5 7������� o   - .���� 0 args  � o      ���� 0 args  ��  ��  ��  � ���� L   ? ]�� I  ? \�����
�� .sysodsct****        scpt� b   ? X��� b   ? V��� b   ? T� � b   ? R b   ? K b   ? I m   ? @ � 0 o n   r u n 
 	 	 	 	 	 	 	 	 	 	 s c r i p t   I   @ H��	���� (0 sanitizeidentifier sanitizeIdentifier	 
��
 b   A D m   A B �  C a l l O b j e c t _ o   B C���� 0 handlername handlerName��  ��   m   I J � � 
 	 	 	 	 	 	 	 	 	 	 	 o n   d o T e s t ( s u i t e O b j e c t ,   p a r a m e t e r O b j e c t ) 
 	 	 	 	 	 	 	 	 	 	 	 	 r e t u r n   s u i t e O b j e c t ' s   I   K Q������ (0 sanitizeidentifier sanitizeIdentifier �� o   L M���� 0 handlername handlerName��  ��    m   R S �  (� o   T U���� 0 args  � m   V W � t ) 
 	 	 	 	 	 	 	 	 	 	 	 e n d   r u n 
 	 	 	 	 	 	 	 	 	 	 e n d   s c r i p t 
 	 	 	 	 	 	 	 	 	 e n d   r u n��  ��  �  l     ��������  ��  ��    l     ��������  ��  ��    l     ����   J D--------------------------------------------------------------------    � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  !  l     ��"#��  "   report generation   # �$$ $   r e p o r t   g e n e r a t i o n! %&% l     ��������  ��  ��  & '(' i  ; >)*) I      ��+���� 0 vt100 VT100+ ,��, o      ���� 0 
formatcode 
formatCode��  ��  * k     -- ./. l      ��01��  0F@ Returns a magic character sequence that will apply the specified formatting or other control operation in Terminal.app and other VT100 terminal emulators. Multiple codes may be given as semicolon-separated numeric text, e.g. "1;7". Commonly used style codes are:
	
		0 = reset/normal
		1 = bold
		2 = faint
		4 = underline
		5 = blink
		7 = negative
		8 = conceal
		30-37 = foreground colors (black, red, green, yellow, blue, magenta, cyan, white)
		38;5;N = xterm-256 foreground colors (N = 0-255)
		39 = default foreground color
		40-49 = background colors (as for 30-39)
	   1 �22�   R e t u r n s   a   m a g i c   c h a r a c t e r   s e q u e n c e   t h a t   w i l l   a p p l y   t h e   s p e c i f i e d   f o r m a t t i n g   o r   o t h e r   c o n t r o l   o p e r a t i o n   i n   T e r m i n a l . a p p   a n d   o t h e r   V T 1 0 0   t e r m i n a l   e m u l a t o r s .   M u l t i p l e   c o d e s   m a y   b e   g i v e n   a s   s e m i c o l o n - s e p a r a t e d   n u m e r i c   t e x t ,   e . g .   " 1 ; 7 " .   C o m m o n l y   u s e d   s t y l e   c o d e s   a r e : 
 	 
 	 	 0   =   r e s e t / n o r m a l 
 	 	 1   =   b o l d 
 	 	 2   =   f a i n t 
 	 	 4   =   u n d e r l i n e 
 	 	 5   =   b l i n k 
 	 	 7   =   n e g a t i v e 
 	 	 8   =   c o n c e a l 
 	 	 3 0 - 3 7   =   f o r e g r o u n d   c o l o r s   ( b l a c k ,   r e d ,   g r e e n ,   y e l l o w ,   b l u e ,   m a g e n t a ,   c y a n ,   w h i t e ) 
 	 	 3 8 ; 5 ; N   =   x t e r m - 2 5 6   f o r e g r o u n d   c o l o r s   ( N   =   0 - 2 5 5 ) 
 	 	 3 9   =   d e f a u l t   f o r e g r o u n d   c o l o r 
 	 	 4 0 - 4 9   =   b a c k g r o u n d   c o l o r s   ( a s   f o r   3 0 - 3 9 ) 
 	/ 3��3 L     44 b     565 b     	787 b     9:9 l    ;����; 5     ��<��
�� 
cha < m    ���� 
�� kfrmID  ��  ��  : m    == �>>  [8 o    ���� 0 
formatcode 
formatCode6 m   	 
?? �@@  m��  ( ABA l     ��������  ��  ��  B CDC l     ��������  ��  ��  D EFE l     ��GH��  G  -----   H �II 
 - - - - -F JKJ l     ��������  ��  ��  K LML i  ? BNON I      ��P����  0 maketestreport makeTestReportP QRQ o      ���� 0 testsuitename testSuiteNameR STS o      ���� "0 testhandlername testHandlerNameT U��U o      ���� 0 isstyled isStyled��  ��  O k     UVV WXW Z     IYZ��[Y o     ���� 0 isstyled isStyledZ r    2\]\ K    0^^ ��_`�� 0 n  _ I    ��a���� 0 vt100 VT100a b��b m    ����  ��  ��  ` ��cd�� 0 b  c I    ��e���� 0 vt100 VT100e f��f m    ���� ��  ��  d ��gh�� 0 u  g I    ��i���� 0 vt100 VT100i j��j m    ���� ��  ��  h ��kl�� 0 r  k I     ��m���� 0 vt100 VT100m n��n m    ���� ��  ��  l ��op�� 0 g  o I   ! '��q���� 0 vt100 VT100q r��r m   " #����  ��  ��  p ��s���� 0 e  s I   ( .��t���� 0 vt100 VT100t u��u m   ) *���� "��  ��  ��  ] o      ���� 0 vtstyle vtStyle��  [ r   5 Ivwv K   5 Gxx ��yz�� 0 n  y m   6 7{{ �||  z ��}~�� 0 b  } m   8 9 ���  ~ ������ 0 u  � m   : ;�� ���  � ������ 0 r  � m   < =�� ���  � ������ 0 g  � m   > A�� ���  � ������� 0 e  � m   B E�� ���  ��  w o      ���� 0 vtstyle vtStyleX ���� h   J U����� 0 
testreport 
TestReport� k      �� ��� l     ��������  ��  ��  � ��� l     ���� j     ��� 0 _testresults _testResults� J     �~�~  � c ] a single test_NAME handler may perform multiple asserts, the result of each is recorded here   � ��� �   a   s i n g l e   t e s t _ N A M E   h a n d l e r   m a y   p e r f o r m   m u l t i p l e   a s s e r t s ,   t h e   r e s u l t   o f   e a c h   i s   r e c o r d e d   h e r e� ��� l     �}�|�{�}  �|  �{  � ��� i   ��� I      �z��y�z 0 
_addreport 
_addReport� ��� o      �x�x 0 outcometype outcomeType� ��� o      �w�w 0 fromhandler fromHandler� ��� o      �v�v  0 problemsummary problemSummary� ��� o      �u�u 0 usernote userNote� ��t� o      �s�s 0 testdata testData�t  �y  � l    ���� k     �� ��� l     �r���r  � ] W outcomeType indicates if test_NAME succeeded, failed, or aborted due to defective test   � ��� �   o u t c o m e T y p e   i n d i c a t e s   i f   t e s t _ N A M E   s u c c e e d e d ,   f a i l e d ,   o r   a b o r t e d   d u e   t o   d e f e c t i v e   t e s t� ��� l     �q���q  � W Q userNote is any additional info passed by `assert�` for inclusion in test report   � ��� �   u s e r N o t e   i s   a n y   a d d i t i o n a l   i n f o   p a s s e d   b y   ` a s s e r t & `   f o r   i n c l u s i o n   i n   t e s t   r e p o r t� ��� l     �p���p  � � � testData is record of form {expectedResult:�, expectedError:�, actualResult:�, actualError:�}, unused properties should be omitted -- TO DO: make this a key-value list (easier to read, reformat, and render)   � ����   t e s t D a t a   i s   r e c o r d   o f   f o r m   { e x p e c t e d R e s u l t : & ,   e x p e c t e d E r r o r : & ,   a c t u a l R e s u l t : & ,   a c t u a l E r r o r : & } ,   u n u s e d   p r o p e r t i e s   s h o u l d   b e   o m i t t e d   - -   T O   D O :   m a k e   t h i s   a   k e y - v a l u e   l i s t   ( e a s i e r   t o   r e a d ,   r e f o r m a t ,   a n d   r e n d e r )� ��� r     ��� K     �� �o���o 0 outcometype outcomeType� o    �n�n 0 outcometype outcomeType� �m���m 0 fromhandler fromHandler� o    �l�l 0 fromhandler fromHandler� �k���k  0 problemsummary problemSummary� o    �j�j  0 problemsummary problemSummary� �i���i 0 usernote userNote� o    �h�h 0 usernote userNote� �g��f�g 0 testdata testData� o   	 
�e�e 0 testdata testData�f  � n      ���  ;    � o    �d�d 0 _testresults _testResults� ��c� l   �b���b  �  log result -- DEBUG   � ��� & l o g   r e s u l t   - -   D E B U G�c  � � � TO DO: include param for indicating cause (`assert test result` received wrong result, `assert test error` received wrong/no error, unexpected error in `test_NAME` handler, etc)   � ���d   T O   D O :   i n c l u d e   p a r a m   f o r   i n d i c a t i n g   c a u s e   ( ` a s s e r t   t e s t   r e s u l t `   r e c e i v e d   w r o n g   r e s u l t ,   ` a s s e r t   t e s t   e r r o r `   r e c e i v e d   w r o n g / n o   e r r o r ,   u n e x p e c t e d   e r r o r   i n   ` t e s t _ N A M E `   h a n d l e r ,   e t c )� ��� l     �a�`�_�a  �`  �_  � ��� l     �^�]�\�^  �]  �\  � ��� l     �[�Z�Y�[  �Z  �Y  � ��� i   ��� I      �X��W�X 0 
addsuccess 
addSuccess� ��� o      �V�V 0 fromhandler fromHandler� ��� o      �U�U 0 usernote userNote� ��T� o      �S�S 0 testdata testData�T  �W  � I     �R��Q�R 0 
_addreport 
_addReport� ��� o    �P�P 0 _success _SUCCESS� ��� o    �O�O 0 fromhandler fromHandler� ��� m    �� ���  � ��� o    	�N�N 0 usernote userNote� ��M� o   	 
�L�L 0 testdata testData�M  �Q  � ��� l     �K�J�I�K  �J  �I  � ��� i   ��� I      �H��G�H 0 
addfailure 
addFailure� ��� o      �F�F 0 fromhandler fromHandler� ��� o      �E�E  0 problemsummary problemSummary� ��� o      �D�D 0 usernote userNote� ��C� o      �B�B 0 testdata testData�C  �G  � I     �A��@�A 0 
_addreport 
_addReport� � � o    �?�? 0 _failure _FAILURE   o    �>�> 0 fromhandler fromHandler  o    �=�=  0 problemsummary problemSummary  o    	�<�< 0 usernote userNote �; o   	 
�:�: 0 testdata testData�;  �@  � 	 l     �9�8�7�9  �8  �7  	 

 i    I      �6�5�6 0 	addbroken 	addBroken  o      �4�4 0 fromhandler fromHandler  o      �3�3  0 problemsummary problemSummary  o      �2�2 0 usernote userNote �1 o      �0�0 0 testdata testData�1  �5   I     �/�.�/ 0 
_addreport 
_addReport  o    �-�- 0 _broken _BROKEN  o    �,�, 0 fromhandler fromHandler  o    �+�+  0 problemsummary problemSummary  o    	�*�* 0 usernote userNote �) o   	 
�(�( 0 testdata testData�)  �.    !  l     �'�&�%�'  �&  �%  ! "#" l     �$$%�$  $  -----   % �&& 
 - - - - -# '(' l     �#)*�#  )�� note: Converting AS objects to their literal representations requires some hoop-jumping: it's impractical for `perform unit test` to format test results on the fly as `osatest` doesn't have an event loop so sending itself AEs while the script is executing might be a tad fiddly. Instead, TestReport just captures everything in its _testResults property and is returned by `perform unit test` on completion (ensuring the captured data stays inside an AS context, so that e.g. application references don't lose their target application as happens when they're packed into an AE as a naked typeObjectSpecifier descriptor). `osaglue` must then repeatedly call the nextRawData() iterator via OSAExecuteEvent, which loads the result value directly into a new scriptValueID; that value's literal representation can then be retrieved via OSADisplay and the resulting text passed back to TestReport's updateRawData(), which reinserts it into the original _testResults data. Once the iterator is exhausted, `osatest` can then call TestReport's renderReport() to assemble all that information (which is now all concatenatable text values) into the final report text, which `osatext` can then print to stdout before doing the whole exercise all over again for the next test handler.   * �++	�   n o t e :   C o n v e r t i n g   A S   o b j e c t s   t o   t h e i r   l i t e r a l   r e p r e s e n t a t i o n s   r e q u i r e s   s o m e   h o o p - j u m p i n g :   i t ' s   i m p r a c t i c a l   f o r   ` p e r f o r m   u n i t   t e s t `   t o   f o r m a t   t e s t   r e s u l t s   o n   t h e   f l y   a s   ` o s a t e s t `   d o e s n ' t   h a v e   a n   e v e n t   l o o p   s o   s e n d i n g   i t s e l f   A E s   w h i l e   t h e   s c r i p t   i s   e x e c u t i n g   m i g h t   b e   a   t a d   f i d d l y .   I n s t e a d ,   T e s t R e p o r t   j u s t   c a p t u r e s   e v e r y t h i n g   i n   i t s   _ t e s t R e s u l t s   p r o p e r t y   a n d   i s   r e t u r n e d   b y   ` p e r f o r m   u n i t   t e s t `   o n   c o m p l e t i o n   ( e n s u r i n g   t h e   c a p t u r e d   d a t a   s t a y s   i n s i d e   a n   A S   c o n t e x t ,   s o   t h a t   e . g .   a p p l i c a t i o n   r e f e r e n c e s   d o n ' t   l o s e   t h e i r   t a r g e t   a p p l i c a t i o n   a s   h a p p e n s   w h e n   t h e y ' r e   p a c k e d   i n t o   a n   A E   a s   a   n a k e d   t y p e O b j e c t S p e c i f i e r   d e s c r i p t o r ) .   ` o s a g l u e `   m u s t   t h e n   r e p e a t e d l y   c a l l   t h e   n e x t R a w D a t a ( )   i t e r a t o r   v i a   O S A E x e c u t e E v e n t ,   w h i c h   l o a d s   t h e   r e s u l t   v a l u e   d i r e c t l y   i n t o   a   n e w   s c r i p t V a l u e I D ;   t h a t   v a l u e ' s   l i t e r a l   r e p r e s e n t a t i o n   c a n   t h e n   b e   r e t r i e v e d   v i a   O S A D i s p l a y   a n d   t h e   r e s u l t i n g   t e x t   p a s s e d   b a c k   t o   T e s t R e p o r t ' s   u p d a t e R a w D a t a ( ) ,   w h i c h   r e i n s e r t s   i t   i n t o   t h e   o r i g i n a l   _ t e s t R e s u l t s   d a t a .   O n c e   t h e   i t e r a t o r   i s   e x h a u s t e d ,   ` o s a t e s t `   c a n   t h e n   c a l l   T e s t R e p o r t ' s   r e n d e r R e p o r t ( )   t o   a s s e m b l e   a l l   t h a t   i n f o r m a t i o n   ( w h i c h   i s   n o w   a l l   c o n c a t e n a t a b l e   t e x t   v a l u e s )   i n t o   t h e   f i n a l   r e p o r t   t e x t ,   w h i c h   ` o s a t e x t `   c a n   t h e n   p r i n t   t o   s t d o u t   b e f o r e   d o i n g   t h e   w h o l e   e x e r c i s e   a l l   o v e r   a g a i n   f o r   t h e   n e x t   t e s t   h a n d l e r .( ,-, l     �"�!� �"  �!  �   - ./. l     �01�  0 � {{class:error info record, errorText:eText, errorNumber:eNumber, errorValue:eFrom, expectedType:eTo, partialResult:ePartial}   1 �22 � { c l a s s : e r r o r   i n f o   r e c o r d ,   e r r o r T e x t : e T e x t ,   e r r o r N u m b e r : e N u m b e r ,   e r r o r V a l u e : e F r o m ,   e x p e c t e d T y p e : e T o ,   p a r t i a l R e s u l t : e P a r t i a l }/ 343 j    �5� $0 _errorrecordrefs _errorRecordRefs5 J    ��  4 676 j    �8� 0 
_dataindex 
_dataIndex8 m    �� 7 9:9 j    �;� 0 _datasubindex _dataSubIndex; m    �� : <=< l     ����  �  �  = >?> i   !@A@ I      ���� 0 nextrawdata  �  �  A l   1BCDB k    1EE FGF l     �HI�  H g a note: while most of these values can be dealt with natively, for now just toss them to formatter   I �JJ �   n o t e :   w h i l e   m o s t   o f   t h e s e   v a l u e s   c a n   b e   d e a l t   w i t h   n a t i v e l y ,   f o r   n o w   j u s t   t o s s   t h e m   t o   f o r m a t t e rG KLK l     �MN�  M D > TO DO: need to see what happens when ocids/optrs are returned   N �OO |   T O   D O :   n e e d   t o   s e e   w h a t   h a p p e n s   w h e n   o c i d s / o p t r s   a r e   r e t u r n e dL PQP Z    &RS��R B     TUT o     �� 0 
_dataindex 
_dataIndexU n   VWV 1   
 �
� 
lengW o    
�� 0 _testresults _testResultsS k   "XX YZY l   �[\�  [ 4 . currently working way through an error record   \ �]] \   c u r r e n t l y   w o r k i n g   w a y   t h r o u g h   a n   e r r o r   r e c o r dZ ^_^ Z    n`a�
�	` >   bcb o    �� $0 _errorrecordrefs _errorRecordRefsc J    ��  a k    jdd efe r    'ghg n    %iji 1   # %�
� 
pcntj n    #klk 4    #�m
� 
cobjm m   ! "�� l o     �� $0 _errorrecordrefs _errorRecordRefsh o      �� 0 	erroritem 	errorItemf non Z   ( gpq�� p =  ( /rsr o   ( )���� 0 	erroritem 	errorItems o   ) .���� 0 novalue NoValueq k   2 ctt uvu r   2 ?wxw n   2 9yzy 1   7 9��
�� 
restz o   2 7���� $0 _errorrecordrefs _errorRecordRefsx o      ���� $0 _errorrecordrefs _errorRecordRefsv {|{ Z  @ \}~����} =  @ H� o   @ E���� $0 _errorrecordrefs _errorRecordRefs� J   E G����  ~ r   K X��� [   K R��� o   K P���� 0 _datasubindex _dataSubIndex� m   P Q���� � o      ���� 0 _datasubindex _dataSubIndex��  ��  | ���� L   ] c�� I   ] b�������� 0 nextrawdata  ��  ��  ��  �  �   o ���� L   h j�� o   h i���� 0 	erroritem 	errorItem��  �
  �	  _ ��� r   o ��� n   o }��� o   { }���� 0 testdata testData� n   o {��� 4   t {���
�� 
cobj� o   u z���� 0 
_dataindex 
_dataIndex� o   o t���� 0 _testresults _testResults� o      ���� 0 datalist dataList� ���� Z   �"������ B   � ���� o   � ����� 0 _datasubindex _dataSubIndex� n  � ���� 1   � ���
�� 
leng� o   � ����� 0 datalist dataList� k   � ��� ��� l  � �������  � 4 .	log {"NEXT:", item _dataSubIndex of dataList}   � ��� \ 	 l o g   { " N E X T : " ,   i t e m   _ d a t a S u b I n d e x   o f   d a t a L i s t }� ��� r   � ���� n   � ���� 4   � ����
�� 
cobj� m   � ����� � n   � ���� 4   � ����
�� 
cobj� o   � ����� 0 _datasubindex _dataSubIndex� o   � ����� 0 datalist dataList� o      ���� 0 thedata theData� ��� Z   � �������� F   � ���� I   � �������� 0 istype isType� ��� o   � ����� 0 thedata theData� ���� m   � ���
�� 
reco��  ��  � =  � ���� n  � ���� m   � ���
�� 
pcls� o   � ����� 0 thedata theData� o   � ����� $0 _caughterrortype _CaughtErrorType� k   � ��� ��� r   � ���� J   � ��� ��� l 	 � ������� N   � ��� n   � ���� o   � ����� 0 errornumber errorNumber� o   � ����� 0 thedata theData��  ��  � ��� N   � ��� n   � ���� o   � ����� 0 
errorvalue 
errorValue� o   � ����� 0 thedata theData� ��� l 	 � ������� N   � ��� n   � ���� o   � ����� 0 expectedtype expectedType� o   � ����� 0 thedata theData��  ��  � ���� N   � ��� n   � ���� o   � ����� 0 partialresult partialResult� o   � ����� 0 thedata theData��  � o      ���� $0 _errorrecordrefs _errorRecordRefs� ��� Z  � �������� H   � ��� I   � �������� 0 istype isType� ��� n   � ���� o   � ����� 0 	errortext 	errorText� o   � ����� 0 thedata theData� ���� m   � ���
�� 
ctxt��  ��  � r   � ���� N   � ��� n   � ���� o   � ����� 0 	errortext 	errorText� o   � ����� 0 thedata theData� n      ���  ;   � �� o   � ����� $0 _errorrecordrefs _errorRecordRefs��  ��  � ���� L   � ��� I   � ��������� 0 nextrawdata  ��  ��  ��  ��  ��  � ���� L   � ��� o   � ����� 0 thedata theData��  ��  � k   �"�� ��� r   ���� J   ��� ��� [   ���� o   � ����� 0 
_dataindex 
_dataIndex� m   � ���� � ���� m  ���� ��  � J      �� ��� o      ���� 0 
_dataindex 
_dataIndex� ���� o      ���� 0 _datasubindex _dataSubIndex��  � ���� L  "�� I  !�������� 0 nextrawdata  ��  ��  ��  ��  �  �  Q ���� l '1���� R  '1�����
�� .ascrerr ****      � ****��  � �����
�� 
errn� m  +.����f��  � 1 + `osatest` will check for this error number   � �   V   ` o s a t e s t `   w i l l   c h e c k   f o r   t h i s   e r r o r   n u m b e r��  C ~ x repeatedly called by `osatest` when converting test data to literal representations; once exhausted, returns error 6502   D � �   r e p e a t e d l y   c a l l e d   b y   ` o s a t e s t `   w h e n   c o n v e r t i n g   t e s t   d a t a   t o   l i t e r a l   r e p r e s e n t a t i o n s ;   o n c e   e x h a u s t e d ,   r e t u r n s   e r r o r   6 5 0 2?  l     ��������  ��  ��    i  " % I      ������ 0 updaterawdata   	��	 o      ���� 0 literaltext literalText��  ��   l    p

 k     p  Z     m�� =     o     ���� $0 _errorrecordrefs _errorRecordRefs J    ����   k    3  l   ����   # log {"UPDATE:", _testResults}    � : l o g   { " U P D A T E : " ,   _ t e s t R e s u l t s }  r    % o    ���� 0 literaltext literalText n        4   ! $��!
�� 
cobj! m   " #����   n    !"#" 4    !��$
�� 
cobj$ o     ���� 0 _datasubindex _dataSubIndex# n    %&% o    ���� 0 testdata testData& n    '(' 4    ��)
�� 
cobj) o    ���� 0 
_dataindex 
_dataIndex( o    ���� 0 _testresults _testResults *��* r   & 3+,+ [   & --.- o   & +���� 0 _datasubindex _dataSubIndex. m   + ,���� , o      ���� 0 _datasubindex _dataSubIndex��  ��   k   6 m// 010 r   6 B232 o   6 7���� 0 literaltext literalText3 n      454 1   ? A��
�� 
pcnt5 n   7 ?676 4  < ?��8
�� 
cobj8 m   = >���� 7 o   7 <���� $0 _errorrecordrefs _errorRecordRefs1 9:9 r   C P;<; n   C J=>= 1   H J��
�� 
rest> o   C H���� $0 _errorrecordrefs _errorRecordRefs< o      ���� $0 _errorrecordrefs _errorRecordRefs: ?��? Z  Q m@A����@ =  Q YBCB o   Q V�� $0 _errorrecordrefs _errorRecordRefsC J   V X�~�~  A r   \ iDED [   \ cFGF o   \ a�}�} 0 _datasubindex _dataSubIndexG m   a b�|�| E o      �{�{ 0 _datasubindex _dataSubIndex��  ��  ��   H�zH L   n p�y�y  �z  a[ called by `osatest` to reinsert the raw data's literal representation; must be called after each nextRawData() (if formatting fails for any reason, use a placeholder, e.g. "�object�") -- TO DO: might be better to pass a boolean parameter along with literalText that indicates if the conversion failed; that way, reporter can decide what to insert    �II�   c a l l e d   b y   ` o s a t e s t `   t o   r e i n s e r t   t h e   r a w   d a t a ' s   l i t e r a l   r e p r e s e n t a t i o n ;   m u s t   b e   c a l l e d   a f t e r   e a c h   n e x t R a w D a t a ( )   ( i f   f o r m a t t i n g   f a i l s   f o r   a n y   r e a s o n ,   u s e   a   p l a c e h o l d e r ,   e . g .   " � o b j e c t � " )   - -   T O   D O :   m i g h t   b e   b e t t e r   t o   p a s s   a   b o o l e a n   p a r a m e t e r   a l o n g   w i t h   l i t e r a l T e x t   t h a t   i n d i c a t e s   i f   t h e   c o n v e r s i o n   f a i l e d ;   t h a t   w a y ,   r e p o r t e r   c a n   d e c i d e   w h a t   t o   i n s e r t JKJ l     �x�w�v�x  �w  �v  K LML l     �uNO�u  N  -----   O �PP 
 - - - - -M QRQ l     �tST�t  S y s once raw test data is converted to literal text, `osatest` calls `renderreport` to turn it all into printable text   T �UU �   o n c e   r a w   t e s t   d a t a   i s   c o n v e r t e d   t o   l i t e r a l   t e x t ,   ` o s a t e s t `   c a l l s   ` r e n d e r r e p o r t `   t o   t u r n   i t   a l l   i n t o   p r i n t a b l e   t e x tR VWV l     �s�r�q�s  �r  �q  W XYX i  & )Z[Z I      �p�o�n�p 0 renderreport  �o  �n  [ l   �\]^\ k    �__ `a` l    $bcdb Z    $ef�m�le =     	ghg n     iji 1    �k
�k 
lengj o     �j�j 0 _testresults _testResultsh m    �i�i  f L     kk b    lml b    non b    pqp n   rsr o    �h�h 0 e  s o    �g�g 0 vtstyle vtStyleq m    tt �uu  S K I Po n   vwv o    �f�f 0 n  w o    �e�e 0 vtstyle vtStylem m    xx �yy D   ( t e s t   h a n d l e r   m a d e   n o   a s s e r t i o n s )�m  �l  c &   TO DO: mark 'skip' or 'broken'?   d �zz @   T O   D O :   m a r k   ' s k i p '   o r   ' b r o k e n ' ?a {|{ r   % 8}~} J   % ) ��� m   % &�d�d  � ��c� m   & '�b
�b 
msng�c  ~ J      �� ��� o      �a�a 0 assertcount assertCount� ��`� o      �_�_ 0 errorreport errorReport�`  | ��� X   9g��^�� l  Mb���� k   Mb�� ��� l  M M�]���]  � b \ {outcomeType:FLAG, fromHandler:NAME, problemSummary:TEXT, userNote:USERTEXT, testData:LIST}   � ��� �   { o u t c o m e T y p e : F L A G ,   f r o m H a n d l e r : N A M E ,   p r o b l e m S u m m a r y : T E X T ,   u s e r N o t e : U S E R T E X T ,   t e s t D a t a : L I S T }� ��� Z  M ^���\�[� C   M R��� n  M P��� o   N P�Z�Z 0 fromhandler fromHandler� o   M N�Y�Y 0 	reportref 	reportRef� m   P Q�� ���  a s s e r t  � r   U Z��� [   U X��� o   U V�X�X 0 assertcount assertCount� m   V W�W�W � o      �V�V 0 assertcount assertCount�\  �[  � ��U� Z   _b���T�S� H   _ r�� E  _ q��� J   _ k�� ��� o   _ d�R�R 0 _skipped _SKIPPED� ��Q� o   d i�P�P 0 _success _SUCCESS�Q  � J   k p�� ��O� n  k n��� o   l n�N�N 0 outcometype outcomeType� o   k l�M�M 0 	reportref 	reportRef�O  � l  u^���� k   u^�� ��� Z   u ������ =  u ~��� n  u x��� o   v x�L�L 0 outcometype outcomeType� o   u v�K�K 0 	reportref 	reportRef� o   x }�J�J 0 _failure _FAILURE� r   � ���� m   � ��� ���  F A I L� o      �I�I 0 
statustext 
statusText� ��� =  � ���� n  � ���� o   � ��H�H 0 outcometype outcomeType� o   � ��G�G 0 	reportref 	reportRef� o   � ��F�F 0 _broken _BROKEN� ��E� r   � ���� m   � ��� ��� 
 B R O K E� o      �D�D 0 
statustext 
statusText�E  � r   � ���� m   � ��� ��� 
 O T H E R� o      �C�C 0 
statustext 
statusText� ��� r   � ���� b   � ���� b   � ���� n  � ���� o   � ��B�B 0 r  � o   � ��A�A 0 vtstyle vtStyle� m   � ��� ���  F A I L� n  � ���� o   � ��@�@ 0 n  � o   � ��?�? 0 vtstyle vtStyle� o      �>�> 0 
reporttext 
reportText� ��� Z   � ����=�<� C   � ���� n  � ���� o   � ��;�; 0 fromhandler fromHandler� o   � ��:�: 0 	reportref 	reportRef� m   � ��� ���  a s s e r t  � r   � ���� b   � ���� b   � ���� o   � ��9�9 0 
reporttext 
reportText� m   � ��� ��� *   f a i l e d   o n   a s s e r t i o n  � o   � ��8�8 0 assertcount assertCount� o      �7�7 0 
reporttext 
reportText�=  �<  � ��� r   � ���� b   � ���� b   � ���� b   � ���� b   � ���� o   � ��6�6 0 
reporttext 
reportText� m   � ��� ���    i n  � n  � �� � o   � ��5�5 0 fromhandler fromHandler  o   � ��4�4 0 	reportref 	reportRef� m   � � �   � n  � � o   � ��3�3  0 problemsummary problemSummary o   � ��2�2 0 	reportref 	reportRef� o      �1�1 0 
reporttext 
reportText�  X   �5�0 k   �0		 

 l  � r   � o   � ��/�/ 0 aref aRef J        o      �.�. 0 k   �- o      �,�, 0 v  �-   D > note: v should always be either text or 'caught error' record    � |   n o t e :   v   s h o u l d   a l w a y s   b e   e i t h e r   t e x t   o r   ' c a u g h t   e r r o r '   r e c o r d  Z  �+�* =  n  m  �)
�) 
pcls o  �(�( 0 v   o  �'�' $0 _caughterrortype _CaughtErrorType r   I  �& �%�& 20 formatcaughterrorrecord formatCaughtErrorRecord  !�$! o  �#�# 0 v  �$  �%   o      �"�" 0 v  �+  �*   "�!" r  !0#$# b  !.%&% b  !,'(' b  !()*) b  !&+,+ o  !"� �  0 
reporttext 
reportText, 1  "%�
� 
lnfd* o  &'�� 0 k  ( m  (+-- �..  :  & o  ,-�� 0 v  $ o      �� 0 
reporttext 
reportText�!  �0 0 aref aRef n  � �/0/ o   � ��� 0 testdata testData0 o   � ��� 0 	reportref 	reportRef 121 Z  6[34��3 > 6?565 n 6;787 o  7;�� 0 usernote userNote8 o  67�� 0 	reportref 	reportRef6 m  ;>99 �::  4 r  BW;<; b  BU=>= b  BQ?@? b  BKABA b  BGCDC o  BC�� 0 
reporttext 
reportTextD 1  CF�
� 
lnfdB m  GJEE �FF  (@ n KPGHG o  LP�� 0 usernote userNoteH o  KL�� 0 	reportref 	reportRef> m  QTII �JJ  )< o      �� 0 
reporttext 
reportText�  �  2 K�K L  \^LL o  \]�� 0 
reporttext 
reportText�  � o i note: can't think of a reason individual asserts should ever skip (it's normally suites/tests that skip)   � �MM �   n o t e :   c a n ' t   t h i n k   o f   a   r e a s o n   i n d i v i d u a l   a s s e r t s   s h o u l d   e v e r   s k i p   ( i t ' s   n o r m a l l y   s u i t e s / t e s t s   t h a t   s k i p )�T  �S  �U  � � � note: there may be more than one error report (e.g. if assert fails then tearDown fails as well); for now, just format and return the first   � �NN   n o t e :   t h e r e   m a y   b e   m o r e   t h a n   o n e   e r r o r   r e p o r t   ( e . g .   i f   a s s e r t   f a i l s   t h e n   t e a r D o w n   f a i l s   a s   w e l l ) ;   f o r   n o w ,   j u s t   f o r m a t   a n d   r e t u r n   t h e   f i r s t�^ 0 	reportref 	reportRef� o   < A�� 0 _testresults _testResults� O�O L  h�PP b  h�QRQ b  h�STS b  h�UVU b  h}WXW b  huYZY n hq[\[ o  mq�� 0 g  \ o  hm�� 0 vtstyle vtStyleZ m  qt]] �^^  O KX n u|_`_ o  z|�
�
 0 n  ` o  uz�	�	 0 vtstyle vtStyleV m  }�aa �bb    ( p e r f o r m e d  T n  ��cdc 1  ���
� 
lengd o  ���� 0 _testresults _testResultsR m  ��ee �ff    a s s e r t i o n s )�  ] m g construct final report text; also needs to return ok/fail/broke status flag for generating final tally   ^ �gg �   c o n s t r u c t   f i n a l   r e p o r t   t e x t ;   a l s o   n e e d s   t o   r e t u r n   o k / f a i l / b r o k e   s t a t u s   f l a g   f o r   g e n e r a t i n g   f i n a l   t a l l yY h�h l     ����  �  �  �  ��  M iji l     ��� �  �  �   j k��k l     ��������  ��  ��  ��       ��lm # ( - 5��nopqrstuv��  l �������������������������������� 0 novalue NoValue�� 0 _success _SUCCESS�� 0 _failure _FAILURE�� 0 _broken _BROKEN�� 0 _skipped _SKIPPED�� $0 _caughterrortype _CaughtErrorType�� .0 makecaughterrorrecord makeCaughtErrorRecord�� *0 _defaulterrorrecord _defaultErrorRecord�� <0 normalizeexpectederrorrecord normalizeExpectedErrorRecord�� 20 formatcaughterrorrecord formatCaughtErrorRecord�� 0 istype isType�� (0 sanitizeidentifier sanitizeIdentifier��  0 makecallobject makeCallObject�� 0 vt100 VT100��  0 maketestreport makeTestReportm ��   w�� 0 novalue NoValuew  xx  
�� 
����n �� T����yz���� .0 makecaughterrorrecord makeCaughtErrorRecord�� ��{�� {  ������������ 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 epartial ePartial��  y ������������ 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 epartial ePartialz ��������������
�� 
pcls�� 0 	errortext 	errorText�� 0 errornumber errorNumber�� 0 
errorvalue 
errorValue�� 0 expectedtype expectedType�� 0 partialresult partialResult�� �� �b  ������o ����|
�� 
pcls
�� 
����| ��m}�� 0 	errortext 	errorText} ��m~�� 0 errornumber errorNumber~ ��m�� 0 
errorvalue 
errorValue ��m��� 0 expectedtype expectedType� ��m���� 0 partialresult partialResult��  p �� ����������� <0 normalizeexpectederrorrecord normalizeExpectedErrorRecord�� ����� �  ���� 0 errorrecord errorRecord��  � ������ 0 errorrecord errorRecord�� $0 normalizedrecord normalizedRecord� 	�������������� � �
�� 
leng
�� 
errn���Y
�� 
erob
�� 
errt
�� 
reco�� �� A��,j  )�������Y hO�b  %E�O��,b  �, )�������Y hO�q �� ����������� 20 formatcaughterrorrecord formatCaughtErrorRecord�� ����� �  ���� 0 errorrecord errorRecord��  � ������ 0 errorrecord errorRecord�� 0 	errortext 	errorText�  ��� ��� ���������/�� 0 errornumber errorNumber�� 0 	errortext 	errorText�� 0 
errorvalue 
errorValue
�� 
lnfd�� 0 expectedtype expectedType�� 0 partialresult partialResult�� ��E�O��,b    ��%��,%E�Y hO��,b    ��%��,%E�Y hO��,b    ��%�%��,%E�Y hO��,b    ��%�%��,%E�Y hO��,b    ��%�%��,%E�Y hO�r ��<���������� 0 istype isType�� ����� �  ������ 0 thevalue theValue�� 0 typename typeName��  � ������ 0 thevalue theValue�� 0 typename typeName� ����
�� 
kocl
�� .corecnte****       ****�� �kv�l js ��]���������� (0 sanitizeidentifier sanitizeIdentifier�� ����� �  ���� 0 aname aName��  � ������������ 0 aname aName�� 0 res  �� 0 
legalchars 
legalChars�� 0 usepipes usePipes�� 0 charref charRef� abjmsy�������������
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pcnt�� t�� p��  �Y hO�E�O�E�OfE�O @�[��l kh ���, eE�O��, 
�%E�Y hY hO��%E�O�E�[OY��O� ��%�%E�Y hO�Vt �������������  0 makecallobject makeCallObject�� ����� �  ������ 0 handlername handlerName��  0 parametercount parameterCount��  � ���������� 0 handlername handlerName��  0 parametercount parameterCount�� 0 args  �� 0 i  � ���������
�� 
ctxt�� (0 sanitizeidentifier sanitizeIdentifier
�� .sysodsct****        scpt�� ^�E�O�k  �E�Y 0�k ) k�kh ��%�%E�[OY��O�[�\[Zm\Zi2E�Y hO�*�%k+ %�%*�k+ %�%�%�%j 
u ��*���������� 0 vt100 VT100�� ����� �  ���� 0 
formatcode 
formatCode��  � ���� 0 
formatcode 
formatCode� ��~�}=?
� 
cha �~ 
�} kfrmID  �� )���0�%�%�%v �|O�{�z���y�|  0 maketestreport makeTestReport�{ �x��x �  �w�v�u�w 0 testsuitename testSuiteName�v "0 testhandlername testHandlerName�u 0 isstyled isStyled�z  � �t�s�r�q�p�t 0 testsuitename testSuiteName�s "0 testhandlername testHandlerName�r 0 isstyled isStyled�q 0 vtstyle vtStyle�p 0 
testreport 
TestReport� �o�n�m�l�k�j�i�h�g�f�e�d{�����c���o 0 n  �n 0 vt100 VT100�m 0 b  �l 0 u  �k �j 0 r  �i �h 0 g  �g  �f 0 e  �e "�d �c 0 
testreport 
TestReport� �b��a�`���_
�b .ascrinit****      � ****� k     )�� ��� ��� ��� ��� 
�� 3�� 6�� 9�� >�� �� X�^�^  �a  �`  � �]�\�[�Z�Y�X�W�V�U�T�S�] 0 _testresults _testResults�\ 0 
_addreport 
_addReport�[ 0 
addsuccess 
addSuccess�Z 0 
addfailure 
addFailure�Y 0 	addbroken 	addBroken�X $0 _errorrecordrefs _errorRecordRefs�W 0 
_dataindex 
_dataIndex�V 0 _datasubindex _dataSubIndex�U 0 nextrawdata  �T 0 updaterawdata  �S 0 renderreport  � �R�����Q�P�O����R 0 _testresults _testResults� �N��M�L���K�N 0 
_addreport 
_addReport�M �J��J �  �I�H�G�F�E�I 0 outcometype outcomeType�H 0 fromhandler fromHandler�G  0 problemsummary problemSummary�F 0 usernote userNote�E 0 testdata testData�L  � �D�C�B�A�@�D 0 outcometype outcomeType�C 0 fromhandler fromHandler�B  0 problemsummary problemSummary�A 0 usernote userNote�@ 0 testdata testData� �?�>�=�<�;�:�? 0 outcometype outcomeType�> 0 fromhandler fromHandler�=  0 problemsummary problemSummary�< 0 usernote userNote�; 0 testdata testData�: 
�K ������b   6FOP� �9��8�7���6�9 0 
addsuccess 
addSuccess�8 �5��5 �  �4�3�2�4 0 fromhandler fromHandler�3 0 usernote userNote�2 0 testdata testData�7  � �1�0�/�1 0 fromhandler fromHandler�0 0 usernote userNote�/ 0 testdata testData� ��.�-�. �- 0 
_addreport 
_addReport�6 *b  �ࡢ�+ � �,��+�*���)�, 0 
addfailure 
addFailure�+ �(��( �  �'�&�%�$�' 0 fromhandler fromHandler�&  0 problemsummary problemSummary�% 0 usernote userNote�$ 0 testdata testData�*  � �#�"�!� �# 0 fromhandler fromHandler�"  0 problemsummary problemSummary�! 0 usernote userNote�  0 testdata testData� ��� � 0 
_addreport 
_addReport�) *b  �����+ � ������� 0 	addbroken 	addBroken� ��� �  ����� 0 fromhandler fromHandler�  0 problemsummary problemSummary� 0 usernote userNote� 0 testdata testData�  � ����� 0 fromhandler fromHandler�  0 problemsummary problemSummary� 0 usernote userNote� 0 testdata testData� ��� � 0 
_addreport 
_addReport� *b  �����+ �Q $0 _errorrecordrefs _errorRecordRefs�P 0 
_dataindex 
_dataIndex�O 0 _datasubindex _dataSubIndex� �A������ 0 nextrawdata  �  �  � �
�	��
 0 	erroritem 	errorItem�	 0 datalist dataList� 0 thedata theData� �������� ����������������������
� 
leng
� 
cobj
� 
pcnt
� 
rest� 0 nextrawdata  � 0 testdata testData
� 
reco�  0 istype isType
�� 
pcls
�� 
bool�� 0 errornumber errorNumber�� 0 
errorvalue 
errorValue�� 0 expectedtype expectedType�� 0 partialresult partialResult�� �� 0 	errortext 	errorText
�� 
ctxt
�� 
errn��f�2b  b   �,b  jv Tb  �k/�,E�O�b     6b  �,Ec  Ob  jv  b  kEc  Y hO*j+ Y hO�Y hOb   �b  /�,E�Ob  ��, p��b  /�l/E�O*��l+ 	 ��,b   �& C��,��,��,��,�vEc  O*��,a l+  ��,b  6FY hO*j+ Y hO�Y *b  kklvE[�k/Ec  Z[�l/Ec  ZO*j+ Y hO)a a lh� ������������ 0 updaterawdata  �� ����� �  ���� 0 literaltext literalText��  � ���� 0 literaltext literalText� ��������
�� 
cobj�� 0 testdata testData
�� 
pcnt
�� 
rest�� qb  jv  -�b   �b  /�,�b  /�l/FOb  kEc  Y 9�b  �k/�,FOb  �,Ec  Ob  jv  b  kEc  Y hOh� ��[���������� 0 renderreport  ��  ��  � ������������������ 0 assertcount assertCount�� 0 errorreport errorReport�� 0 	reportref 	reportRef�� 0 
statustext 
statusText�� 0 
reporttext 
reportText�� 0 aref aRef�� 0 k  �� 0 v  � #����t��x��������������������������������-��9EI��]ae
�� 
leng�� 0 e  �� 0 n  
�� 
msng
�� 
cobj
�� 
kocl
�� .corecnte****       ****�� 0 fromhandler fromHandler�� 0 outcometype outcomeType�� 0 r  ��  0 problemsummary problemSummary�� 0 testdata testData
�� 
pcls�� 20 formatcaughterrorrecord formatCaughtErrorRecord
�� 
lnfd�� 0 usernote userNote�� 0 g  ���b   �,j  b  �,�%b  �,%�%Y hOj�lvE[�k/E�Z[�l/E�ZO-b   [��l kh ��,� 
�kE�Y hOb  b  lv��,kv ��,b    �E�Y ��,b    �E�Y �E�Ob  �,a %b  �,%E�O��,a  �a %�%E�Y hO�a %��,%a %�a ,%E�O S�a ,[��l kh �E[�k/E�Z[�l/E�ZO�a ,b    *�k+ E�Y hO�_ %�%a %�%E�[OY��O�a ,a  �_ %a %�a ,%a %E�Y hO�Y h[OY��Ob  a ,a  %b  �,%a !%b   �,%a "%�_ *jv�OL OL OL OL Ojv�Ok�Ok�OL OL 	OL 
�y V� 3�*jk+ �*kk+ �*�k+ �*�k+ �*�k+ �*�k+ �E�Y ���������a �a �E�Oa a K S�ascr  ��ޭ