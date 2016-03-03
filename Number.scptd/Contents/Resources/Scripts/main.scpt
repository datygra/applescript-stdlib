FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� Number -- manipulate numeric values and perform common math functions

Notes:

- The Trigonometry and Logarithm handlers are slightly modified versions of handlers found in ESG MathLib <http://www.esglabs.com/>, which in turn are conversions of functions in the Cephes Mathematical Library by Stephen L. Moshier <http://netlib.org/cephes/>.


TO DO: 

- debug, finalize `parse/format number` behaviors

- should `tan` return `infinity` symbol instead of erroring?

- use identifiers rather than properties in number format record? (other libraries already do this to mimimize namespace pollution)

- support `NSNumberFormatterOrdinalStyle`, `NSNumberFormatterCurrencyISOCodeStyle `, etc (10.11+) in `parse/format number`?

- -[NSNumberFormatter setMinimumFractionDigits:] may be buggy; see notes in _setBasicFormat()

- in `format number`, any way to include "+" sign for exponent, same as AS? (e.g. "1.0E+8" rather than "1.0E8")
				
     � 	 	P   N u m b e r   - -   m a n i p u l a t e   n u m e r i c   v a l u e s   a n d   p e r f o r m   c o m m o n   m a t h   f u n c t i o n s 
 
 N o t e s : 
 
 -   T h e   T r i g o n o m e t r y   a n d   L o g a r i t h m   h a n d l e r s   a r e   s l i g h t l y   m o d i f i e d   v e r s i o n s   o f   h a n d l e r s   f o u n d   i n   E S G   M a t h L i b   < h t t p : / / w w w . e s g l a b s . c o m / > ,   w h i c h   i n   t u r n   a r e   c o n v e r s i o n s   o f   f u n c t i o n s   i n   t h e   C e p h e s   M a t h e m a t i c a l   L i b r a r y   b y   S t e p h e n   L .   M o s h i e r   < h t t p : / / n e t l i b . o r g / c e p h e s / > . 
 
 
 T O   D O :   
 
 -   d e b u g ,   f i n a l i z e   ` p a r s e / f o r m a t   n u m b e r `   b e h a v i o r s 
 
 -   s h o u l d   ` t a n `   r e t u r n   ` i n f i n i t y `   s y m b o l   i n s t e a d   o f   e r r o r i n g ? 
 
 -   u s e   i d e n t i f i e r s   r a t h e r   t h a n   p r o p e r t i e s   i n   n u m b e r   f o r m a t   r e c o r d ?   ( o t h e r   l i b r a r i e s   a l r e a d y   d o   t h i s   t o   m i m i m i z e   n a m e s p a c e   p o l l u t i o n ) 
 
 -   s u p p o r t   ` N S N u m b e r F o r m a t t e r O r d i n a l S t y l e ` ,   ` N S N u m b e r F o r m a t t e r C u r r e n c y I S O C o d e S t y l e   ` ,   e t c   ( 1 0 . 1 1 + )   i n   ` p a r s e / f o r m a t   n u m b e r ` ? 
 
 -   - [ N S N u m b e r F o r m a t t e r   s e t M i n i m u m F r a c t i o n D i g i t s : ]   m a y   b e   b u g g y ;   s e e   n o t e s   i n   _ s e t B a s i c F o r m a t ( ) 
 
 -   i n   ` f o r m a t   n u m b e r ` ,   a n y   w a y   t o   i n c l u d e   " + "   s i g n   f o r   e x p o n e n t ,   s a m e   a s   A S ?   ( e . g .   " 1 . 0 E + 8 "   r a t h e r   t h a n   " 1 . 0 E 8 " ) 
 	 	 	 	 
   
  
 l     ��������  ��  ��        l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -     !   l     �� " #��   "   support    # � $ $    s u p p o r t !  % & % l     ��������  ��  ��   &  ' ( ' l      ) * + ) j    �� ,�� 0 _support   , N     - - 4    �� .
�� 
scpt . m     / / � 0 0  T y p e S u p p o r t * "  used for parameter checking    + � 1 1 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g (  2 3 2 l     ��������  ��  ��   3  4 5 4 i   ! 6 7 6 I      �� 8���� 
0 _error   8  9 : 9 o      ���� 0 handlername handlerName :  ; < ; o      ���� 0 etext eText <  = > = o      ���� 0 enumber eNumber >  ? @ ? o      ���� 0 efrom eFrom @  A�� A o      ���� 
0 eto eTo��  ��   7 n     B C B I    �� D���� &0 throwcommanderror throwCommandError D  E F E m     G G � H H  N u m b e r F  I J I o    ���� 0 handlername handlerName J  K L K o    ���� 0 etext eText L  M N M o    	���� 0 enumber eNumber N  O P O o   	 
���� 0 efrom eFrom P  Q�� Q o   
 ���� 
0 eto eTo��  ��   C o     ���� 0 _support   5  R S R l     ��������  ��  ��   S  T U T l     ��������  ��  ��   U  V W V l     �� X Y��   X J D--------------------------------------------------------------------    Y � Z Z � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - W  [ \ [ l     �� ] ^��   ]  
 constants    ^ � _ _    c o n s t a n t s \  ` a ` l     ��������  ��  ��   a  b c b l      d e f d j   " $�� g�� 	0 __e__   g m   " # h h @�
�_� e ; 5 the mathematical constant e (natural logarithm base)    f � i i j   t h e   m a t h e m a t i c a l   c o n s t a n t   e   ( n a t u r a l   l o g a r i t h m   b a s e ) c  j k j l     ��������  ��  ��   k  l m l l      n o p n j   % '�� q�� 0 _isequaldelta _isEqualDelta q m   % & r r =q���-� o i c multiplier used by `cmp` to allow for slight differences due to floating point's limited precision    p � s s �   m u l t i p l i e r   u s e d   b y   ` c m p `   t o   a l l o w   f o r   s l i g h t   d i f f e r e n c e s   d u e   t o   f l o a t i n g   p o i n t ' s   l i m i t e d   p r e c i s i o n m  t u t l     ��������  ��  ��   u  v w v l     �� x y��   x � � [positive] numeric range within which `basic format` uses decimal rather than scientific notation when formatting reals (this mimics AS's own behavior); the corresponding negative range is calcuated automatically    y � z z�   [ p o s i t i v e ]   n u m e r i c   r a n g e   w i t h i n   w h i c h   ` b a s i c   f o r m a t `   u s e s   d e c i m a l   r a t h e r   t h a n   s c i e n t i f i c   n o t a t i o n   w h e n   f o r m a t t i n g   r e a l s   ( t h i s   m i m i c s   A S ' s   o w n   b e h a v i o r ) ;   t h e   c o r r e s p o n d i n g   n e g a t i v e   r a n g e   i s   c a l c u a t e d   a u t o m a t i c a l l y w  { | { j   ( *�� }�� $0 _mindecimalrange _minDecimalRange } m   ( ) ~ ~ ?PbM��� |   �  j   + -�� ��� $0 _maxdecimalrange _maxDecimalRange � m   + , � � @È      �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � J D--------------------------------------------------------------------    � � � � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - �  � � � l     �� � ���   �   parse and format    � � � � "   p a r s e   a n d   f o r m a t �  � � � l     ��������  ��  ��   �  � � � i  . 1 � � � I      �� ����� (0 _asintegerproperty _asIntegerProperty �  � � � o      ���� 0 thevalue theValue �  � � � o      ���� 0 propertyname propertyName �  ��� � o      ���� 0 minvalue minValue��  ��   � l    8 � � � � Q     8 � � � � k    & � �  � � � r     � � � c     � � � o    ���� 0 thevalue theValue � m    ��
�� 
long � o      ���� 0 n   �  � � � Z  	 # � ����� � G   	  � � � >   	  � � � o   	 
���� 0 n   � c   
  � � � o   
 ���� 0 thevalue theValue � m    ��
�� 
doub � A     � � � o    ���� 0 n   � o    ���� 0 minvalue minValue � R    ���� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � m    �����Y��  ��  ��   �  ��� � L   $ & � � o   $ %���� 0 n  ��   � R      ���� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � d       � � m      �������   � R   . 8�� � �
�� .ascrerr ****      � **** � b   2 7 � � � b   2 5 � � � m   2 3 � � � � � J  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    � o   3 4���� 0 propertyname propertyName � m   5 6 � � � � � P    p r o p e r t y   i s   n o t   a   n o n - n e g a t i v e   i n t e g e r � �� ���
�� 
errn � m   0 1�����Y��   � . ( TO DO: what about sensible upper bound?    � � � � P   T O   D O :   w h a t   a b o u t   s e n s i b l e   u p p e r   b o u n d ? �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i  2 5 � � � I      �� ����� ,0 _makenumberformatter _makeNumberFormatter �  � � � o      ���� 0 formatstyle formatStyle �  � � � o      ���� 0 
localecode 
localeCode �  ��� � o      ���� 0 	thenumber 	theNumber��  ��   � l   � � � � � k    � � �  � � � l     � � � � r      � � � n     � � � I    �������� 0 init  ��  ��   � n     � � � I    ��~�}� 	0 alloc  �~  �}   � n     � � � o    �|�| &0 nsnumberformatter NSNumberFormatter � m     �{
�{ misccura � o      �z�z 0 asocformatter asocFormatter �	 (note that while NSFormatter provides a global +setDefaultFormatterBehavior: option to change all NSNumberFormatters to use pre-10.4 behavior, we don't bother to call setFormatterBehavior: as it's very unlikely nowadays that a host process would change this)    � � � �   ( n o t e   t h a t   w h i l e   N S F o r m a t t e r   p r o v i d e s   a   g l o b a l   + s e t D e f a u l t F o r m a t t e r B e h a v i o r :   o p t i o n   t o   c h a n g e   a l l   N S N u m b e r F o r m a t t e r s   t o   u s e   p r e - 1 0 . 4   b e h a v i o r ,   w e   d o n ' t   b o t h e r   t o   c a l l   s e t F o r m a t t e r B e h a v i o r :   a s   i t ' s   v e r y   u n l i k e l y   n o w a d a y s   t h a t   a   h o s t   p r o c e s s   w o u l d   c h a n g e   t h i s ) �  � � � Q   � � � � � Z   s � ��y � � =     � � � l    ��x�w � I   �v � �
�v .corecnte****       **** � J     � �  ��u � o    �t�t 0 formatstyle formatStyle�u   � �s ��r
�s 
kocl � m    �q
�q 
reco�r  �x  �w   � m    �p�p  � k   W � �  � � � r    P � � � n   N � � � I   $ N�o �n�o 60 asoptionalrecordparameter asOptionalRecordParameter   o   $ %�m�m 0 formatstyle formatStyle  K   % G �l
�l 
pcls l  & '�k�j m   & '�i
�i 
MthR�k  �j   �h	

�h 
MthA	 n  ( / o   - /�g�g 0 requiredvalue RequiredValue o   ( -�f�f 0 _support  
 �e
�e 
MthB m   0 1�d
�d 
msng �c
�c 
MthC m   2 3�b
�b 
msng �a
�a 
MthD m   4 5�`
�` 
msng �_
�_ 
MthE m   6 7�^
�^ 
msng �]
�] 
MthF m   : ;�\
�\ 
msng �[
�[ 
MthG m   > ?�Z
�Z 
msng �Y�X
�Y 
MthH m   B C�W
�W 
msng�X   �V m   G J � 
 u s i n g�V  �n   � o    $�U�U 0 _support   � o      �T�T 0 formatrecord formatRecord �  I   Q [�S�R�S "0 _setbasicformat _setBasicFormat  !  o   R S�Q�Q 0 asocformatter asocFormatter! "#" n  S V$%$ 1   T V�P
�P 
MthA% o   S T�O�O 0 formatrecord formatRecord# &�N& o   V W�M�M 0 	thenumber 	theNumber�N  �R   '(' Z   \ �)*�L�K) >  \ a+,+ n  \ _-.- 1   ] _�J
�J 
MthB. o   \ ]�I�I 0 formatrecord formatRecord, m   _ `�H
�H 
msng* k   d ~// 010 n  d u232 I   e u�G4�F�G 60 setminimumfractiondigits_ setMinimumFractionDigits_4 5�E5 I   e q�D6�C�D (0 _asintegerproperty _asIntegerProperty6 787 n  f i9:9 1   g i�B
�B 
MthB: o   f g�A�A 0 formatrecord formatRecord8 ;<; m   i l== �>> , m i n i m u m   d e c i m a l   p l a c e s< ?�@? m   l m�?�?  �@  �C  �E  �F  3 o   d e�>�> 0 asocformatter asocFormatter1 @�=@ l  v ~ABCA n  v ~DED I   w ~�<F�;�< 60 setmaximumfractiondigits_ setMaximumFractionDigits_F G�:G m   w z�9�9��:  �;  E o   v w�8�8 0 asocformatter asocFormatterB L F kludge for NSNumberFormatterBug; see notes in _setBasicFormat() below   C �HH �   k l u d g e   f o r   N S N u m b e r F o r m a t t e r B u g ;   s e e   n o t e s   i n   _ s e t B a s i c F o r m a t ( )   b e l o w�=  �L  �K  ( IJI Z   � �KL�7�6K >  � �MNM n  � �OPO 1   � ��5
�5 
MthCP o   � ��4�4 0 formatrecord formatRecordN m   � ��3
�3 
msngL n  � �QRQ I   � ��2S�1�2 60 setmaximumfractiondigits_ setMaximumFractionDigits_S T�0T I   � ��/U�.�/ (0 _asintegerproperty _asIntegerPropertyU VWV n  � �XYX 1   � ��-
�- 
MthCY o   � ��,�, 0 formatrecord formatRecordW Z[Z m   � �\\ �]] , m a x i m u m   d e c i m a l   p l a c e s[ ^�+^ m   � ��*�*  �+  �.  �0  �1  R o   � ��)�) 0 asocformatter asocFormatter�7  �6  J _`_ Z   � �ab�(�'a >  � �cdc n  � �efe 1   � ��&
�& 
MthDf o   � ��%�% 0 formatrecord formatRecordd m   � ��$
�$ 
msngb k   � �gg hih n  � �jkj I   � ��#l�"�# <0 setminimumsignificantdigits_ setMinimumSignificantDigits_l m�!m I   � �� n��  (0 _asintegerproperty _asIntegerPropertyn opo n  � �qrq 1   � ��
� 
MthDr o   � ��� 0 formatrecord formatRecordp sts m   � �uu �vv 4 m i n i m u m   s i g n i f i c a n t   d i g i t st w�w m   � ���  �  �  �!  �"  k o   � ��� 0 asocformatter asocFormatteri x�x n  � �yzy I   � ��{�� 60 setusessignificantdigits_ setUsesSignificantDigits_{ |�| m   � ��
� boovtrue�  �  z o   � ��� 0 asocformatter asocFormatter�  �(  �'  ` }~} Z   � ���� >  � ���� n  � ���� 1   � ��
� 
MthE� o   � ��� 0 formatrecord formatRecord� m   � ��
� 
msng� k   � ��� ��� n  � ���� I   � ����� <0 setmaximumsignificantdigits_ setMaximumSignificantDigits_� ��� I   � ����
� (0 _asintegerproperty _asIntegerProperty� ��� n  � ���� 1   � ��	
�	 
MthE� o   � ��� 0 formatrecord formatRecord� ��� m   � ��� ��� 4 m a x i m u m   s i g n i f i c a n t   d i g i t s� ��� m   � ���  �  �
  �  �  � o   � ��� 0 asocformatter asocFormatter� ��� n  � ���� I   � ����� 60 setusessignificantdigits_ setUsesSignificantDigits_� ��� m   � �� 
�  boovtrue�  �  � o   � ����� 0 asocformatter asocFormatter�  �  �  ~ ��� Z   �;������� >  � ���� n  � ���� 1   � ���
�� 
MthF� o   � ����� 0 formatrecord formatRecord� m   � ���
�� 
msng� Q   �7���� k   �#�� ��� r   ���� c   ���� n  � ���� 1   � ���
�� 
MthF� o   � ����� 0 formatrecord formatRecord� m   � ��
�� 
ctxt� o      ���� 0 s  � ��� Z ������� =  ��� n 	��� 1  	��
�� 
leng� o  ���� 0 s  � m  	
����  � R  �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� m  �����Y��  ��  ��  � ���� n #��� I  #������� ,0 setdecimalseparator_ setDecimalSeparator_� ���� o  ���� 0 s  ��  ��  � o  ���� 0 asocformatter asocFormatter��  � R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � R  +7����
�� .ascrerr ****      � ****� m  36�� ��� �  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    d e c i m a l   s e p a r a t o r    p r o p e r t y   i s   n o t   n o n - e m p t y   t e x t� �����
�� 
errn� m  /2�����Y��  ��  ��  � ��� Z  <�������� > <C��� n <A��� 1  =A��
�� 
MthG� o  <=���� 0 formatrecord formatRecord� m  AB��
�� 
msng� Q  F����� k  Iu�� ��� r  IT��� c  IR��� n IN��� 1  JN��
�� 
MthG� o  IJ���� 0 formatrecord formatRecord� m  NQ��
�� 
ctxt� o      ���� 0 s  � ���� Z  Uu������ =  U\��� n UZ��� 1  VZ��
�� 
leng� o  UV���� 0 s  � m  Z[����  � n _e��� I  `e������� 60 setusesgroupingseparator_ setUsesGroupingSeparator_� ���� m  `a��
�� boovfals��  ��  � o  _`���� 0 asocformatter asocFormatter��  � k  hu�� ��� n hn��� I  in������� 60 setusesgroupingseparator_ setUsesGroupingSeparator_� ���� m  ij��
�� boovtrue��  ��  � o  hi���� 0 asocformatter asocFormatter� ���� n ou��� I  pu������� .0 setgroupingseparator_ setGroupingSeparator_� ���� o  pq���� 0 s  ��  ��  � o  op���� 0 asocformatter asocFormatter��  ��  � R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � R  }�����
�� .ascrerr ****      � ****� m  ���� ��� �  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    g r o u p i n g   s e p a r a t o r    p r o p e r t y   i s   n o t   t e x t� �����
�� 
errn� m  �������Y��  ��  ��  � ���� Z  �W������� > ����� n ��� � 1  ����
�� 
MthH  o  ������ 0 formatrecord formatRecord� m  ����
�� 
msng� Z  �S = �� n �� 1  ����
�� 
MthH o  ������ 0 formatrecord formatRecord l ��	����	 m  ����
�� MRndRNhE��  ��   n ��

 I  �������� $0 setroundingmode_ setRoundingMode_ �� l ������ n �� o  ������ @0 nsnumberformatterroundhalfeven NSNumberFormatterRoundHalfEven m  ����
�� misccura��  ��  ��  ��   o  ������ 0 asocformatter asocFormatter  = �� n �� 1  ����
�� 
MthH o  ������ 0 formatrecord formatRecord l ������ m  ����
�� MRndRNhT��  ��    n �� I  �������� $0 setroundingmode_ setRoundingMode_ �� l ������ n ��  o  ������ @0 nsnumberformatterroundhalfdown NSNumberFormatterRoundHalfDown  m  ����
�� misccura��  ��  ��  ��   o  ������ 0 asocformatter asocFormatter !"! = ��#$# n ��%&% 1  ����
�� 
MthH& o  ������ 0 formatrecord formatRecord$ l ��'����' m  ����
�� MRndRNhF��  ��  " ()( n ��*+* I  ����,���� $0 setroundingmode_ setRoundingMode_, -��- l ��.����. n ��/0/ o  ������ <0 nsnumberformatterroundhalfup NSNumberFormatterRoundHalfUp0 m  ����
�� misccura��  ��  ��  ��  + o  ������ 0 asocformatter asocFormatter) 121 = ��343 n ��565 1  ����
�� 
MthH6 o  ������ 0 formatrecord formatRecord4 l ��7����7 m  ����
�� MRndRN_T��  ��  2 898 n ��:;: I  ����<���� $0 setroundingmode_ setRoundingMode_< =��= l ��>���> n ��?@? o  ���~�~ 80 nsnumberformatterrounddown NSNumberFormatterRoundDown@ m  ���}
�} misccura��  �  ��  ��  ; o  ���|�| 0 asocformatter asocFormatter9 ABA = �CDC n �EFE 1  ��{
�{ 
MthHF o  ���z�z 0 formatrecord formatRecordD l G�y�xG m  �w
�w MRndRN_F�y  �x  B HIH n JKJ I  	�vL�u�v $0 setroundingmode_ setRoundingMode_L M�tM l 	N�s�rN n 	OPO o  
�q�q 40 nsnumberformatterroundup NSNumberFormatterRoundUpP m  	
�p
�p misccura�s  �r  �t  �u  K o  	�o�o 0 asocformatter asocFormatterI QRQ = STS n UVU 1  �n
�n 
MthHV o  �m�m 0 formatrecord formatRecordT l W�l�kW m  �j
�j MRndRN_U�l  �k  R XYX n !+Z[Z I  "+�i\�h�i $0 setroundingmode_ setRoundingMode_\ ]�g] l "'^�f�e^ n "'_`_ o  #'�d�d >0 nsnumberformatterroundceiling NSNumberFormatterRoundCeiling` m  "#�c
�c misccura�f  �e  �g  �h  [ o  !"�b�b 0 asocformatter asocFormatterY aba = .7cdc n .3efe 1  /3�a
�a 
MthHf o  ./�`�` 0 formatrecord formatRecordd l 36g�_�^g m  36�]
�] MRndRN_D�_  �^  b h�\h n :Diji I  ;D�[k�Z�[ $0 setroundingmode_ setRoundingMode_k l�Yl l ;@m�X�Wm n ;@non o  <@�V�V :0 nsnumberformatterroundfloor NSNumberFormatterRoundFlooro m  ;<�U
�U misccura�X  �W  �Y  �Z  j o  :;�T�T 0 asocformatter asocFormatter�\   R  GS�Spq
�S .ascrerr ****      � ****p m  ORrr �ss �  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    r o u n d i n g   b e h a v i o r    i s   n o t   a n   a l l o w e d   c o n s t a n tq �Rt�Q
�R 
errnt m  KN�P�P�Y�Q  ��  ��  ��  �y   � Q  Zsuvwu I  ]e�Ox�N�O "0 _setbasicformat _setBasicFormatx yzy o  ^_�M�M 0 asocformatter asocFormatterz {|{ o  _`�L�L 0 formatstyle formatStyle| }�K} o  `a�J�J 0 	thenumber 	theNumber�K  �N  v R      �I�H~
�I .ascrerr ****      � ****�H  ~ �G�F
�G 
errn d      �� m      �E�E��F  w R  ms�D��C
�D .ascrerr ****      � ****� m  or�� ��� | n o t   a    n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d   o r   a n   a l l o w e d   c o n s t a n t�C   � R      �B��
�B .ascrerr ****      � ****� o      �A�A 0 etext eText� �@��?
�@ 
errn� d      �� m      �>�>��?   � n {���� I  ���=��<�= .0 throwinvalidparameter throwInvalidParameter� ��� o  ���;�; 0 formatstyle formatStyle� ��� m  ���� ��� 
 u s i n g� ��� J  ���� ��� m  ���:
�: 
reco� ��9� m  ���8
�8 
enum�9  � ��7� o  ���6�6 0 etext eText�7  �<  � o  {��5�5 0 _support   � ��� n ����� I  ���4��3�4 0 
setlocale_ 
setLocale_� ��2� l ����1�0� n ����� I  ���/��.�/ *0 asnslocaleparameter asNSLocaleParameter� ��� o  ���-�- 0 
localecode 
localeCode� ��,� m  ���� ���  f o r   l o c a l e�,  �.  � o  ���+�+ 0 _support  �1  �0  �2  �3  � o  ���*�* 0 asocformatter asocFormatter� ��)� L  ���� o  ���(�( 0 asocformatter asocFormatter�)   � � � theNumber is either the number being formatted or `missing value` when parsing; determines appropriate formatting style based on number's type and value when `native format` is specified    � ���v   t h e N u m b e r   i s   e i t h e r   t h e   n u m b e r   b e i n g   f o r m a t t e d   o r   ` m i s s i n g   v a l u e `   w h e n   p a r s i n g ;   d e t e r m i n e s   a p p r o p r i a t e   f o r m a t t i n g   s t y l e   b a s e d   o n   n u m b e r ' s   t y p e   a n d   v a l u e   w h e n   ` n a t i v e   f o r m a t `   i s   s p e c i f i e d � ��� l     �'�&�%�'  �&  �%  � ��� l     �$�#�"�$  �#  �"  � ��� i  6 9��� I      �!�� �! "0 _setbasicformat _setBasicFormat� ��� o      �� 0 asocformatter asocFormatter� ��� o      �� 0 
formatname 
formatName� ��� o      �� 0 	thenumber 	theNumber�  �   � Z    R����� =    ��� o     �� 0 
formatname 
formatName� m    �
� MthZMth0� Z    ������ =   	��� o    �� 0 	thenumber 	theNumber� m    �
� 
msng� l   ���� n   ��� I    ���� "0 setnumberstyle_ setNumberStyle_� ��� l   ���� n   ��� o    �� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� m    �
� misccura�  �  �  �  � o    �� 0 asocformatter asocFormatter� ? 9 parsing always recognizes scientific notation by default   � ��� r   p a r s i n g   a l w a y s   r e c o g n i z e s   s c i e n t i f i c   n o t a t i o n   b y   d e f a u l t�  � l   ����� Z    ������ =   ��� n   ��� m    �
� 
pcls� o    �� 0 	thenumber 	theNumber� m    �
� 
long� l   '���� n   '��� I     '���
� "0 setnumberstyle_ setNumberStyle_� ��	� l    #���� n    #��� o   ! #�� 40 nsnumberformatternostyle NSNumberFormatterNoStyle� m     !�
� misccura�  �  �	  �
  � o     �� 0 asocformatter asocFormatter�   format integer   � ���    f o r m a t   i n t e g e r� ��� G   * _��� G   * W��� l 
 * ?���� l  * ?��� � F   * ?��� A   * 2��� d   * 0�� o   * /���� $0 _maxdecimalrange _maxDecimalRange� o   0 1���� 0 	thenumber 	theNumber� A   5 =��� o   5 6���� 0 	thenumber 	theNumber� d   6 <�� o   6 ;���� $0 _mindecimalrange _minDecimalRange�  �   �  �  � l 
 B U������ l  B U������ F   B U��� A   B I��� o   B G���� $0 _mindecimalrange _minDecimalRange� o   G H���� 0 	thenumber 	theNumber� A   L S��� o   L M���� 0 	thenumber 	theNumber� o   M R���� $0 _maxdecimalrange _maxDecimalRange��  ��  ��  ��  � =   Z ]��� o   Z [���� 0 	thenumber 	theNumber� m   [ \����  � ���� l  b �� � k   b �  l  b b����   Y S use {basic format:decimal format, minimum decimal places:1, grouping separator:""}    � �   u s e   { b a s i c   f o r m a t : d e c i m a l   f o r m a t ,   m i n i m u m   d e c i m a l   p l a c e s : 1 ,   g r o u p i n g   s e p a r a t o r : " " } 	 n  b j

 I   c j������ "0 setnumberstyle_ setNumberStyle_ �� l  c f���� n  c f o   d f���� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle m   c d��
�� misccura��  ��  ��  ��   o   b c���� 0 asocformatter asocFormatter	  n  k q I   l q������ 60 setminimumfractiondigits_ setMinimumFractionDigits_ �� m   l m���� ��  ��   o   k l���� 0 asocformatter asocFormatter  n  r x I   s x������ 60 setmaximumfractiondigits_ setMaximumFractionDigits_ �� m   s t�������  ��   o   r s���� 0 asocformatter asocFormatter  n  y   I   z ��!���� 60 setusesgroupingseparator_ setUsesGroupingSeparator_! "��" m   z {��
�� boovfals��  ��    o   y z���� 0 asocformatter asocFormatter #��# n  � �$%$ I   � ���&���� B0 setalwaysshowsdecimalseparator_ setAlwaysShowsDecimalSeparator_& '��' m   � ���
�� boovtrue��  ��  % o   � ����� 0 asocformatter asocFormatter��      format real as decimal    �(( .   f o r m a t   r e a l   a s   d e c i m a l��  � l  � �)*+) k   � �,, -.- n  � �/0/ I   � ���1���� "0 setnumberstyle_ setNumberStyle_1 2��2 l  � �3����3 n  � �454 o   � ����� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle5 m   � ���
�� misccura��  ��  ��  ��  0 o   � ����� 0 asocformatter asocFormatter. 676 l  � ���89��  8 S M for consistency with AS, always include minimum 1DP, e.g. "1.0E8", not "1E8"   9 �:: �   f o r   c o n s i s t e n c y   w i t h   A S ,   a l w a y s   i n c l u d e   m i n i m u m   1 D P ,   e . g .   " 1 . 0 E 8 " ,   n o t   " 1 E 8 "7 ;<; l  � ���=>��  =	 note: for some reason `setAlwaysShowsDecimalSeparator:true` is ignored, while `setMinimumFractionDigits:1` causes number to be truncated (note: maximum seems to change as well as minimum, which is wrong) unless maximum is reset afterwards (NSNumberFormatter bugs?)   > �??   n o t e :   f o r   s o m e   r e a s o n   ` s e t A l w a y s S h o w s D e c i m a l S e p a r a t o r : t r u e `   i s   i g n o r e d ,   w h i l e   ` s e t M i n i m u m F r a c t i o n D i g i t s : 1 `   c a u s e s   n u m b e r   t o   b e   t r u n c a t e d   ( n o t e :   m a x i m u m   s e e m s   t o   c h a n g e   a s   w e l l   a s   m i n i m u m ,   w h i c h   i s   w r o n g )   u n l e s s   m a x i m u m   i s   r e s e t   a f t e r w a r d s   ( N S N u m b e r F o r m a t t e r   b u g s ? )< @A@ n  � �BCB I   � ���D���� 60 setminimumfractiondigits_ setMinimumFractionDigits_D E��E m   � ����� ��  ��  C o   � ����� 0 asocformatter asocFormatterA FGF n  � �HIH I   � ���J���� 60 setmaximumfractiondigits_ setMaximumFractionDigits_J K��K m   � ��������  ��  I o   � ����� 0 asocformatter asocFormatterG L��L n  � �MNM I   � ���O���� B0 setalwaysshowsdecimalseparator_ setAlwaysShowsDecimalSeparator_O P��P m   � ���
�� boovtrue��  ��  N o   � ����� 0 asocformatter asocFormatter��  *    format real as scientific   + �QQ 4   f o r m a t   r e a l   a s   s c i e n t i f i c� Q K formatting switches between notations depending on number's type and value   � �RR �   f o r m a t t i n g   s w i t c h e s   b e t w e e n   n o t a t i o n s   d e p e n d i n g   o n   n u m b e r ' s   t y p e   a n d   v a l u e� STS =  � �UVU o   � ����� 0 
formatname 
formatNameV m   � ���
�� MthZMth3T WXW l  � �YZ[Y n  � �\]\ I   � ���^���� "0 setnumberstyle_ setNumberStyle_^ _��_ l  � �`����` n  � �aba o   � ����� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyleb m   � ���
�� misccura��  ��  ��  ��  ] o   � ����� 0 asocformatter asocFormatterZ   uses exponent notation   [ �cc .   u s e s   e x p o n e n t   n o t a t i o nX ded =  � �fgf o   � ����� 0 
formatname 
formatNameg m   � ���
�� MthZMth1e hih l  � �jklj n  � �mnm I   � ���o���� "0 setnumberstyle_ setNumberStyle_o p��p l  � �q����q n  � �rsr o   � ����� 40 nsnumberformatternostyle NSNumberFormatterNoStyles m   � ���
�� misccura��  ��  ��  ��  n o   � ����� 0 asocformatter asocFormatterk n h uses plain integer notation (caution: do not use for reals unless rounding to whole number is intended)   l �tt �   u s e s   p l a i n   i n t e g e r   n o t a t i o n   ( c a u t i o n :   d o   n o t   u s e   f o r   r e a l s   u n l e s s   r o u n d i n g   t o   w h o l e   n u m b e r   i s   i n t e n d e d )i uvu =  � �wxw o   � ����� 0 
formatname 
formatNamex m   � ���
�� MthZMth2v yzy l  � �{|}{ n  � �~~ I   � �������� "0 setnumberstyle_ setNumberStyle_� ���� l  � ������� n  � ���� o   � ����� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle� m   � ���
�� misccura��  ��  ��  ��   o   � ����� 0 asocformatter asocFormatter| 8 2 uses thousands separators by default, no exponent   } ��� d   u s e s   t h o u s a n d s   s e p a r a t o r s   b y   d e f a u l t ,   n o   e x p o n e n tz ��� =  � ���� o   � ����� 0 
formatname 
formatName� m   � ���
�� MthZMth5� ��� l  � ����� n  � ���� I   � �������� "0 setnumberstyle_ setNumberStyle_� ���� l  � ������� n  � ���� o   � ����� @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle� m   � ���
�� misccura��  ��  ��  ��  � o   � ����� 0 asocformatter asocFormatter�   adds currency symbol   � ��� *   a d d s   c u r r e n c y   s y m b o l� ��� =  � ���� o   � ����� 0 
formatname 
formatName� m   � ���
�� MthZMth4� ��� l  ����� n  ���� I   �������� "0 setnumberstyle_ setNumberStyle_� ���� l  ������� n  ���� o   ����� >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle� m   � ���
�� misccura��  ��  ��  ��  � o   � ����� 0 asocformatter asocFormatter� ( " multiplies by 100 and appends '%'   � ��� D   m u l t i p l i e s   b y   1 0 0   a n d   a p p e n d s   ' % '� ��� = 
��� o  
���� 0 
formatname 
formatName� m  ��
�� MthZMth6� ��� l ���� n ��� I  ������� "0 setnumberstyle_ setNumberStyle_� ���� l ������ n ��� o  �� @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle� m  �~
�~ misccura��  ��  ��  ��  � o  �}�} 0 asocformatter asocFormatter�   uses words   � ���    u s e s   w o r d s� ��� >  .��� l ,��|�{� I ,�z��
�z .corecnte****       ****� J  "�� ��y� o   �x�x 0 
formatname 
formatName�y  � �w��v
�w 
kocl� m  %(�u
�u 
ctxt�v  �|  �{  � m  ,-�t�t  � ��s� n 17��� I  27�r��q�r 0 
setformat_ 
setFormat_� ��p� o  23�o�o 0 
formatname 
formatName�p  �q  � o  12�n�n 0 asocformatter asocFormatter�s  � R  :R�m��
�m .ascrerr ****      � ****� m  NQ�� ��� p i n v a l i d    b a s i c   f o r m a t    p r o p e r t y :   n o t   a n   a l l o w e d   c o n s t a n t� �l��
�l 
errn� m  >A�k�k�Y� �j��
�j 
erob� o  DE�i�i 0 
formatname 
formatName� �h��g
�h 
errt� m  HK�f
�f 
enum�g  � ��� l     �e�d�c�e  �d  �c  � ��� l     �b�a�`�b  �a  �`  � ��� i  : =��� I      �_��^�_  0 _nameforformat _nameForFormat� ��]� o      �\�\ 0 formatstyle formatStyle�]  �^  � l    H���� Z     H����� =    ��� o     �[�[ 0 formatstyle formatStyle� m    �Z
�Z MthZMth1� L    �� m    �� ���  i n t e g e r� ��� =   ��� o    �Y�Y 0 formatstyle formatStyle� m    �X
�X MthZMth2� ��� L    �� m    �� ���  d e c i m a l� ��� =   ��� o    �W�W 0 formatstyle formatStyle� m    �V
�V MthZMth5� ��� L    �� m    �� ���  c u r r e n c y� ��� =  ! $��� o   ! "�U�U 0 formatstyle formatStyle� m   " #�T
�T MthZMth4� ��� L   ' )�� m   ' (   �  p e r c e n t�  =  , / o   , -�S�S 0 formatstyle formatStyle m   - .�R
�R MthZMth3  L   2 4 m   2 3		 �

  s c i e n t i f i c  =  7 : o   7 8�Q�Q 0 formatstyle formatStyle m   8 9�P
�P MthZMth6 �O L   = ? m   = > �  w o r d�O  � L   B H b   B G b   B E m   B C �   o   C D�N�N 0 formatstyle formatStyle m   E F �  � G A used for error reporting; formatStyle is either constant or text   � � �   u s e d   f o r   e r r o r   r e p o r t i n g ;   f o r m a t S t y l e   i s   e i t h e r   c o n s t a n t   o r   t e x t�  l     �M�L�K�M  �L  �K     l     �J�I�H�J  �I  �H    !"! l     �G#$�G  #  -----   $ �%% 
 - - - - -" &'& l     �F�E�D�F  �E  �D  ' ()( i  > A*+* I     �C,-
�C .Mth:FNumnull���     nmbr, o      �B�B 0 	thenumber 	theNumber- �A./
�A 
Usin. |�@�?0�>1�@  �?  0 o      �=�= 0 formatstyle formatStyle�>  1 l     2�<�;2 m      �:
�: MthZMth0�<  �;  / �93�8
�9 
Loca3 |�7�64�55�7  �6  4 o      �4�4 0 
localecode 
localeCode�5  5 l     6�3�26 m      77 �88  n o n e�3  �2  �8  + Q     d9:;9 k    N<< =>= l   "?@A? Z   "BC�1�0B =    DED l   F�/�.F I   �-GH
�- .corecnte****       ****G J    II J�,J o    �+�+ 0 	thenumber 	theNumber�,  H �*K�)
�* 
koclK m    �(
�( 
nmbr�)  �/  �.  E m    �'�'  C n   LML I    �&N�%�& 60 throwinvalidparametertype throwInvalidParameterTypeN OPO o    �$�$ 0 	thenumber 	theNumberP QRQ m    SS �TT  R UVU m    �#
�# 
nmbrV W�"W m    XX �YY  n u m b e r�"  �%  M o    �!�! 0 _support  �1  �0  @ � � only accept integer or real types (i.e. allowing a text parameter to be coerced to number would defeat the purpose of these handlers, which is to avoid unintended localization behavior)   A �ZZt   o n l y   a c c e p t   i n t e g e r   o r   r e a l   t y p e s   ( i . e .   a l l o w i n g   a   t e x t   p a r a m e t e r   t o   b e   c o e r c e d   t o   n u m b e r   w o u l d   d e f e a t   t h e   p u r p o s e   o f   t h e s e   h a n d l e r s ,   w h i c h   i s   t o   a v o i d   u n i n t e n d e d   l o c a l i z a t i o n   b e h a v i o r )> [\[ r   # -]^] I   # +� _��  ,0 _makenumberformatter _makeNumberFormatter_ `a` o   $ %�� 0 formatstyle formatStylea bcb o   % &�� 0 
localecode 
localeCodec d�d o   & '�� 0 	thenumber 	theNumber�  �  ^ o      �� 0 asocformatter asocFormatter\ efe r   . 6ghg n  . 4iji I   / 4�k�� &0 stringfromnumber_ stringFromNumber_k l�l o   / 0�� 0 	thenumber 	theNumber�  �  j o   . /�� 0 asocformatter asocFormatterh o      �� 0 
asocstring 
asocStringf mnm l  7 Iopqo Z  7 Irs��r =  7 :tut o   7 8�� 0 
asocstring 
asocStringu m   8 9�
� 
msngs R   = E�vw
� .ascrerr ****      � ****v m   C Dxx �yy F I n v a l i d   n u m b e r   ( c o n v e r s i o n   f a i l e d ) .w �z{
� 
errnz m   ? @���Y{ �|�
� 
erob| o   A B�
�
 0 	thenumber 	theNumber�  �  �  p n h shouldn't fail, but -stringFromNumber:'s return type isn't declared as non-nullable so check to be sure   q �}} �   s h o u l d n ' t   f a i l ,   b u t   - s t r i n g F r o m N u m b e r : ' s   r e t u r n   t y p e   i s n ' t   d e c l a r e d   a s   n o n - n u l l a b l e   s o   c h e c k   t o   b e   s u r en ~�	~ L   J N c   J M��� o   J K�� 0 
asocstring 
asocString� m   K L�
� 
ctxt�	  : R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� � ���
�  
errt� o      ���� 
0 eto eTo��  ; I   V d������� 
0 _error  � ��� m   W Z�� ���  f o r m a t   n u m b e r� ��� o   Z [���� 0 etext eText� ��� o   [ \���� 0 enumber eNumber� ��� o   \ ]���� 0 efrom eFrom� ���� o   ] ^���� 
0 eto eTo��  ��  ) ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  B E��� I     ����
�� .Mth:PNumnull���     ctxt� o      ���� 0 thetext theText� ����
�� 
Usin� |����������  ��  � o      ���� 0 formatstyle formatStyle��  � l     ������ m      ��
�� MthZMth0��  ��  � �����
�� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � l     ������ m      �� ���  n o n e��  ��  ��  � Q     ����� k    ��� ��� l   "���� Z   "������� =    ��� l   ������ I   ����
�� .corecnte****       ****� J    �� ���� o    ���� 0 thetext theText��  � �����
�� 
kocl� m    ��
�� 
ctxt��  ��  ��  � m    ����  � n   ��� I    ������� 60 throwinvalidparametertype throwInvalidParameterType� ��� o    ���� 0 thetext theText� ��� m    �� ���  � ��� m    ��
�� 
ctxt� ���� m    �� ���  t e x t��  ��  � o    ���� 0 _support  ��  ��  � 1 + only accept text, for same reason as above   � ��� V   o n l y   a c c e p t   t e x t ,   f o r   s a m e   r e a s o n   a s   a b o v e� ��� r   # -��� I   # +������� ,0 _makenumberformatter _makeNumberFormatter� ��� o   $ %���� 0 formatstyle formatStyle� ��� o   % &���� 0 
localecode 
localeCode� ���� m   & '��
�� 
msng��  ��  � o      ���� 0 asocformatter asocFormatter� ��� r   . 6��� n  . 4��� I   / 4������� &0 numberfromstring_ numberFromString_� ���� o   / 0���� 0 thetext theText��  ��  � o   . /���� 0 asocformatter asocFormatter� o      ���� 0 
asocnumber 
asocNumber� ��� Z   7 �������� =  7 :��� o   7 8���� 0 
asocnumber 
asocNumber� m   8 9��
�� 
msng� k   = ��� ��� r   = J��� c   = H��� n  = F��� I   B F�������� $0 localeidentifier localeIdentifier��  ��  � n  = B��� I   > B�������� 
0 locale  ��  ��  � o   = >���� 0 asocformatter asocFormatter� m   F G��
�� 
ctxt� o      ���� $0 localeidentifier localeIdentifier� ��� Z   K `������ =   K P��� n  K N��� 1   L N��
�� 
leng� o   K L���� $0 localeidentifier localeIdentifier� m   N O����  � l  S V���� r   S V��� m   S T�� ���  n o� o      ���� $0 localeidentifier localeIdentifier� #  empty string = system locale   � ��� :   e m p t y   s t r i n g   =   s y s t e m   l o c a l e��  � r   Y `   b   Y ^ b   Y \ m   Y Z � 
 t h e    o   Z [���� $0 localeidentifier localeIdentifier m   \ ] �		   o      ���� $0 localeidentifier localeIdentifier� 
��
 R   a ���
�� .ascrerr ****      � **** l  m ����� b   m � b   m } b   m { b   m w m   m p � R I n v a l i d   t e x t   ( e x p e c t e d   n u m e r i c a l   t e x t   i n   I   p v������  0 _nameforformat _nameForFormat �� o   q r���� 0 formatstyle formatStyle��  ��   m   w z �    f o r m a t   f o r   o   { |���� $0 localeidentifier localeIdentifier m   } � �    l o c a l e ) .��  ��   ��
�� 
errn m   e h�����Y �� ��
�� 
erob  o   k l���� 0 thetext theText��  ��  ��  ��  � !��! L   � �"" c   � �#$# o   � ����� 0 
asocnumber 
asocNumber$ m   � ���
�� 
****��  � R      ��%&
�� .ascrerr ****      � ****% o      ���� 0 etext eText& ��'(
�� 
errn' o      ���� 0 enumber eNumber( ��)*
�� 
erob) o      ���� 0 efrom eFrom* ��+��
�� 
errt+ o      ���� 
0 eto eTo��  � I   � ���,���� 
0 _error  , -.- m   � �// �00  p a r s e   n u m b e r. 121 o   � ����� 0 etext eText2 343 o   � ����� 0 enumber eNumber4 565 o   � ����� 0 efrom eFrom6 7��7 o   � ����� 
0 eto eTo��  ��  � 898 l     ��������  ��  ��  9 :;: l     ��������  ��  ��  ; <=< l     ��>?��  > J D--------------------------------------------------------------------   ? �@@ � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -= ABA l     ��CD��  C $  Hexadecimal number conversion   D �EE <   H e x a d e c i m a l   n u m b e r   c o n v e r s i o nB FGF l     ��������  ��  ��  G HIH i  F IJKJ I     ��LM
�� .Mth:NuHenull���     ****L o      �� 0 	thenumber 	theNumberM �~NO
�~ 
PlacN |�}�|P�{Q�}  �|  P o      �z�z 0 	chunksize 	chunkSize�{  Q l     R�y�xR m      �w�w  �y  �x  O �vS�u
�v 
PrefS |�t�sT�rU�t  �s  T o      �q�q 0 	hasprefix 	hasPrefix�r  U l     V�p�oV m      �n
�n boovfals�p  �o  �u  K Q    �WXYW k   �ZZ [\[ r    ]^] n   _`_ I    �ma�l�m (0 asintegerparameter asIntegerParametera bcb o    	�k�k 0 	chunksize 	chunkSizec d�jd m   	 
ee �ff 
 w i d t h�j  �l  ` o    �i�i 0 _support  ^ o      �h�h 0 	chunksize 	chunkSize\ ghg l   ijki r    lml n   non I    �gp�f�g (0 asbooleanparameter asBooleanParameterp qrq o    �e�e 0 	hasprefix 	hasPrefixr s�ds m    tt �uu  p r e f i x�d  �f  o o    �c�c 0 _support  m o      �b�b 0 	hasprefix 	hasPrefixj � � (users shouldn't concatenate their own prefix as that would result in negative numbers appearing as "0x-N�" instead of "-0xN�")   k �vv    ( u s e r s   s h o u l d n ' t   c o n c a t e n a t e   t h e i r   o w n   p r e f i x   a s   t h a t   w o u l d   r e s u l t   i n   n e g a t i v e   n u m b e r s   a p p e a r i n g   a s   " 0 x - N & "   i n s t e a d   o f   " - 0 x N & " )h w�aw Z   �xy�`zx =    *{|{ l   (}�_�^} I   (�]~
�] .corecnte****       ****~ J    "�� ��\� o     �[�[ 0 	thenumber 	theNumber�\   �Z��Y
�Z 
kocl� m   # $�X
�X 
list�Y  �_  �^  | m   ( )�W�W  y l  -E���� k   -E�� ��� l  - :���� r   - :��� n  - 8��� I   2 8�V��U�V 00 aswholenumberparameter asWholeNumberParameter� ��� o   2 3�T�T 0 	thenumber 	theNumber� ��S� m   3 4�� ���  �S  �U  � o   - 2�R�R 0 _support  � o      �Q�Q 0 	thenumber 	theNumber� ^ X numbers greater than 2^30 (max integer size) are okay as long as they're non-fractional   � ��� �   n u m b e r s   g r e a t e r   t h a n   2 ^ 3 0   ( m a x   i n t e g e r   s i z e )   a r e   o k a y   a s   l o n g   a s   t h e y ' r e   n o n - f r a c t i o n a l� ��� l  ; ;�P���P  � � � note that the 1024 max chunk size is somewhat arbitrary (the largest representable number requires ~309 chars; anything more will always be left-hand padding), but prevents completely silly values   � ����   n o t e   t h a t   t h e   1 0 2 4   m a x   c h u n k   s i z e   i s   s o m e w h a t   a r b i t r a r y   ( t h e   l a r g e s t   r e p r e s e n t a b l e   n u m b e r   r e q u i r e s   ~ 3 0 9   c h a r s ;   a n y t h i n g   m o r e   w i l l   a l w a y s   b e   l e f t - h a n d   p a d d i n g ) ,   b u t   p r e v e n t s   c o m p l e t e l y   s i l l y   v a l u e s� ��� Z  ; Z���O�N� G   ; F��� A   ; >��� o   ; <�M�M 0 	chunksize 	chunkSize� m   < =�L�L  � ?   A D��� o   A B�K�K 0 	chunksize 	chunkSize� m   B C�J�J � n  I V��� I   N V�I��H�I .0 throwinvalidparameter throwInvalidParameter� ��� o   N O�G�G 0 	chunksize 	chunkSize� ��� m   O P�� ��� 
 w i d t h� ��� m   P Q�F
�F 
long� ��E� m   Q R�� ���  m u s t   b e   0  1 0 2 4�E  �H  � o   I N�D�D 0 _support  �O  �N  � ��� r   [ `��� m   [ ^�� ���  � o      �C�C 0 hextext hexText� ��� Z   a ����B�� A   a d��� o   a b�A�A 0 	thenumber 	theNumber� m   b c�@�@  � k   g ��� ��� Z  g ����?�>� F   g v��� ?   g j��� o   g h�=�= 0 	chunksize 	chunkSize� m   h i�<�<  � l  m t��;�:� A   m t��� o   m n�9�9 0 	thenumber 	theNumber� a   n s��� m   n q�8�8��� o   q r�7�7 0 	chunksize 	chunkSize�;  �:  � n  y ���� I   ~ ��6��5�6 .0 throwinvalidparameter throwInvalidParameter� ��� o   ~ �4�4 0 	thenumber 	theNumber� ��� m    ��� ���  � ��� m   � ��3
�3 
long� ��2� b   � ���� b   � ���� b   � ���� m   � ��� ��� X s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n  � l  � ���1�0� a   � ���� m   � ��/�/��� o   � ��.�. 0 	chunksize 	chunkSize�1  �0  � m   � ��� ��� 
   a n d  � l  � ���-�,� \   � ���� a   � ���� m   � ��+�+ � o   � ��*�* 0 	chunksize 	chunkSize� m   � ��)�) �-  �,  �2  �5  � o   y ~�(�( 0 _support  �?  �>  � ��� r   � ���� m   � ��� ���  -� o      �'�' 0 	hexprefix 	hexPrefix� ��&� r   � ���� d   � ��� o   � ��%�% 0 	thenumber 	theNumber� o      �$�$ 0 	thenumber 	theNumber�&  �B  � k   � ��� ��� r   � ���� m   � ��� ���  � o      �#�# 0 	hexprefix 	hexPrefix� ��"� Z  � �� �!� � F   � � ?   � � o   � ��� 0 	chunksize 	chunkSize m   � ���   l  � ��� ?   � � o   � ��� 0 	thenumber 	theNumber \   � �	 a   � �

 m   � ���  o   � ��� 0 	chunksize 	chunkSize	 m   � ��� �  �    n  � � I   � ���� .0 throwinvalidparameter throwInvalidParameter  o   � ��� 0 	thenumber 	theNumber  m   � � �    m   � ��
� 
long � b   � � b   � � b   � � m   � � � X s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n   l  � � ��  a   � �!"! m   � �����" o   � ��� 0 	chunksize 	chunkSize�  �   m   � �## �$$ 
   a n d   l  � �%��% \   � �&'& a   � �()( m   � ��� ) o   � ��� 0 	chunksize 	chunkSize' m   � ��
�
 �  �  �  �   o   � ��	�	 0 _support  �!  �   �"  � *+* Z  � �,-��, o   � ��� 0 	hasprefix 	hasPrefix- r   � �./. b   � �010 o   � ��� 0 	hexprefix 	hexPrefix1 m   � �22 �33  0 x/ o      �� 0 	hexprefix 	hexPrefix�  �  + 454 V   '676 k  "88 9:9 r  ;<; b  =>= l ?��? n  @A@ 4  �B
� 
cobjB l C� ��C [  DED `  FGF o  ���� 0 	thenumber 	theNumberG m  ���� E m  ���� �   ��  A m  HH �II   0 1 2 3 4 5 6 7 8 9 A B C D E F�  �  > o  ���� 0 hextext hexText< o      ���� 0 hextext hexText: J��J r  "KLK _   MNM o  ���� 0 	thenumber 	theNumberN m  ���� L o      ���� 0 	thenumber 	theNumber��  7 ?  OPO o  ���� 0 	thenumber 	theNumberP m  ����  5 QRQ V  (@STS r  4;UVU b  49WXW m  47YY �ZZ  0X o  78���� 0 hextext hexTextV o      ���� 0 hextext hexTextT A  ,3[\[ n  ,1]^] 1  -1��
�� 
leng^ o  ,-���� 0 hextext hexText\ o  12���� 0 	chunksize 	chunkSizeR _��_ L  AE`` b  ADaba o  AB���� 0 	hexprefix 	hexPrefixb o  BC���� 0 hextext hexText��  �   format single number   � �cc *   f o r m a t   s i n g l e   n u m b e r�`  z l H�defd k  H�gg hih l Hkjklj Z Hkmn����m G  HSopo A  HKqrq o  HI���� 0 	chunksize 	chunkSizer m  IJ���� p ?  NQsts o  NO���� 0 	chunksize 	chunkSizet m  OP���� n n Vguvu I  [g��w���� .0 throwinvalidparameter throwInvalidParameterw xyx o  [\���� 0 	chunksize 	chunkSizey z{z m  \_|| �}} 
 w i d t h{ ~~ m  _`��
�� 
long ���� m  `c�� ���  m u s t   b e   1  1 0 2 4��  ��  v o  V[���� 0 _support  ��  ��  k   chunksize must be given   l ��� 0   c h u n k s i z e   m u s t   b e   g i v e ni ��� r  l���� J  lx�� ��� m  lo�� ���  � ���� \  ov��� a  ot��� m  or���� � o  rs���� 0 	chunksize 	chunkSize� m  tu���� ��  � J      �� ��� o      ���� 0 padtext padText� ���� o      ���� 0 maxsize maxSize��  � ��� U  ����� r  ����� b  ����� o  ������ 0 padtext padText� m  ���� ���  0� o      ���� 0 padtext padText� o  ������ 0 	chunksize 	chunkSize� ��� h  ������� 0 
resultlist 
resultList� j     	����� 
0 _list_  � n    ��� 2   ��
�� 
cobj� o     ���� 0 	thenumber 	theNumber� ��� X  ������� k  �{�� ��� Q  �6���� k  ���� ��� r  ����� c  ����� n ����� 1  ����
�� 
pcnt� o  ������ 0 aref aRef� m  ����
�� 
long� o      ���� 0 	thenumber 	theNumber� ���� Z ��������� G  ����� G  ����� >  ����� o  ������ 0 	thenumber 	theNumber� c  ����� n ����� 1  ����
�� 
pcnt� o  ������ 0 aref aRef� m  ����
�� 
doub� A  ����� o  ������ 0 	thenumber 	theNumber� m  ������  � ?  ����� o  ������ 0 	thenumber 	theNumber� o  ������ 0 maxsize maxSize� R  �������
�� .ascrerr ****      � ****��  � �����
�� 
errn� m  �������\��  ��  ��  ��  � R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � Z  6������ ?  ��� o  ���� 0 	thenumber 	theNumber� o  ���� 0 maxsize maxSize� n 	"��� I  "������� .0 throwinvalidparameter throwInvalidParameter� ��� o  ���� 0 	thenumber 	theNumber� ��� m  �� ���  � ��� m  ��
�� 
long� ���� b  ��� m  �� ��� h s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n   0 . 0   a n d  � l ������ \  ��� a  ��� m  ���� � o  ���� 0 	chunksize 	chunkSize� m  ���� ��  ��  ��  ��  � o  	���� 0 _support  ��  � n %6��� I  *6������� .0 throwinvalidparameter throwInvalidParameter� ��� o  *+���� 0 aref aRef� ��� m  +.�� ���  � ��� m  ./��
�� 
long� ���� m  /2�� ��� V e x p e c t e d   n o n - n e g a t i v e   n o n - f r a c t i o n a l   n u m b e r��  ��  � o  %*���� 0 _support  � ��� r  7<��� m  7:�� ���  � o      ���� 0 hextext hexText� ��� V  =d� � k  E_  r  EW b  EU l ES���� n  ES	
	 4  HS��
�� 
cobj l KR���� [  KR `  KP o  KL���� 0 	thenumber 	theNumber m  LO����  m  PQ���� ��  ��  
 m  EH �   0 1 2 3 4 5 6 7 8 9 A B C D E F��  ��   o  ST���� 0 hextext hexText o      ���� 0 hextext hexText �� r  X_ _  X] o  XY���� 0 	thenumber 	theNumber m  Y\����  o      ���� 0 	thenumber 	theNumber��    ?  AD o  AB���� 0 	thenumber 	theNumber m  BC����  � �� r  e{ n eu 7 hu�� 
�� 
ctxt d  nq!! o  op���� 0 	chunksize 	chunkSize  m  rt������ l eh"����" b  eh#$# o  ef���� 0 padtext padText$ o  fg���� 0 hextext hexText��  ��   n     %&% 1  vz��
�� 
pcnt& o  uv���� 0 aref aRef��  �� 0 aref aRef� n ��'(' o  ������ 
0 _list_  ( o  ������ 0 
resultlist 
resultList� )*) r  ��+,+ n ��-.- 1  ����
�� 
txdl. 1  ����
�� 
ascr, o      ���� 0 oldtids oldTIDs* /0/ r  ��121 m  ��33 �44  2 n     565 1  ����
�� 
txdl6 1  ����
�� 
ascr0 787 Z  ��9:��;9 o  ������ 0 	hasprefix 	hasPrefix: r  ��<=< b  ��>?> m  ��@@ �AA  0 x? n ��BCB o  ���� 
0 _list_  C o  ���~�~ 0 
resultlist 
resultList= o      �}�} 0 hextext hexText��  ; r  ��DED c  ��FGF n ��HIH o  ���|�| 
0 _list_  I o  ���{�{ 0 
resultlist 
resultListG m  ���z
�z 
ctxtE o      �y�y 0 hextext hexText8 JKJ r  ��LML o  ���x�x 0 oldtids oldTIDsM n     NON 1  ���w
�w 
txdlO 1  ���v
�v 
ascrK P�uP L  ��QQ o  ���t�t 0 hextext hexText�u  e   format list of number   f �RR ,   f o r m a t   l i s t   o f   n u m b e r�a  X R      �sST
�s .ascrerr ****      � ****S o      �r�r 0 etext eTextT �qUV
�q 
errnU o      �p�p 0 enumber eNumberV �oWX
�o 
erobW o      �n�n 0 efrom eFromX �mY�l
�m 
errtY o      �k�k 
0 eto eTo�l  Y I  ���jZ�i�j 
0 _error  Z [\[ m  ��]] �^^  f o r m a t   h e x\ _`_ o  ���h�h 0 etext eText` aba o  ���g�g 0 enumber eNumberb cdc o  ���f�f 0 efrom eFromd e�ee o  ���d�d 
0 eto eTo�e  �i  I fgf l     �c�b�a�c  �b  �a  g hih l     �`�_�^�`  �_  �^  i jkj i  J Mlml I     �]no
�] .Mth:HeNunull���     ctxtn o      �\�\ 0 hextext hexTexto �[pq
�[ 
Placp |�Z�Yr�Xs�Z  �Y  r o      �W�W 0 	chunksize 	chunkSize�X  s l     t�V�Ut m      �T�T  �V  �U  q �Su�R
�S 
Precu |�Q�Pv�Ow�Q  �P  v o      �N�N 0 	isprecise 	isPrecise�O  w l     x�M�Lx m      �K
�K boovtrue�M  �L  �R  m Q    byz{y P   L|}~| k   K ��� r    ��� n   ��� I    �J��I�J "0 astextparameter asTextParameter� ��� o    �H�H 0 hextext hexText� ��G� m    �� ���  �G  �I  � o    �F�F 0 _support  � o      �E�E 0 hextext hexText� ��� r    #��� n   !��� I    !�D��C�D (0 asintegerparameter asIntegerParameter� ��� o    �B�B 0 	chunksize 	chunkSize� ��A� m    �� ��� 
 w i d t h�A  �C  � o    �@�@ 0 _support  � o      �?�? 0 	chunksize 	chunkSize� ��� Z  $ C���>�=� G   $ /��� A   $ '��� o   $ %�<�< 0 	chunksize 	chunkSize� m   % &�;�;  � ?   * -��� o   * +�:�: 0 	chunksize 	chunkSize� m   + ,�9�9 � n  2 ?��� I   7 ?�8��7�8 .0 throwinvalidparameter throwInvalidParameter� ��� o   7 8�6�6 0 	chunksize 	chunkSize� ��� m   8 9�� ��� 
 w i d t h� ��� m   9 :�5
�5 
long� ��4� m   : ;�� ���  m u s t   b e   0  1 0 2 4�4  �7  � o   2 7�3�3 0 _support  �>  �=  � ��� r   D R��� H   D P�� n  D O��� I   I O�2��1�2 (0 asbooleanparameter asBooleanParameter� ��� o   I J�0�0 0 	isprecise 	isPrecise� ��/� m   J K�� ���  p r e c i s i o n   l o s s�/  �1  � o   D I�.�. 0 _support  � o      �-�- 0 	isprecise 	isPrecise� ��,� Z   SK���+�� =   S V��� o   S T�*�* 0 	chunksize 	chunkSize� m   T U�)�)  � l  Y;���� k   Y;�� ��� Q   Y���� k   \ ��� ��� r   \ _��� m   \ ]�(�(  � o      �'�' 0 	thenumber 	theNumber� ��� r   ` e��� C   ` c��� o   ` a�&�& 0 hextext hexText� m   a b�� ���  -� o      �%�% 0 
isnegative 
isNegative� ��� Z  f }���$�#� o   f g�"�" 0 
isnegative 
isNegative� r   j y��� n   j w��� 7  k w�!��
�! 
ctxt� m   q s� �  � m   t v����� o   j k�� 0 hextext hexText� o      �� 0 hextext hexText�$  �#  � ��� Z  ~ ������ C   ~ ���� o   ~ �� 0 hextext hexText� m    ��� ���  0 x� r   � ���� n   � ���� 7  � ����
� 
ctxt� m   � ��� � m   � ������ o   � ��� 0 hextext hexText� o      �� 0 hextext hexText�  �  � ��� X   � ����� k   � ��� ��� r   � ���� ]   � ���� o   � ��� 0 	thenumber 	theNumber� m   � ��� � o      �� 0 	thenumber 	theNumber� ��� r   � ���� I  � ��� � z��
� .sysooffslong    ��� null
� misccura�    �
� 
psof o   � ��� 0 charref charRef �
�	
�
 
psin m   � � �   0 1 2 3 4 5 6 7 8 9 A B C D E F�	  � o      �� 0 i  �  Z  � �	�� =   � �

 o   � ��� 0 i   m   � ���  	 R   � ���
� .ascrerr ****      � ****�   �� 
� 
errn m   � ������@�   �  �   �� r   � � \   � � [   � � o   � ����� 0 	thenumber 	theNumber o   � ����� 0 i   m   � �����  o      ���� 0 	thenumber 	theNumber��  � 0 charref charRef� o   � ����� 0 hextext hexText�  � R      ����
�� .ascrerr ****      � ****��   ����
�� 
errn d       m      �������  � l  � R   ���
�� .ascrerr ****      � **** m   � > N o t   a   v a l i d   h e x a d e c i m a l   n u m b e r . �� 
�� 
errn m   � ������Y  ��!��
�� 
erob! o  ���� 0 hextext hexText��   E ? catch errors if hexText is too short or contains non-hex chars    �"" ~   c a t c h   e r r o r s   i f   h e x T e x t   i s   t o o   s h o r t   o r   c o n t a i n s   n o n - h e x   c h a r s� #$# Z 	+%&����% F  	'(' o  	
���� 0 	isprecise 	isPrecise( l )����) =  *+* o  ���� 0 	thenumber 	theNumber+ [  ,-, o  ���� 0 	thenumber 	theNumber- m  ���� ��  ��  & R  '��./
�� .ascrerr ****      � ****. m  #&00 �11 � H e x a d e c i m a l   t e x t   i s   t o o   l a r g e   t o   c o n v e r t   t o   n u m b e r   w i t h o u t   l o s i n g   p r e c i s i o n ./ ��23
�� 
errn2 m  �����Y3 ��4��
�� 
erob4 o  !"���� 0 hextext hexText��  ��  ��  $ 565 Z ,878����7 o  ,-���� 0 
isnegative 
isNegative8 r  049:9 d  02;; o  01���� 0 	thenumber 	theNumber: o      ���� 0 	thenumber 	theNumber��  ��  6 <��< L  9;== o  9:���� 0 	thenumber 	theNumber��  �   read as single number   � �>> ,   r e a d   a s   s i n g l e   n u m b e r�+  � l >K?@A? k  >KBB CDC Z >dEF����E >  >GGHG `  >EIJI l >CK����K n >CLML 1  ?C��
�� 
lengM o  >?���� 0 hextext hexText��  ��  J o  CD���� 0 	chunksize 	chunkSizeH m  EF����  F R  J`��NO
�� .ascrerr ****      � ****N b  V_PQP b  V[RSR m  VYTT �UU T C a n ' t   s p l i t   h e x a d e c i m a l   t e x t   e x a c t l y   i n t o  S o  YZ���� 0 	chunksize 	chunkSizeQ m  [^VV �WW  - d i g i t   c h u n k s .O ��XY
�� 
errnX m  NQ�����YY ��Z��
�� 
erobZ o  TU���� 0 hextext hexText��  ��  ��  D [\[ h  ep��]�� 0 
resultlist 
resultList] j     ��^�� 
0 _list_  ^ J     ����  \ _`_ Y  qCa��bcda k  �>ee fgf r  ��hih m  ������  i o      ���� 0 	thenumber 	theNumberg jkj X  �l��ml k  ��nn opo r  ��qrq ]  ��sts o  ������ 0 	thenumber 	theNumbert m  ������ r o      ���� 0 	thenumber 	theNumberp uvu r  ��wxw I ��y��zy z����
�� .sysooffslong    ��� null
�� misccura��  z ��{|
�� 
psof{ o  ������ 0 charref charRef| ��}��
�� 
psin} m  ��~~ �   0 1 2 3 4 5 6 7 8 9 A B C D E F��  x o      ���� 0 i  v ��� Z ��������� =  ����� o  ������ 0 i  � m  ������  � R  ������
�� .ascrerr ****      � ****� m  ���� ��� > N o t   a   v a l i d   h e x a d e c i m a l   n u m b e r .� ����
�� 
errn� m  �������Y� �����
�� 
erob� l �������� N  ���� n  ����� 7 ������
�� 
ctxt� o  ������ 0 i  � l �������� \  ����� [  ����� o  ������ 0 i  � o  ������ 0 	chunksize 	chunkSize� m  ������ ��  ��  � o  ������ 0 hextext hexText��  ��  ��  ��  ��  � ���� r  ����� \  ����� [  ����� o  ������ 0 	thenumber 	theNumber� o  ������ 0 i  � m  ������ � o      ���� 0 	thenumber 	theNumber��  �� 0 charref charRefm n ����� 7 ������
�� 
ctxt� o  ������ 0 i  � l �������� \  ����� [  ����� o  ������ 0 i  � o  ������ 0 	chunksize 	chunkSize� m  ������ ��  ��  � o  ������ 0 hextext hexTextk ��� Z 5������� F  ��� o  ���� 0 	isprecise 	isPrecise� l ������ =  ��� o  ���� 0 	thenumber 	theNumber� [  
��� o  ���� 0 	thenumber 	theNumber� m  	���� ��  ��  � R  1����
�� .ascrerr ****      � ****� m  -0�� ��� � H e x a d e c i m a l   t e x t   i s   t o o   l a r g e   t o   c o n v e r t   t o   n u m b e r   w i t h o u t   l o s i n g   p r e c i s i o n .� ����
�� 
errn� m  �����Y� �����
�� 
erob� l ,������ N  ,�� n  +��� 7 +����
�� 
ctxt� o  !#���� 0 i  � l $*������ \  $*��� [  %(��� o  %&���� 0 i  � o  &'���� 0 	chunksize 	chunkSize� m  ()���� ��  ��  � o  ���� 0 hextext hexText��  ��  ��  ��  ��  � ���� r  6>��� o  67�� 0 	thenumber 	theNumber� n      ���  ;  <=� n 7<��� o  8<�~�~ 
0 _list_  � o  78�}�} 0 
resultlist 
resultList��  �� 0 i  b m  tu�|�| c n u{��� 1  vz�{
�{ 
leng� o  uv�z�z 0 hextext hexTextd o  {|�y�y 0 	chunksize 	chunkSize` ��x� L  DK�� n DJ��� o  EI�w�w 
0 _list_  � o  DE�v�v 0 
resultlist 
resultList�x  @   read as list of numbers   A ��� 0   r e a d   a s   l i s t   o f   n u m b e r s�,  } �u�
�u consdiac� �t�
�t conshyph� �s�
�s conspunc� �r�q
�r conswhit�q  ~ �p�
�p conscase� �o�n
�o consnume�n  z R      �m��
�m .ascrerr ****      � ****� o      �l�l 0 etext eText� �k��
�k 
errn� o      �j�j 0 enumber eNumber� �i��
�i 
erob� o      �h�h 0 efrom eFrom� �g��f
�g 
errt� o      �e�e 
0 eto eTo�f  { I  Tb�d��c�d 
0 _error  � ��� m  UX�� ���  p a r s e   h e x� ��� o  XY�b�b 0 etext eText� ��� o  YZ�a�a 0 enumber eNumber� ��� o  Z[�`�` 0 efrom eFrom� ��_� o  [\�^�^ 
0 eto eTo�_  �c  k ��� l     �]�\�[�]  �\  �[  � ��� l     �Z�Y�X�Z  �Y  �X  � ��� l     �W���W  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �V���V  � !  General numeric operations   � ��� 6   G e n e r a l   n u m e r i c   o p e r a t i o n s� ��� l     �U�T�S�U  �T  �S  � ��� i  N Q��� I     �R��Q
�R .Mth:DeRanull���     doub� o      �P�P 0 x  �Q  � Q     �	 	� L    		 ]    
			 l   	�O�N	 c    			 o    �M�M 0 x  	 m    �L
�L 
doub�O  �N  	 l   		�K�J	 ^    				
		 1    �I
�I 
pi  	
 m    �H�H ��K  �J  	  R      �G		
�G .ascrerr ****      � ****	 o      �F�F 0 etext eText	 �E		
�E 
errn	 o      �D�D 0 enumber eNumber	 �C		
�C 
erob	 o      �B�B 0 efrom eFrom	 �A	�@
�A 
errt	 o      �?�? 
0 eto eTo�@  	 I    �>	�=�> 
0 _error  	 			 m    		 �		  r a d i a n s	 			 o    �<�< 0 etext eText	 			 o    �;�; 0 enumber eNumber	 			 o    �:�: 0 efrom eFrom	 	�9	 o    �8�8 
0 eto eTo�9  �=  � 			 l     �7�6�5�7  �6  �5  	 	 	!	  l     �4�3�2�4  �3  �2  	! 	"	#	" i  R U	$	%	$ I     �1	&�0
�1 .Mth:RaDenull���     doub	& o      �/�/ 0 x  �0  	% Q     	'	(	)	' L    	*	* ^    
	+	,	+ l   	-�.�-	- c    	.	/	. o    �,�, 0 x  	/ m    �+
�+ 
doub�.  �-  	, l   		0�*�)	0 ^    		1	2	1 1    �(
�( 
pi  	2 m    �'�' ��*  �)  	( R      �&	3	4
�& .ascrerr ****      � ****	3 o      �%�% 0 etext eText	4 �$	5	6
�$ 
errn	5 o      �#�# 0 enumber eNumber	6 �"	7	8
�" 
erob	7 o      �!�! 0 efrom eFrom	8 � 	9�
�  
errt	9 o      �� 
0 eto eTo�  	) I    �	:�� 
0 _error  	: 	;	<	; m    	=	= �	>	>  d e g r e e s	< 	?	@	? o    �� 0 etext eText	@ 	A	B	A o    �� 0 enumber eNumber	B 	C	D	C o    �� 0 efrom eFrom	D 	E�	E o    �� 
0 eto eTo�  �  	# 	F	G	F l     ����  �  �  	G 	H	I	H l     ����  �  �  	I 	J	K	J l     ����  �  �  	K 	L	M	L i  V Y	N	O	N I     �	P�
� .Mth:Abs_null���     nmbr	P o      �� 0 x  �  	O Q     )	Q	R	S	Q k    	T	T 	U	V	U r    	W	X	W c    	Y	Z	Y o    �
�
 0 x  	Z m    �	
�	 
nmbr	X o      �� 0 x  	V 	[�	[ Z   	 	\	]�	^	\ A   	 	_	`	_ o   	 
�� 0 x  	` m   
 ��  	] L    	a	a d    	b	b o    �� 0 x  �  	^ L    	c	c o    �� 0 x  �  	R R      �	d	e
� .ascrerr ****      � ****	d o      � �  0 etext eText	e ��	f	g
�� 
errn	f o      ���� 0 enumber eNumber	g ��	h	i
�� 
erob	h o      ���� 0 efrom eFrom	i ��	j��
�� 
errt	j o      ���� 
0 eto eTo��  	S I    )��	k���� 
0 _error  	k 	l	m	l m     !	n	n �	o	o  a b s	m 	p	q	p o   ! "���� 0 etext eText	q 	r	s	r o   " #���� 0 enumber eNumber	s 	t	u	t o   # $���� 0 efrom eFrom	u 	v��	v o   $ %���� 
0 eto eTo��  ��  	M 	w	x	w l     ��������  ��  ��  	x 	y	z	y l     ��������  ��  ��  	z 	{	|	{ i  Z ]	}	~	} I     ��	��
�� .Mth:CmpNnull���     ****	 J      	�	� 	�	�	� o      ���� 0 n1  	� 	���	� o      ���� 0 n2  ��  ��  	~ Q     �	�	�	�	� k    �	�	� 	�	�	� Z    �	�	���	�	� =    	�	�	� l   	�����	� I   ��	�	�
�� .corecnte****       ****	� J    	�	� 	�	�	� o    ���� 0 n1  	� 	���	� o    ���� 0 n2  ��  	� ��	���
�� 
kocl	� m    	��
�� 
long��  ��  ��  	� m    ���� 	� Z   	�	�����	� =    	�	�	� o    ���� 0 n1  	� o    ���� 0 n2  	� L    	�	� m    ����  ��  ��  ��  	� k   ! �	�	� 	�	�	� r   ! 8	�	�	� J   ! )	�	� 	�	�	� c   ! $	�	�	� o   ! "���� 0 n1  	� m   " #��
�� 
doub	� 	���	� c   $ '	�	�	� o   $ %���� 0 n2  	� m   % &��
�� 
doub��  	� J      	�	� 	�	�	� o      ���� 0 n1  	� 	���	� o      ���� 0 n2  ��  	� 	�	�	� Z   9 T	�	���	�	� =   9 <	�	�	� o   9 :���� 0 n1  	� m   : ;����  	� r   ? H	�	�	� ]   ? F	�	�	� o   ? D���� 0 _isequaldelta _isEqualDelta	� o   D E���� 0 n2  	� o      ���� 0 dn  ��  	� r   K T	�	�	� ]   K R	�	�	� o   K P���� 0 _isequaldelta _isEqualDelta	� o   P Q���� 0 n1  	� o      ���� 0 dn  	� 	�	�	� r   U Y	�	�	� d   U W	�	� o   U V���� 0 dn  	� o      ���� 0 dm  	� 	�	�	� Z  Z w	�	�����	� ?   Z ]	�	�	� o   Z [���� 0 dm  	� o   [ \���� 0 dn  	� r   ` s	�	�	� J   ` d	�	� 	�	�	� o   ` a���� 0 dm  	� 	���	� o   a b���� 0 dn  ��  	� J      	�	� 	�	�	� o      ���� 0 dn  	� 	���	� o      ���� 0 dm  ��  ��  ��  	� 	�	�	� r   x }	�	�	� \   x {	�	�	� o   x y���� 0 n2  	� o   y z���� 0 n1  	� o      ���� 0 d  	� 	���	� Z  ~ �	�	�����	� F   ~ �	�	�	� ?   ~ �	�	�	� o   ~ ���� 0 d  	� o    ����� 0 dm  	� A   � �	�	�	� o   � ����� 0 d  	� o   � ����� 0 dn  	� L   � �	�	� m   � �����  ��  ��  ��  	� 	���	� Z   � �	�	���	�	� A   � �	�	�	� o   � ����� 0 n1  	� o   � ����� 0 n2  	� L   � �	�	� m   � ���������  	� L   � �	�	� m   � ����� ��  	� R      ��	�	�
�� .ascrerr ****      � ****	� o      ���� 0 etext eText	� ��	�	�
�� 
errn	� o      ���� 0 enumber eNumber	� ��	�	�
�� 
erob	� o      ���� 0 efrom eFrom	� ��	���
�� 
errt	� o      ���� 
0 eto eTo��  	� I   � ���	����� 
0 _error  	� 	�	�	� m   � �	�	� �	�	�  c m p	� 	�	�	� o   � ����� 0 etext eText	� 	�	�	� o   � ����� 0 enumber eNumber	� 	�	�	� o   � ����� 0 efrom eFrom	� 	���	� o   � ����� 
0 eto eTo��  ��  	| 	�	�	� l     ��������  ��  ��  	� 	�	�	� l     ��������  ��  ��  	� 
 

  i  ^ a


 I     ��
��
�� .Mth:MinNnull���     ****
 o      ���� 0 thelist theList��  
 Q     W



 k    E

 
	


	 h    
��
�� 0 
listobject 
listObject
 j     ��
�� 
0 _list_  
 n    


 I    ��
���� "0 aslistparameter asListParameter
 
��
 o    
���� 0 thelist theList��  ��  
 o     ���� 0 _support  

 


 r    


 c    


 l   
����
 n    


 4   ��

�� 
cobj
 m    ���� 
 n   


 o    ���� 
0 _list_  
 o    ���� 0 
listobject 
listObject��  ��  
 m    ��
�� 
nmbr
 o      ���� 0 	theresult 	theResult
 


 X    B
��
 
 k   ( =
!
! 
"
#
" r   ( /
$
%
$ c   ( -
&
'
& n  ( +
(
)
( 1   ) +�
� 
pcnt
) o   ( )�~�~ 0 aref aRef
' m   + ,�}
�} 
nmbr
% o      �|�| 0 x  
# 
*�{
* Z  0 =
+
,�z�y
+ A   0 3
-
.
- o   0 1�x�x 0 x  
. o   1 2�w�w 0 	theresult 	theResult
, r   6 9
/
0
/ o   6 7�v�v 0 x  
0 o      �u�u 0 	theresult 	theResult�z  �y  �{  �� 0 aref aRef
  n   
1
2
1 o    �t�t 
0 _list_  
2 o    �s�s 0 
listobject 
listObject
 
3�r
3 L   C E
4
4 o   C D�q�q 0 	theresult 	theResult�r  
 R      �p
5
6
�p .ascrerr ****      � ****
5 o      �o�o 0 etext eText
6 �n
7
8
�n 
errn
7 o      �m�m 0 enumber eNumber
8 �l
9
:
�l 
erob
9 o      �k�k 0 efrom eFrom
: �j
;�i
�j 
errt
; o      �h�h 
0 eto eTo�i  
 I   M W�g
<�f�g 
0 _error  
< 
=
>
= m   N O
?
? �
@
@  m i n
> 
A
B
A o   O P�e�e 0 etext eText
B 
C
D
C o   P Q�d�d 0 enumber eNumber
D 
E
F
E o   Q R�c�c 0 efrom eFrom
F 
G�b
G o   R S�a�a 
0 eto eTo�b  �f  
 
H
I
H l     �`�_�^�`  �_  �^  
I 
J
K
J l     �]�\�[�]  �\  �[  
K 
L
M
L i  b e
N
O
N I     �Z
P�Y
�Z .Mth:MaxNnull���     ****
P o      �X�X 0 thelist theList�Y  
O Q     W
Q
R
S
Q k    E
T
T 
U
V
U h    
�W
W�W 0 
listobject 
listObject
W j     �V
X�V 
0 _list_  
X n    
Y
Z
Y I    �U
[�T�U "0 aslistparameter asListParameter
[ 
\�S
\ o    
�R�R 0 thelist theList�S  �T  
Z o     �Q�Q 0 _support  
V 
]
^
] r    
_
`
_ c    
a
b
a l   
c�P�O
c n    
d
e
d 4   �N
f
�N 
cobj
f m    �M�M 
e n   
g
h
g o    �L�L 
0 _list_  
h o    �K�K 0 
listobject 
listObject�P  �O  
b m    �J
�J 
nmbr
` o      �I�I 0 	theresult 	theResult
^ 
i
j
i X    B
k�H
l
k k   ( =
m
m 
n
o
n r   ( /
p
q
p c   ( -
r
s
r n  ( +
t
u
t 1   ) +�G
�G 
pcnt
u o   ( )�F�F 0 aref aRef
s m   + ,�E
�E 
nmbr
q o      �D�D 0 x  
o 
v�C
v Z  0 =
w
x�B�A
w ?   0 3
y
z
y o   0 1�@�@ 0 x  
z o   1 2�?�? 0 	theresult 	theResult
x r   6 9
{
|
{ o   6 7�>�> 0 x  
| o      �=�= 0 	theresult 	theResult�B  �A  �C  �H 0 aref aRef
l n   
}
~
} o    �<�< 
0 _list_  
~ o    �;�; 0 
listobject 
listObject
j 
�:
 L   C E
�
� o   C D�9�9 0 	theresult 	theResult�:  
R R      �8
�
�
�8 .ascrerr ****      � ****
� o      �7�7 0 etext eText
� �6
�
�
�6 
errn
� o      �5�5 0 enumber eNumber
� �4
�
�
�4 
erob
� o      �3�3 0 efrom eFrom
� �2
��1
�2 
errt
� o      �0�0 
0 eto eTo�1  
S I   M W�/
��.�/ 
0 _error  
� 
�
�
� m   N O
�
� �
�
�  m a x
� 
�
�
� o   O P�-�- 0 etext eText
� 
�
�
� o   P Q�,�, 0 enumber eNumber
� 
�
�
� o   Q R�+�+ 0 efrom eFrom
� 
��*
� o   R S�)�) 
0 eto eTo�*  �.  
M 
�
�
� l     �(�'�&�(  �'  �&  
� 
�
�
� l     �%�$�#�%  �$  �#  
� 
�
�
� i  f i
�
�
� I     �"
�
�
�" .Mth:RouNnull���     nmbr
� o      �!�! 0 num  
� � 
�
�
�  
Plac
� |��
��
��  �  
� o      �� 0 decimalplaces decimalPlaces�  
� l     
���
� m      ��  �  �  
� �
��
� 
Dire
� |��
��
��  �  
� o      �� &0 roundingdirection roundingDirection�  
� l     
���
� m      �
� MRndRNhE�  �  �  
� Q    �
�
�
�
� k   �
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
� I    �
��� "0 asrealparameter asRealParameter
� 
�
�
� o    	�� 0 num  
� 
��
� m   	 

�
� �
�
�  �  �  
� o    �� 0 _support  
� o      �
�
 0 num  
� 
�
�
� r    
�
�
� n   
�
�
� I    �	
���	 (0 asintegerparameter asIntegerParameter
� 
�
�
� o    �� 0 decimalplaces decimalPlaces
� 
��
� m    
�
� �
�
�  t o   p l a c e s�  �  
� o    �� 0 _support  
� o      �� 0 decimalplaces decimalPlaces
� 
�
�
� Z    8
�
���
� >    "
�
�
� o     �� 0 decimalplaces decimalPlaces
� m     !� �   
� k   % 4
�
� 
�
�
� r   % *
�
�
� a   % (
�
�
� m   % &���� 

� o   & '���� 0 decimalplaces decimalPlaces
� o      ���� 0 themultiplier theMultiplier
� 
���
� l  + 4
�
�
�
� r   + 4
�
�
� ^   + 2
�
�
� ]   + 0
�
�
� ]   + .
�
�
� o   + ,���� 0 num  
� m   , -���� 

� o   . /���� 0 themultiplier theMultiplier
� m   0 1���� 

� o      ���� 0 num  
��� multiplying and dividing by 10 before and after applying the multiplier helps avoid poor rounding results for some numbers due to inevitable loss of precision in floating-point math (e.g. `324.21 * 100 div 1 / 100` returns 324.2 but needs to be 324.21), though this hasn't been tested on all possible values for obvious reasons -- TO DO: shouldn't /10 be done after rounding is applied (in which case following calculations should use mod 10, etc)?   
� �
�
��   m u l t i p l y i n g   a n d   d i v i d i n g   b y   1 0   b e f o r e   a n d   a f t e r   a p p l y i n g   t h e   m u l t i p l i e r   h e l p s   a v o i d   p o o r   r o u n d i n g   r e s u l t s   f o r   s o m e   n u m b e r s   d u e   t o   i n e v i t a b l e   l o s s   o f   p r e c i s i o n   i n   f l o a t i n g - p o i n t   m a t h   ( e . g .   ` 3 2 4 . 2 1   *   1 0 0   d i v   1   /   1 0 0 `   r e t u r n s   3 2 4 . 2   b u t   n e e d s   t o   b e   3 2 4 . 2 1 ) ,   t h o u g h   t h i s   h a s n ' t   b e e n   t e s t e d   o n   a l l   p o s s i b l e   v a l u e s   f o r   o b v i o u s   r e a s o n s   - -   T O   D O :   s h o u l d n ' t   / 1 0   b e   d o n e   a f t e r   r o u n d i n g   i s   a p p l i e d   ( i n   w h i c h   c a s e   f o l l o w i n g   c a l c u l a t i o n s   s h o u l d   u s e   m o d   1 0 ,   e t c ) ?��  �  �  
� 
�
�
� Z   9�
�
�
�
�
� =  9 <
�
�
� o   9 :���� &0 roundingdirection roundingDirection
� l  : ;
�����
� m   : ;��
�� MRndRNhE��  ��  
� Z   ? m
�
�
�
�
� E  ? K
�
�
� J   ? C
�
� 
�
�
� m   ? @
�
� ��      
� 
���
� m   @ A
�
� ?�      ��  
� J   C J
�
� 
���
� `   C H
�
�
� l  C F
�����
� ^   C F
�
�
� o   C D���� 0 num  
� m   D E���� ��  ��  
� m   F G���� ��  
� l  N S
�
�
�
� r   N S
�
�
� _   N Q
�
�
� o   N O���� 0 num  
� m   O P���� 
� o      ���� 0 num  
� T N if num ends in .5 and its div is even then round toward zero so it stays even   
� �   �   i f   n u m   e n d s   i n   . 5   a n d   i t s   d i v   i s   e v e n   t h e n   r o u n d   t o w a r d   z e r o   s o   i t   s t a y s   e v e n
�  ?   V Y o   V W���� 0 num   m   W X����   �� l  \ c r   \ c	
	 _   \ a l  \ _���� [   \ _ o   \ ]���� 0 num   m   ] ^ ?�      ��  ��   m   _ `���� 
 o      ���� 0 num   H B else round to nearest whole digit (.5 will round up if positive�)    � �   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t   ( . 5   w i l l   r o u n d   u p   i f   p o s i t i v e & )��  
� l  f m r   f m _   f k l  f i���� \   f i o   f g���� 0 num   m   g h ?�      ��  ��   m   i j����  o      ���� 0 num   4 . (�or down if negative to give an even result)    � \   ( & o r   d o w n   i f   n e g a t i v e   t o   g i v e   a n   e v e n   r e s u l t )
�  =  p s !  o   p q���� &0 roundingdirection roundingDirection! l  q r"����" m   q r��
�� MRndRNhT��  ��   #$# Z   v �%&'(% E  v �)*) J   v z++ ,-, m   v w.. ��      - /��/ m   w x00 ?�      ��  * J   z 11 2��2 `   z }343 o   z {���� 0 num  4 m   { |���� ��  & l  � �5675 r   � �898 _   � �:;: o   � ����� 0 num  ; m   � ����� 9 o      ���� 0 num  6 0 * if num ends in .5 then round towards zero   7 �<< T   i f   n u m   e n d s   i n   . 5   t h e n   r o u n d   t o w a r d s   z e r o' =>= ?   � �?@? o   � ����� 0 num  @ m   � �����  > A��A l  � �BCDB r   � �EFE _   � �GHG l  � �I����I [   � �JKJ o   � ����� 0 num  K m   � �LL ?�      ��  ��  H m   � ����� F o      ���� 0 num  C ( " else round to nearest whole digit   D �MM D   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t��  ( r   � �NON _   � �PQP l  � �R����R \   � �STS o   � ����� 0 num  T m   � �UU ?�      ��  ��  Q m   � ����� O o      ���� 0 num  $ VWV =  � �XYX o   � ����� &0 roundingdirection roundingDirectionY l  � �Z����Z m   � ���
�� MRndRNhF��  ��  W [\[ Z   � �]^_`] E  � �aba J   � �cc ded m   � �ff ��      e g��g m   � �hh ?�      ��  b J   � �ii j��j `   � �klk o   � ����� 0 num  l m   � ����� ��  ^ l  � �mnom Z   � �pq��rp ?   � �sts o   � ����� 0 num  t m   � �����  q r   � �uvu [   � �wxw _   � �yzy o   � ����� 0 num  z m   � ����� x m   � ����� v o      ���� 0 num  ��  r r   � �{|{ \   � �}~} _   � �� o   � ����� 0 num  � m   � ����� ~ m   � ����� | o      ���� 0 num  n 0 * if num ends in .5 then round towards zero   o ��� T   i f   n u m   e n d s   i n   . 5   t h e n   r o u n d   t o w a r d s   z e r o_ ��� ?   � ���� o   � ����� 0 num  � m   � �����  � ���� l  � ����� r   � ���� _   � ���� l  � ������� [   � ���� o   � ����� 0 num  � m   � ��� ?�      ��  ��  � m   � ����� � o      ���� 0 num  � ( " else round to nearest whole digit   � ��� D   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t��  ` r   � ���� _   � ���� l  � ������� \   � ���� o   � ����� 0 num  � m   � ��� ?�      ��  ��  � m   � ����� � o      ���� 0 num  \ ��� =  � ���� o   � ����� &0 roundingdirection roundingDirection� l  � ������� m   � ���
�� MRndRN_T��  ��  � ��� r   � ���� _   � ���� o   � ����� 0 num  � m   � ����� � o      ���� 0 num  � ��� =  � ���� o   � ����� &0 roundingdirection roundingDirection� l  � ������� m   � ���
�� MRndRN_F��  ��  � ��� Z   '����� =   ��� `   ��� o   ���� 0 num  � m  ���� � m  ����  � r  ��� _  ��� o  	���� 0 num  � m  	
���� � o      ���� 0 num  � ��� ?  ��� o  ���� 0 num  � m  ����  � ���� r  ��� [  ��� _  ��� o  ���� 0 num  � m  ���� � m  ���� � o      ���� 0 num  ��  � r   '��� \   %��� _   #��� o   !���� 0 num  � m  !"���� � m  #$���� � o      ���� 0 num  � ��� = *-��� o  *+���� &0 roundingdirection roundingDirection� l +,������ m  +,��
�� MRndRN_U��  ��  � ��� l 0O���� Z  0O������ G  0=��� A  03��� o  01���� 0 num  � m  12����  � =  6;��� `  69��� o  67���� 0 num  � m  78�� � m  9:�~�~  � r  @E��� _  @C��� o  @A�}�} 0 num  � m  AB�|�| � o      �{�{ 0 num  ��  � r  HO��� [  HM��� _  HK��� o  HI�z�z 0 num  � m  IJ�y�y � m  KL�x�x � o      �w�w 0 num  �   ceil()   � ���    c e i l ( )� ��� = RW��� o  RS�v�v &0 roundingdirection roundingDirection� l SV��u�t� m  SV�s
�s MRndRN_D�u  �t  � ��r� l Zy���� Z  Zy���q�� G  Zg��� ?  Z]��� o  Z[�p�p 0 num  � m  [\�o�o  � =  `e��� `  `c��� o  `a�n�n 0 num  � m  ab�m�m � m  cd�l�l  � r  jo��� _  jm   o  jk�k�k 0 num   m  kl�j�j � o      �i�i 0 num  �q  � r  ry \  rw _  ru o  rs�h�h 0 num   m  st�g�g  m  uv�f�f  o      �e�e 0 num  �   floor()   � �    f l o o r ( )�r  
� n |�	
	 I  ���d�c�d >0 throwinvalidconstantparameter throwInvalidConstantParameter  o  ���b�b &0 roundingdirection roundingDirection �a m  �� �  b y�a  �c  
 o  |��`�` 0 _support  
� �_ Z  �� =  �� o  ���^�^ 0 decimalplaces decimalPlaces m  ���]�]   L  �� _  �� o  ���\�\ 0 num   m  ���[�[   A  �� o  ���Z�Z 0 decimalplaces decimalPlaces m  ���Y�Y   �X L  ��   _  ��!"! o  ���W�W 0 num  " o  ���V�V 0 themultiplier theMultiplier�X   L  ��## ^  ��$%$ o  ���U�U 0 num  % o  ���T�T 0 themultiplier theMultiplier�_  
� R      �S&'
�S .ascrerr ****      � ****& o      �R�R 0 etext eText' �Q()
�Q 
errn( o      �P�P 0 enumber eNumber) �O*+
�O 
erob* o      �N�N 0 efrom eFrom+ �M,�L
�M 
errt, o      �K�K 
0 eto eTo�L  
� I  ���J-�I�J 
0 _error  - ./. m  ��00 �11  r o u n d   n u m b e r/ 232 o  ���H�H 0 etext eText3 454 o  ���G�G 0 enumber eNumber5 676 o  ���F�F 0 efrom eFrom7 8�E8 o  ���D�D 
0 eto eTo�E  �I  
� 9:9 l     �C�B�A�C  �B  �A  : ;<; l     �@�?�>�@  �?  �>  < =>= l     �=?@�=  ? J D--------------------------------------------------------------------   @ �AA � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -> BCB l     �<DE�<  D   Trigonometry   E �FF    T r i g o n o m e t r yC GHG l     �;�:�9�;  �:  �9  H IJI i  j mKLK I      �8M�7�8 0 _sin  M N�6N o      �5�5 0 x  �6  �7  L k     �OO PQP l    	RSTR r     	UVU ]     WXW l    Y�4�3Y `     Z[Z o     �2�2 0 x  [ m    �1�1h�4  �3  X l   \�0�/\ ^    ]^] 1    �.
�. 
pi  ^ m    �-�- ��0  �/  V o      �,�, 0 x  S &   convert from degrees to radians   T �__ @   c o n v e r t   f r o m   d e g r e e s   t o   r a d i a n sQ `a` r   
 bcb A   
 ded o   
 �+�+ 0 x  e m    �*�*  c o      �)�) 0 isneg isNega fgf Z   hi�(�'h o    �&�& 0 isneg isNegi r    jkj d    ll o    �%�% 0 x  k o      �$�$ 0 x  �(  �'  g mnm r    &opo _    $qrq l   "s�#�"s ]    "tut o    �!�! 0 x  u l   !v� �v ^    !wxw m    �� x 1     �
� 
pi  �   �  �#  �"  r m   " #�� p o      �� 0 y  n yzy r   ' 2{|{ \   ' 0}~} o   ' (�� 0 y  ~ ]   ( /� l  ( -���� _   ( -��� ]   ( +��� o   ( )�� 0 y  � m   ) *�� ?�      � m   + ,�� �  �  � m   - .�� | o      �� 0 z  z ��� Z   3 J����� =  3 8��� `   3 6��� o   3 4�� 0 z  � m   4 5�� � m   6 7�� � k   ; F�� ��� r   ; @��� [   ; >��� o   ; <�� 0 z  � m   < =�� � o      �� 0 z  � ��� r   A F��� [   A D��� o   A B�
�
 0 y  � m   B C�	�	 � o      �� 0 y  �  �  �  � ��� r   K P��� `   K N��� o   K L�� 0 z  � m   L M�� � o      �� 0 z  � ��� Z   Q e����� ?   Q T��� o   Q R�� 0 z  � m   R S�� � k   W a�� ��� r   W [��� H   W Y�� o   W X� �  0 isneg isNeg� o      ���� 0 isneg isNeg� ���� r   \ a��� \   \ _��� o   \ ]���� 0 z  � m   ] ^���� � o      ���� 0 z  ��  �  �  � ��� r   f u��� \   f s��� l  f o������ \   f o��� l  f k������ \   f k��� o   f g���� 0 x  � ]   g j��� o   g h���� 0 y  � m   h i�� ?�!�?��v��  ��  � ]   k n��� o   k l���� 0 y  � m   l m�� >dD,���J��  ��  � ]   o r��� o   o p���� 0 y  � m   p q�� <�F���P�� o      ���� 0 z2  � ��� r   v {��� ]   v y��� o   v w���� 0 z2  � o   w x���� 0 z2  � o      ���� 0 zz  � ��� Z   | ������� G   | ���� =  | ��� o   | }���� 0 z  � m   } ~���� � =  � ���� o   � ����� 0 z  � m   � ����� � r   � ���� [   � ���� \   � ���� m   � ��� ?�      � ^   � ���� o   � ����� 0 zz  � m   � ����� � ]   � ���� ]   � ���� o   � ����� 0 zz  � o   � ����� 0 zz  � l  � ������� [   � ���� ]   � ���� l  � ������� \   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� \   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� m   � ��� ���I���� o   � ����� 0 zz  � m   � ��� >!�{N>���  ��  � o   � ����� 0 zz  � m   � �   >�~O~�K���  ��  � o   � ����� 0 zz  � m   � � >���D���  ��  � o   � ����� 0 zz  � m   � � ?V�l�=���  ��  � o   � ����� 0 zz  � m   � � ?�UUUV���  ��  � o      ���� 0 y  ��  � r   � � [   � � o   � ����� 0 z2   ]   � �	 ]   � �

 o   � ����� 0 z2   o   � ����� 0 zz  	 l  � ����� \   � � ]   � � l  � ����� [   � � ]   � � l  � ����� \   � � ]   � � l  � ����� [   � � ]   � � l  � � ����  \   � �!"! ]   � �#$# m   � �%% =���ќ�$ o   � ����� 0 zz  " m   � �&& >Z��)[��  ��   o   � ����� 0 zz   m   � �'' >��V}H���  ��   o   � ����� 0 zz   m   � �(( ?*������  ��   o   � ����� 0 zz   m   � �)) ?�"w��  ��   o   � ����� 0 zz   m   � �** ?�UUUU�?��  ��   o      ���� 0 y  � +,+ Z  � �-.����- o   � ����� 0 isneg isNeg. r   � �/0/ d   � �11 o   � ����� 0 y  0 o      ���� 0 y  ��  ��  , 2��2 L   � �33 o   � ����� 0 y  ��  J 454 l     ��������  ��  ��  5 676 l     ��������  ��  ��  7 898 l     ��������  ��  ��  9 :;: i  n q<=< I     ��>��
�� .Mth:Sin_null���     doub> o      ���� 0 x  ��  = Q     ?@A? L    BB I    ��C���� 0 _sin  C D��D c    EFE o    ���� 0 x  F m    ��
�� 
nmbr��  ��  @ R      ��GH
�� .ascrerr ****      � ****G o      ���� 0 etext eTextH ��IJ
�� 
errnI o      ���� 0 enumber eNumberJ ��KL
�� 
erobK o      ���� 0 efrom eFromL ��M��
�� 
errtM o      ���� 
0 eto eTo��  A I    ��N���� 
0 _error  N OPO m    QQ �RR  s i nP STS o    ���� 0 etext eTextT UVU o    ���� 0 enumber eNumberV WXW o    ���� 0 efrom eFromX Y��Y o    ���� 
0 eto eTo��  ��  ; Z[Z l     ��������  ��  ��  [ \]\ l     ��������  ��  ��  ] ^_^ i  r u`a` I     ��b��
�� .Mth:Cos_null���     doubb o      ���� 0 x  ��  a Q      cdec L    ff I    ��g���� 0 _sin  g h��h [    	iji l   k����k c    lml o    ���� 0 x  m m    ��
�� 
nmbr��  ��  j m    ���� Z��  ��  d R      ��no
�� .ascrerr ****      � ****n o      ���� 0 etext eTexto ��pq
�� 
errnp o      ���� 0 enumber eNumberq ��rs
�� 
erobr o      ���� 0 efrom eFroms ��t��
�� 
errtt o      ���� 
0 eto eTo��  e I     ��u��� 
0 _error  u vwv m    xx �yy  c o sw z{z o    �~�~ 0 etext eText{ |}| o    �}�} 0 enumber eNumber} ~~ o    �|�| 0 efrom eFrom ��{� o    �z�z 
0 eto eTo�{  �  _ ��� l     �y�x�w�y  �x  �w  � ��� l     �v�u�t�v  �u  �t  � ��� i  v y��� I     �s��r
�s .Mth:Tan_null���     doub� o      �q�q 0 x  �r  � k    �� ��� l     �p���p  � a [ note: this starts to lose accuracy between 89.9999999 and 90�, but should be 'good enough'   � ��� �   n o t e :   t h i s   s t a r t s   t o   l o s e   a c c u r a c y   b e t w e e n   8 9 . 9 9 9 9 9 9 9   a n d   9 0 � ,   b u t   s h o u l d   b e   ' g o o d   e n o u g h '� ��o� Q    ���� k    ��� ��� r    ��� c    ��� o    �n�n 0 x  � m    �m
�m 
nmbr� o      �l�l 0 x  � ��� l  	 #���� Z  	 #���k�j� G   	 ��� =  	 ��� o   	 
�i�i 0 x  � m   
 �h�h Z� =   ��� o    �g�g 0 x  � m    �f�f� R    �e��
�e .ascrerr ****      � ****� m    �� ��� F I n v a l i d   n u m b e r   ( r e s u l t   w o u l d   b e  " ) .� �d��
�d 
errn� m    �c�c�s� �b��a
�b 
erob� o    �`�` 0 x  �a  �k  �j  � 4 . -2701 normally indicates divide-by-zero error   � ��� \   - 2 7 0 1   n o r m a l l y   i n d i c a t e s   d i v i d e - b y - z e r o   e r r o r� ��� l  $ -���� r   $ -��� ]   $ +��� l  $ '��_�^� `   $ '��� o   $ %�]�] 0 x  � m   % &�\�\h�_  �^  � l  ' *��[�Z� ^   ' *��� 1   ' (�Y
�Y 
pi  � m   ( )�X�X ��[  �Z  � o      �W�W 0 x  � &   convert from degrees to radians   � ��� @   c o n v e r t   f r o m   d e g r e e s   t o   r a d i a n s� ��� r   . 3��� A   . 1��� o   . /�V�V 0 x  � m   / 0�U�U  � o      �T�T 0 isneg isNeg� ��� Z  4 @���S�R� o   4 5�Q�Q 0 isneg isNeg� r   8 <��� d   8 :�� o   8 9�P�P 0 x  � o      �O�O 0 x  �S  �R  � ��� r   A J��� _   A H��� l  A F��N�M� ^   A F��� o   A B�L�L 0 x  � l  B E��K�J� ^   B E��� 1   B C�I
�I 
pi  � m   C D�H�H �K  �J  �N  �M  � m   F G�G�G � o      �F�F 0 y  � ��� r   K V��� \   K T��� o   K L�E�E 0 y  � ]   L S��� l  L Q��D�C� _   L Q��� ]   L O��� o   L M�B�B 0 y  � m   M N�� ?�      � m   O P�A�A �D  �C  � m   Q R�@�@ � o      �?�? 0 z  � ��� Z   W n���>�=� =  W \��� `   W Z��� o   W X�<�< 0 z  � m   X Y�;�; � m   Z [�:�: � k   _ j�� ��� r   _ d��� [   _ b��� o   _ `�9�9 0 z  � m   ` a�8�8 � o      �7�7 0 z  � ��6� r   e j��� [   e h��� o   e f�5�5 0 y  � m   f g�4�4 � o      �3�3 0 y  �6  �>  �=  � ��� r   o ���� \   o ~� � l  o x�2�1 \   o x l  o t�0�/ \   o t o   o p�.�. 0 x   ]   p s o   p q�-�- 0 y   m   q r		 ?�!�P M�0  �/   ]   t w

 o   t u�,�, 0 y   m   u v >A�`  �2  �1    ]   x } o   x y�+�+ 0 y   m   y | <��&3\� o      �*�* 0 z2  �  r   � � ]   � � o   � ��)�) 0 z2   o   � ��(�( 0 z2   o      �'�' 0 zz    Z   � ��& ?   � � o   � ��%�% 0 zz   m   � � =����+� r   � � [   � � !  o   � ��$�$ 0 z2  ! ^   � �"#" ]   � �$%$ ]   � �&'& o   � ��#�# 0 z2  ' o   � ��"�" 0 zz  % l  � �(�!� ( \   � �)*) ]   � �+,+ l  � �-��- [   � �./. ]   � �010 m   � �22 �ɒ��O?D1 o   � ��� 0 zz  / m   � �33 A1������  �  , o   � ��� 0 zz  * m   � �44 Aq��)�y�!  �   # l  � �5��5 \   � �676 ]   � �898 l  � �:��: [   � �;<; ]   � �=>= l  � �?��? \   � �@A@ ]   � �BCB l  � �D��D [   � �EFE o   � ��� 0 zz  F m   � �GG @ʸ��et�  �  C o   � ��� 0 zz  A m   � �HH A4'�X*���  �  > o   � ��� 0 zz  < m   � �II Awُ�����  �  9 o   � ��� 0 zz  7 m   � �JJ A���<�Z6�  �   o      �� 0 y  �&   r   � �KLK o   � ��� 0 z2  L o      �� 0 y   MNM Z  � �OP��O G   � �QRQ =  � �STS o   � ��
�
 0 z  T m   � ��	�	 R =  � �UVU o   � ��� 0 z  V m   � ��� P r   � �WXW ^   � �YZY m   � �����Z o   � ��� 0 y  X o      �� 0 y  �  �  N [\[ Z  � �]^��] o   � ��� 0 isneg isNeg^ r   � �_`_ d   � �aa o   � �� �  0 y  ` o      ���� 0 y  �  �  \ b��b L   � �cc o   � ����� 0 y  ��  � R      ��de
�� .ascrerr ****      � ****d o      ���� 0 etext eTexte ��fg
�� 
errnf o      ���� 0 enumber eNumberg ��hi
�� 
erobh o      ���� 0 efrom eFromi ��j��
�� 
errtj o      ���� 
0 eto eTo��  � I   ���k���� 
0 _error  k lml m   � �nn �oo  t a nm pqp o   � ����� 0 etext eTextq rsr o   � ����� 0 enumber eNumbers tut o   � ����� 0 efrom eFromu v��v o   � ����� 
0 eto eTo��  ��  �o  � wxw l     ��������  ��  ��  x yzy l     ��������  ��  ��  z {|{ l     ��}~��  }  -----   ~ � 
 - - - - -| ��� l     ������  �   inverse   � ���    i n v e r s e� ��� l     ��������  ��  ��  � ��� i  z }��� I      ������� 	0 _asin  � ���� o      ���� 0 x  ��  ��  � k     ��� ��� r     ��� A     ��� o     ���� 0 x  � m    ����  � o      ���� 0 isneg isNeg� ��� Z   ������� o    ���� 0 isneg isNeg� r   
 ��� d   
 �� o   
 ���� 0 x  � o      ���� 0 x  ��  ��  � ��� Z   %������� ?    ��� o    ���� 0 x  � m    ���� � R    !����
�� .ascrerr ****      � ****� m     �� ��� T I n v a l i d   n u m b e r   ( n o t   b e t w e e n   - 1 . 0   a n d   1 . 0 ) .� ����
�� 
errn� m    �����Y� �����
�� 
erob� o    ���� 0 x  ��  ��  ��  � ��� Z   & ������ ?   & )��� o   & '���� 0 x  � m   ' (�� ?�      � k   , �� ��� r   , 1��� \   , /��� m   , -���� � o   - .���� 0 x  � o      ���� 0 zz  � ��� r   2 W��� ^   2 U��� ]   2 E��� o   2 3���� 0 zz  � l  3 D������ [   3 D��� ]   3 B��� l  3 @������ \   3 @��� ]   3 >��� l  3 <������ [   3 <��� ]   3 :��� l  3 8������ \   3 8��� ]   3 6��� m   3 4�� ?hOØ��� o   4 5���� 0 zz  � m   6 7�� ?��Y�,���  ��  � o   8 9���� 0 zz  � m   : ;�� @����?���  ��  � o   < =���� 0 zz  � m   > ?�� @9����"��  ��  � o   @ A���� 0 zz  � m   B C�� @<�b@����  ��  � l  E T������ [   E T��� ]   E R��� l  E P������ \   E P��� ]   E N��� l  E L������ [   E L��� ]   E J��� l  E H������ \   E H��� o   E F���� 0 zz  � m   F G�� @5򢶿]R��  ��  � o   H I���� 0 zz  � m   J K�� @bb�j1��  ��  � o   L M���� 0 zz  � m   N O�� @w���c���  ��  � o   P Q���� 0 zz  � m   R S�� @ug	��D���  ��  � o      ���� 0 p  � ��� r   X _��� a   X ]��� l  X [������ [   X [��� o   X Y���� 0 zz  � o   Y Z���� 0 zz  ��  ��  � m   [ \�� ?�      � o      ���� 0 zz  � ��� r   ` i��� \   ` g��� l  ` e������ ^   ` e   1   ` c��
�� 
pi   m   c d���� ��  ��  � o   e f���� 0 zz  � o      ���� 0 z  �  r   j s \   j q ]   j m	 o   j k���� 0 zz  	 o   k l���� 0 p   m   m p

 <��&3\
 o      ���� 0 zz   �� r   t  [   t } \   t w o   t u���� 0 z   o   u v���� 0 zz   l  w |���� ^   w | 1   w z��
�� 
pi   m   z {���� ��  ��   o      ���� 0 z  ��  �  A   � � o   � ����� 0 x   m   � � >Ey��0�: �� r   � � o   � ����� 0 x   o      ���� 0 z  ��  � k   � �  r   � � !  ]   � �"#" o   � ����� 0 x  # o   � ����� 0 x  ! o      ���� 0 zz   $��$ r   � �%&% [   � �'(' ]   � �)*) ^   � �+,+ ]   � �-.- o   � ����� 0 zz  . l  � �/����/ \   � �010 ]   � �232 l  � �4����4 [   � �565 ]   � �787 l  � �9����9 \   � �:;: ]   � �<=< l  � �>����> [   � �?@? ]   � �ABA l  � �C����C \   � �DED ]   � �FGF m   � �HH ?qk��v�G o   � ����� 0 zz  E m   � �II ?�CA3>M���  ��  B o   � ����� 0 zz  @ m   � �JJ @�K�/��  ��  = o   � ����� 0 zz  ; m   � �KK @0C1�'����  ��  8 o   � ����� 0 zz  6 m   � �LL @3��w����  ��  3 o   � ����� 0 zz  1 m   � �MM @ elΰ8��  ��  , l  � �N��~N \   � �OPO ]   � �QRQ l  � �S�}�|S [   � �TUT ]   � �VWV l  � �X�{�zX \   � �YZY ]   � �[\[ l  � �]�y�x] [   � �^_^ ]   � �`a` l  � �b�w�vb \   � �cdc o   � ��u�u 0 zz  d m   � �ee @-{Y^��w  �v  a o   � ��t�t 0 zz  _ m   � �ff @Q��%��6�y  �x  \ o   � ��s�s 0 zz  Z m   � �gg @be�m5v��{  �z  W o   � ��r�r 0 zz  U m   � �hh @apV�����}  �|  R o   � ��q�q 0 zz  P m   � �ii @H�"
6��  �~  * o   � ��p�p 0 x  ( o   � ��o�o 0 x  & o      �n�n 0 z  ��  � jkj Z  � �lm�m�ll o   � ��k�k 0 isneg isNegm r   � �non d   � �pp o   � ��j�j 0 z  o o      �i�i 0 z  �m  �l  k q�hq L   � �rr ^   � �sts o   � ��g�g 0 z  t l  � �u�f�eu ^   � �vwv 1   � ��d
�d 
pi  w m   � ��c�c ��f  �e  �h  � xyx l     �b�a�`�b  �a  �`  y z{z l     �_�^�]�_  �^  �]  { |}| l     �\�[�Z�\  �[  �Z  } ~~ i  ~ ���� I     �Y��X
�Y .Mth:Sinanull���     doub� o      �W�W 0 x  �X  � Q     ���� L    �� I    �V��U�V 	0 _asin  � ��T� c    ��� o    �S�S 0 x  � m    �R
�R 
nmbr�T  �U  � R      �Q��
�Q .ascrerr ****      � ****� o      �P�P 0 etext eText� �O��
�O 
errn� o      �N�N 0 enumber eNumber� �M��
�M 
erob� o      �L�L 0 efrom eFrom� �K��J
�K 
errt� o      �I�I 
0 eto eTo�J  � I    �H��G�H 
0 _error  � ��� m    �� ���  a s i n� ��� o    �F�F 0 etext eText� ��� o    �E�E 0 enumber eNumber� ��� o    �D�D 0 efrom eFrom� ��C� o    �B�B 
0 eto eTo�C  �G   ��� l     �A�@�?�A  �@  �?  � ��� l     �>�=�<�>  �=  �<  � ��� i  � ���� I     �;��:
�; .Mth:Cosanull���     doub� o      �9�9 0 x  �:  � Q      ���� L    �� \    ��� m    �8�8 Z� l   ��7�6� I    �5��4�5 	0 _asin  � ��3� c    ��� o    �2�2 0 x  � m    �1
�1 
nmbr�3  �4  �7  �6  � R      �0��
�0 .ascrerr ****      � ****� o      �/�/ 0 etext eText� �.��
�. 
errn� o      �-�- 0 enumber eNumber� �,��
�, 
erob� o      �+�+ 0 efrom eFrom� �*��)
�* 
errt� o      �(�( 
0 eto eTo�)  � I     �'��&�' 
0 _error  � ��� m    �� ���  a c o s� ��� o    �%�% 0 etext eText� ��� o    �$�$ 0 enumber eNumber� ��� o    �#�# 0 efrom eFrom� ��"� o    �!�! 
0 eto eTo�"  �&  � ��� l     � ���   �  �  � ��� l     ����  �  �  � ��� i  � ���� I     ���
� .Mth:Tananull���     doub� o      �� 0 x  �  � Q     *���� k    �� ��� r    ��� c    ��� o    �� 0 x  � m    �
� 
nmbr� o      �� 0 x  � ��� L   	 �� I   	 ���� 	0 _asin  � ��� ^   
 ��� o   
 �� 0 x  � l   ���� a    ��� l   ���� [    ��� ]    ��� o    �� 0 x  � o    �
�
 0 x  � m    �	�	 �  �  � m    �� ?�      �  �  �  �  �  � R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      � �  
0 eto eTo�  � I     *������� 
0 _error  � ��� m   ! "�� ���  a t a n� ��� o   " #���� 0 etext eText� ��� o   # $���� 0 enumber eNumber� ��� o   $ %���� 0 efrom eFrom� ���� o   % &���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     �� ��     -----    � 
 - - - - -�  l     ����     hyperbolic    �    h y p e r b o l i c 	 l     ��������  ��  ��  	 

 i  � � I     ����
�� .Mth:Sinhnull���     doub o      ���� 0 x  ��   Q     . k      r     c     o    ���� 0 x   m    ��
�� 
nmbr o      ���� 0 x   �� L   	  ]   	  m   	 
 ?�       l  
 ���� \   
   a   
 !"! o   
 ���� 	0 __e__  " o    ���� 0 x    a    #$# o    ���� 	0 __e__  $ d    %% o    ���� 0 x  ��  ��  ��   R      ��&'
�� .ascrerr ****      � ****& o      ���� 0 etext eText' ��()
�� 
errn( o      ���� 0 enumber eNumber) ��*+
�� 
erob* o      ���� 0 efrom eFrom+ ��,��
�� 
errt, o      ���� 
0 eto eTo��   I   $ .��-���� 
0 _error  - ./. m   % &00 �11 
 a s i n h/ 232 o   & '���� 0 etext eText3 454 o   ' (���� 0 enumber eNumber5 676 o   ( )���� 0 efrom eFrom7 8��8 o   ) *���� 
0 eto eTo��  ��   9:9 l     ��������  ��  ��  : ;<; l     ��������  ��  ��  < =>= i  � �?@? I     ��A��
�� .Mth:Coshnull���     doubA o      ���� 0 x  ��  @ Q     .BCDB k    EE FGF r    HIH c    JKJ o    ���� 0 x  K m    ��
�� 
nmbrI o      ���� 0 x  G L��L L   	 MM ]   	 NON m   	 
PP ?�      O l  
 Q����Q [   
 RSR a   
 TUT o   
 ���� 	0 __e__  U o    ���� 0 x  S a    VWV o    ���� 	0 __e__  W d    XX o    ���� 0 x  ��  ��  ��  C R      ��YZ
�� .ascrerr ****      � ****Y o      ���� 0 etext eTextZ ��[\
�� 
errn[ o      ���� 0 enumber eNumber\ ��]^
�� 
erob] o      ���� 0 efrom eFrom^ ��_��
�� 
errt_ o      ���� 
0 eto eTo��  D I   $ .��`���� 
0 _error  ` aba m   % &cc �dd 
 a c o s hb efe o   & '���� 0 etext eTextf ghg o   ' (���� 0 enumber eNumberh iji o   ( )���� 0 efrom eFromj k��k o   ) *���� 
0 eto eTo��  ��  > lml l     ��������  ��  ��  m non l     ��������  ��  ��  o pqp i  � �rsr I     ��t��
�� .Mth:Tanhnull���     doubt o      ���� 0 x  ��  s Q     =uvwu k    +xx yzy r    {|{ c    }~} o    ���� 0 x  ~ m    ��
�� 
nmbr| o      ���� 0 x  z �� L   	 +�� ^   	 *��� l  	 ������ \   	 ��� a   	 ��� o   	 ���� 	0 __e__  � o    ���� 0 x  � a    ��� o    ���� 	0 __e__  � d    �� o    ���� 0 x  ��  ��  � l   )������ [    )��� a     ��� o    ���� 	0 __e__  � o    ���� 0 x  � a     (��� o     %���� 	0 __e__  � d   % '�� o   % &���� 0 x  ��  ��  ��  v R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  w I   3 =������� 
0 _error  � ��� m   4 5�� ��� 
 a t a n h� ��� o   5 6���� 0 etext eText� ��� o   6 7���� 0 enumber eNumber� ��� o   7 8���� 0 efrom eFrom� ���� o   8 9���� 
0 eto eTo��  ��  q ��� l     ��������  ��  ��  � ��� l     �������  ��  �  � ��� l     �~���~  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �}���}  �   Logarithms   � ���    L o g a r i t h m s� ��� l     �|�{�z�|  �{  �z  � ��� i  � ���� I      �y��x�y 
0 _frexp  � ��w� o      �v�v 0 m  �w  �x  � k     n�� ��� Z    ���u�t� =    ��� o     �s�s 0 m  � m    �r�r  � L    �� J    
�� ��� m    ��         � ��q� m    �p�p  �q  �u  �t  � ��� r    ��� A    ��� o    �o�o 0 m  � m    �n�n  � o      �m�m 0 isneg isNeg� ��� Z   "���l�k� o    �j�j 0 isneg isNeg� r    ��� d    �� o    �i�i 0 m  � o      �h�h 0 m  �l  �k  � ��� r   # &��� m   # $�g�g  � o      �f�f 0 e  � ��� W   ' [��� Z   7 V���e�� @   7 :��� o   7 8�d�d 0 m  � m   8 9�c�c � k   = H�� ��� r   = B��� ^   = @��� o   = >�b�b 0 m  � m   > ?�a�a � o      �`�` 0 m  � ��_� r   C H��� [   C F��� o   C D�^�^ 0 e  � m   D E�]�] � o      �\�\ 0 e  �_  �e  � k   K V�� ��� r   K P��� ]   K N��� o   K L�[�[ 0 m  � m   L M�Z�Z � o      �Y�Y 0 m  � ��X� r   Q V��� \   Q T��� o   Q R�W�W 0 e  � m   R S�V�V � o      �U�U 0 e  �X  � F   + 6��� @   + .��� o   + ,�T�T 0 m  � m   , -�� ?�      � A   1 4   o   1 2�S�S 0 m   m   2 3�R�R �  Z  \ h�Q�P o   \ ]�O�O 0 isneg isNeg r   ` d d   ` b o   ` a�N�N 0 m   o      �M�M 0 m  �Q  �P   	�L	 L   i n

 J   i m  o   i j�K�K 0 m   �J o   j k�I�I 0 e  �J  �L  �  l     �H�G�F�H  �G  �F    l     �E�D�C�E  �D  �C    i  � � I      �B�A�B 	0 _logn   �@ o      �?�? 0 x  �@  �A   k    ;  Z    �>�= B      o     �<�< 0 x   m    �;�;   R    �: !
�: .ascrerr ****      � ****  m   
 "" �## 8 I n v a l i d   n u m b e r   ( m u s t   b e   > 0 ) .! �9$�8
�9 
errn$ m    	�7�7�Y�8  �>  �=   %&% r    &'(' I      �6)�5�6 
0 _frexp  ) *�4* o    �3�3 0 x  �4  �5  ( J      ++ ,-, o      �2�2 0 x  - .�1. o      �0�0 0 e  �1  & /0/ Z   '812�/31 G   ' 2454 A   ' *676 o   ' (�.�. 0 e  7 m   ( )�-�-��5 ?   - 0898 o   - .�,�, 0 e  9 m   . /�+�+ 2 k   5 �:: ;<; Z   5 ^=>�*?= A   5 8@A@ o   5 6�)�) 0 x  A m   6 7BB ?栞fK�> l  ; NCDEC k   ; NFF GHG r   ; @IJI \   ; >KLK o   ; <�(�( 0 e  L m   < =�'�' J o      �&�& 0 e  H MNM r   A FOPO \   A DQRQ o   A B�%�% 0 x  R m   B CSS ?�      P o      �$�$ 0 z  N T�#T r   G NUVU [   G LWXW ]   G JYZY m   G H[[ ?�      Z o   H I�"�" 0 z  X m   J K\\ ?�      V o      �!�! 0 y  �#  D   (2 ^ 0.5) / 2   E �]]    ( 2   ^   0 . 5 )   /   2�*  ? k   Q ^^^ _`_ r   Q Vaba \   Q Tcdc o   Q R� �  0 x  d m   R S�� b o      �� 0 z  ` e�e r   W ^fgf [   W \hih ]   W Zjkj m   W Xll ?�      k o   X Y�� 0 x  i m   Z [mm ?�      g o      �� 0 y  �  < non r   _ dpqp ^   _ brsr o   _ `�� 0 z  s o   ` a�� 0 y  q o      �� 0 x  o tut r   e jvwv ]   e hxyx o   e f�� 0 x  y o   f g�� 0 x  w o      �� 0 z  u z{z r   k �|}| ^   k �~~ ]   k x��� ]   k n��� o   k l�� 0 x  � o   l m�� 0 z  � l  n w���� \   n w��� ]   n u��� l  n s���� [   n s��� ]   n q��� m   n o�� ��D=�l�� o   o p�� 0 z  � m   q r�� @0b�s{��  �  � o   s t�� 0 z  � m   u v�� @P	"*?�  �   l  x ����� \   x ���� ]   x ���� l  x ��
�	� [   x ��� ]   x }��� l  x {���� \   x {��� o   x y�� 0 z  � m   y z�� @A�C�l��  �  � o   { |�� 0 z  � m   } ~�� @s��*�
�
  �	  � o    ��� 0 z  � m   � ��� @���?;�  �  } o      �� 0 z  { ��� r   � ���� o   � ��� 0 e  � o      �� 0 y  � �� � r   � ���� [   � ���� [   � ���� \   � ���� o   � ����� 0 z  � ]   � ���� o   � ����� 0 y  � m   � ��� ?+�\a�� o   � ����� 0 x  � ]   � ���� o   � ����� 0 e  � m   � ��� ?�0     � o      ���� 0 z  �   �/  3 k   �8�� ��� Z   � ������� A   � ���� o   � ����� 0 x  � m   � ��� ?栞fK�� l  � ����� k   � ��� ��� r   � ���� \   � ���� o   � ����� 0 e  � m   � ����� � o      ���� 0 e  � ���� r   � ���� \   � ���� ]   � ���� m   � ����� � o   � ����� 0 x  � m   � ����� � o      ���� 0 x  ��  �   (2 ^ 0.5) / 2   � ���    ( 2   ^   0 . 5 )   /   2��  � r   � ���� \   � ���� o   � ����� 0 x  � m   � ����� � o      ���� 0 x  � ��� r   � ���� ]   � ���� o   � ����� 0 x  � o   � ����� 0 x  � o      ���� 0 z  � ��� r   ���� ^   ���� ]   � ���� ]   � ���� o   � ����� 0 x  � o   � ����� 0 z  � l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� m   � ��� ?���� o   � ����� 0 x  � m   � ��� ?���?Vd���  ��  � o   � ����� 0 x  � m   � ��� @Һ�i���  ��  � o   � ����� 0 x  � m   � ��� @,�r�>����  ��  � o   � ����� 0 x  � m   � �   @1�֒K�R��  ��  � o   � ����� 0 x  � m   � � @�c}~ݝ��  ��  � l  ����� [   � ]   � � l  � ����� [   � �	 ]   � �

 l  � ����� [   � � ]   � � l  � ����� [   � � ]   � � l  � ����� [   � � o   � ����� 0 x   m   � � @&� �����  ��   o   � ����� 0 x   m   � � @F�,N���  ��   o   � ����� 0 x   m   � � @T�3�&����  ��   o   � ����� 0 x  	 m   � � @Q���^���  ��   o   � ����� 0 x   m   �  @7 
�&5��  ��  � o      ���� 0 y  �  Z   !����  >  "#" o  ���� 0 e  # m  ����  ! r  $%$ \  &'& o  ���� 0 y  ' ]  ()( o  ���� 0 e  ) m  ** ?+�\a�% o      ���� 0 y  ��  ��   +,+ r  -.- \  /0/ o  ���� 0 y  0 l 1����1 ^  232 o  ���� 0 z  3 m  ���� ��  ��  . o      ���� 0 y  , 454 r  $676 [  "898 o   ���� 0 x  9 o   !���� 0 y  7 o      ���� 0 z  5 :��: Z %8;<����; >  %(=>= o  %&���� 0 e  > m  &'����  < r  +4?@? [  +2ABA o  +,���� 0 z  B ]  ,1CDC o  ,-���� 0 e  D m  -0EE ?�0     @ o      ���� 0 z  ��  ��  ��  0 F��F L  9;GG o  9:���� 0 z  ��   HIH l     ��������  ��  ��  I JKJ l     ��������  ��  ��  K LML l     ��������  ��  ��  M NON i  � �PQP I     ��R��
�� .Mth:Lognnull���     doubR o      ���� 0 x  ��  Q Q     STUS L    VV I    ��W���� 	0 _logn  W X��X c    YZY o    ���� 0 x  Z m    ��
�� 
nmbr��  ��  T R      ��[\
�� .ascrerr ****      � ****[ o      ���� 0 etext eText\ ��]^
�� 
errn] o      ���� 0 enumber eNumber^ ��_`
�� 
erob_ o      ���� 0 efrom eFrom` ��a��
�� 
errta o      ���� 
0 eto eTo��  U I    ��b���� 
0 _error  b cdc m    ee �ff  l o g nd ghg o    ���� 0 etext eTexth iji o    ���� 0 enumber eNumberj klk o    ���� 0 efrom eFroml m��m o    �� 
0 eto eTo��  ��  O non l     ����  �  �  o pqp l     ����  �  �  q rsr i  � �tut I     �v�
� .Mth:Lo10null���     doubv o      �� 0 x  �  u Q     $wxyw l   z{|z L    }} ^    ~~ ]    ��� l   ���� ^    ��� I    ���� 	0 _logn  � ��� c    ��� o    �� 0 x  � m    �
� 
nmbr�  �  � m    �� @k���T��  �  � m    �� @r�      m    �� @r�    j{   correct for minor drift   | ��� 0   c o r r e c t   f o r   m i n o r   d r i f tx R      �~��
�~ .ascrerr ****      � ****� o      �}�} 0 etext eText� �|��
�| 
errn� o      �{�{ 0 enumber eNumber� �z��
�z 
erob� o      �y�y 0 efrom eFrom� �x��w
�x 
errt� o      �v�v 
0 eto eTo�w  y I    $�u��t�u 
0 _error  � ��� m    �� ��� 
 l o g 1 0� ��� o    �s�s 0 etext eText� ��� o    �r�r 0 enumber eNumber� ��� o    �q�q 0 efrom eFrom� ��p� o     �o�o 
0 eto eTo�p  �t  s ��� l     �n�m�l�n  �m  �l  � ��� l     �k�j�i�k  �j  �i  � ��� i  � ���� I     �h��
�h .Mth:Logbnull���     doub� o      �g�g 0 x  � �f��e
�f 
Base� o      �d�d 0 b  �e  � Q     '���� L    �� ^    ��� I    �c��b�c 	0 _logn  � ��a� c    ��� o    �`�` 0 x  � m    �_
�_ 
nmbr�a  �b  � l   ��^�]� I    �\��[�\ 	0 _logn  � ��Z� c    ��� o    �Y�Y 0 b  � m    �X
�X 
nmbr�Z  �[  �^  �]  � R      �W��
�W .ascrerr ****      � ****� o      �V�V 0 etext eText� �U��
�U 
errn� o      �T�T 0 enumber eNumber� �S��
�S 
erob� o      �R�R 0 efrom eFrom� �Q��P
�Q 
errt� o      �O�O 
0 eto eTo�P  � I    '�N��M�N 
0 _error  � ��� m    �� ���  l o g b� ��� o     �L�L 0 etext eText� ��� o     !�K�K 0 enumber eNumber� ��� o   ! "�J�J 0 efrom eFrom� ��I� o   " #�H�H 
0 eto eTo�I  �M  � ��� l     �G�F�E�G  �F  �E  � ��D� l     �C�B�A�C  �B  �A  �D       (�@���� h r ~ ���������������������������������@  � &�?�>�=�<�;�:�9�8�7�6�5�4�3�2�1�0�/�.�-�,�+�*�)�(�'�&�%�$�#�"�!� ������
�? 
pimr�> 0 _support  �= 
0 _error  �< 	0 __e__  �; 0 _isequaldelta _isEqualDelta�: $0 _mindecimalrange _minDecimalRange�9 $0 _maxdecimalrange _maxDecimalRange�8 (0 _asintegerproperty _asIntegerProperty�7 ,0 _makenumberformatter _makeNumberFormatter�6 "0 _setbasicformat _setBasicFormat�5  0 _nameforformat _nameForFormat
�4 .Mth:FNumnull���     nmbr
�3 .Mth:PNumnull���     ctxt
�2 .Mth:NuHenull���     ****
�1 .Mth:HeNunull���     ctxt
�0 .Mth:DeRanull���     doub
�/ .Mth:RaDenull���     doub
�. .Mth:Abs_null���     nmbr
�- .Mth:CmpNnull���     ****
�, .Mth:MinNnull���     ****
�+ .Mth:MaxNnull���     ****
�* .Mth:RouNnull���     nmbr�) 0 _sin  
�( .Mth:Sin_null���     doub
�' .Mth:Cos_null���     doub
�& .Mth:Tan_null���     doub�% 	0 _asin  
�$ .Mth:Sinanull���     doub
�# .Mth:Cosanull���     doub
�" .Mth:Tananull���     doub
�! .Mth:Sinhnull���     doub
�  .Mth:Coshnull���     doub
� .Mth:Tanhnull���     doub� 
0 _frexp  � 	0 _logn  
� .Mth:Lognnull���     doub
� .Mth:Lo10null���     doub
� .Mth:Logbnull���     doub� ��� �  ��� ���
� 
cobj� ��   � 
� 
frmk�  � ���
� 
cobj� ��   �
� 
osax�  � ��   � /
� 
scpt� � 7������ 
0 _error  � ��� �  ���
�	�� 0 handlername handlerName� 0 etext eText�
 0 enumber eNumber�	 0 efrom eFrom� 
0 eto eTo�  � ������ 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo�  G��� � &0 throwcommanderror throwCommandError� b  ࠡ����+ � �  ����������  (0 _asintegerproperty _asIntegerProperty�� �� ��    �������� 0 thevalue theValue�� 0 propertyname propertyName�� 0 minvalue minValue��  � ���������� 0 thevalue theValue�� 0 propertyname propertyName�� 0 minvalue minValue�� 0 n  � 	������������ � �
�� 
long
�� 
doub
�� 
bool
�� 
errn���Y��   ������
�� 
errn���Y��  �� 9 (��&E�O���&
 ���& )��lhY hO�W X  )��l�%�%� �� ��������� ,0 _makenumberformatter _makeNumberFormatter�� ����   �������� 0 formatstyle formatStyle�� 0 
localecode 
localeCode�� 0 	thenumber 	theNumber��   ���������������� 0 formatstyle formatStyle�� 0 
localecode 
localeCode�� 0 	thenumber 	theNumber�� 0 asocformatter asocFormatter�� 0 formatrecord formatRecord�� 0 s  �� 0 etext eText G��������������������������������������������=��������\u��������������������������������r���������
�� misccura�� &0 nsnumberformatter NSNumberFormatter�� 	0 alloc  �� 0 init  
�� 
kocl
�� 
reco
�� .corecnte****       ****
�� 
pcls
�� 
MthR
�� 
MthA�� 0 requiredvalue RequiredValue
�� 
MthB
�� 
msng
�� 
MthC
�� 
MthD
�� 
MthE
�� 
MthF
�� 
MthG
�� 
MthH�� �� 60 asoptionalrecordparameter asOptionalRecordParameter�� "0 _setbasicformat _setBasicFormat�� (0 _asintegerproperty _asIntegerProperty�� 60 setminimumfractiondigits_ setMinimumFractionDigits_����� 60 setmaximumfractiondigits_ setMaximumFractionDigits_�� <0 setminimumsignificantdigits_ setMinimumSignificantDigits_�� 60 setusessignificantdigits_ setUsesSignificantDigits_�� <0 setmaximumsignificantdigits_ setMaximumSignificantDigits_
� 
ctxt
� 
leng
� 
errn��Y� ,0 setdecimalseparator_ setDecimalSeparator_�   ���
� 
errn��\�  � 60 setusesgroupingseparator_ setUsesGroupingSeparator_� .0 setgroupingseparator_ setGroupingSeparator_
� MRndRNhE� @0 nsnumberformatterroundhalfeven NSNumberFormatterRoundHalfEven� $0 setroundingmode_ setRoundingMode_
� MRndRNhT� @0 nsnumberformatterroundhalfdown NSNumberFormatterRoundHalfDown
� MRndRNhF� <0 nsnumberformatterroundhalfup NSNumberFormatterRoundHalfUp
� MRndRN_T� 80 nsnumberformatterrounddown NSNumberFormatterRoundDown
� MRndRN_F� 40 nsnumberformatterroundup NSNumberFormatterRoundUp
� MRndRN_U� >0 nsnumberformatterroundceiling NSNumberFormatterRoundCeiling
� MRndRN_D� :0 nsnumberformatterroundfloor NSNumberFormatterRoundFloor ���
� 
errn��Y�  � 0 etext eText
� 
enum� � .0 throwinvalidparameter throwInvalidParameter� *0 asnslocaleparameter asNSLocaleParameter� 0 
setlocale_ 
setLocale_�����,j+ j+ E�Og�kv��l k =b  ����b  �,��������a �a �a �a a m+ E�O*���,�m+ O��,� �*��,a jm+ k+ O�a k+ Y hO��,� �*��,a jm+ k+ Y hO��,� �*��,a jm+ k+ O�ek+ Y hO��,� �*��,a  jm+ k+ !O�ek+ Y hO�a ,� G 0�a ,a "&E�O�a #,j  )a $a %lhY hO��k+ &W X ' ()a $a %la )Y hO�a ,� H 1�a ,a "&E�O�a #,j  �fk+ *Y �ek+ *O��k+ +W X ' ()a $a %la ,Y hO�a ,� ��a ,a -  ��a .,k+ /Y ��a ,a 0  ��a 1,k+ /Y ��a ,a 2  ��a 3,k+ /Y r�a ,a 4  ��a 5,k+ /Y Y�a ,a 6  ��a 7,k+ /Y @�a ,a 8  ��a 9,k+ /Y '�a ,a :  ��a ;,k+ /Y )a $a %la <Y hY  *���m+ W X ' =)ja >W X ? =b  �a @�a Alv�a B+ CO�b  �a Dl+ Ek+ FO�� ������ "0 _setbasicformat _setBasicFormat� �	� 	  ���� 0 asocformatter asocFormatter� 0 
formatname 
formatName� 0 	thenumber 	theNumber�   ���� 0 asocformatter asocFormatter� 0 
formatname 
formatName� 0 	thenumber 	theNumber #��������������������~�}�|�{�z�y�x�w�v�u�t�s�r�q�p�
� MthZMth0
� 
msng
� misccura� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� "0 setnumberstyle_ setNumberStyle_
� 
pcls
� 
long� 40 nsnumberformatternostyle NSNumberFormatterNoStyle
� 
bool� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle� 60 setminimumfractiondigits_ setMinimumFractionDigits_��� 60 setmaximumfractiondigits_ setMaximumFractionDigits_� 60 setusesgroupingseparator_ setUsesGroupingSeparator_� B0 setalwaysshowsdecimalseparator_ setAlwaysShowsDecimalSeparator_
� MthZMth3
� MthZMth1
� MthZMth2
� MthZMth5�~ @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle
�} MthZMth4�| >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle
�{ MthZMth6�z @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle
�y 
kocl
�x 
ctxt
�w .corecnte****       ****�v 0 
setformat_ 
setFormat_
�u 
errn�t�Y
�s 
erob
�r 
errt
�q 
enum�p �S��  ���  ���,k+ Y ���,�  ���,k+ Y ~b  '�	 �b  '�&
 b  �	 �b  �&�&
 �j �& )���,k+ O�kk+ 
O��k+ O�fk+ O�ek+ Y ���,k+ O�kk+ 
O��k+ O�ek+ Y ���  ���,k+ Y ��a   ���,k+ Y ��a   ���,k+ Y t�a   ��a ,k+ Y _�a   ��a ,k+ Y J�a   ��a ,k+ Y 5�kva a l j ��k+ Y )a a a �a a  a !a "� �o��n�m
�l�o  0 _nameforformat _nameForFormat�n �k�k   �j�j 0 formatstyle formatStyle�m  
 �i�i 0 formatstyle formatStyle �h��g��f��e �d	�c
�h MthZMth1
�g MthZMth2
�f MthZMth5
�e MthZMth4
�d MthZMth3
�c MthZMth6�l I��  �Y ?��  �Y 4��  �Y )��  �Y ��  �Y ��  �Y �%�%� �b+�a�`�_
�b .Mth:FNumnull���     nmbr�a 0 	thenumber 	theNumber�` �^
�^ 
Usin {�]�\�[�] 0 formatstyle formatStyle�\  
�[ MthZMth0 �Z�Y
�Z 
Loca {�X�W7�X 0 
localecode 
localeCode�W  �Y   	�V�U�T�S�R�Q�P�O�N�V 0 	thenumber 	theNumber�U 0 formatstyle formatStyle�T 0 
localecode 
localeCode�S 0 asocformatter asocFormatter�R 0 
asocstring 
asocString�Q 0 etext eText�P 0 enumber eNumber�O 0 efrom eFrom�N 
0 eto eTo �M�L�KSX�J�I�H�G�F�E�D�Cx�B�A��@�?
�M 
kocl
�L 
nmbr
�K .corecnte****       ****�J �I 60 throwinvalidparametertype throwInvalidParameterType�H ,0 _makenumberformatter _makeNumberFormatter�G &0 stringfromnumber_ stringFromNumber_
�F 
msng
�E 
errn�D�Y
�C 
erob
�B 
ctxt�A 0 etext eText �>�=
�> 
errn�= 0 enumber eNumber �<�;
�< 
erob�; 0 efrom eFrom �:�9�8
�: 
errt�9 
0 eto eTo�8  �@ �? 
0 _error  �_ e P�kv��l j  b  �����+ Y hO*���m+ E�O��k+ E�O��  )�����Y hO��&W X  *a ����a + � �7��6�5�4
�7 .Mth:PNumnull���     ctxt�6 0 thetext theText�5 �3
�3 
Usin {�2�1�0�2 0 formatstyle formatStyle�1  
�0 MthZMth0 �/�.
�/ 
Loca {�-�,��- 0 
localecode 
localeCode�,  �.   
�+�*�)�(�'�&�%�$�#�"�+ 0 thetext theText�* 0 formatstyle formatStyle�) 0 
localecode 
localeCode�( 0 asocformatter asocFormatter�' 0 
asocnumber 
asocNumber�& $0 localeidentifier localeIdentifier�% 0 etext eText�$ 0 enumber eNumber�# 0 efrom eFrom�" 
0 eto eTo �!� ������������������/��
�! 
kocl
�  
ctxt
� .corecnte****       ****� � 60 throwinvalidparametertype throwInvalidParameterType
� 
msng� ,0 _makenumberformatter _makeNumberFormatter� &0 numberfromstring_ numberFromString_� 
0 locale  � $0 localeidentifier localeIdentifier
� 
leng
� 
errn��Y
� 
erob�  0 _nameforformat _nameForFormat
� 
****� 0 etext eText ��
� 
errn� 0 enumber eNumber ��
� 
erob� 0 efrom eFrom �
�	�
�
 
errt�	 
0 eto eTo�  � � 
0 _error  �4 � ��kv��l j  b  �����+ Y hO*���m+ E�O��k+ 	E�O��  J�j+ 
j+ �&E�O��,j  �E�Y 	�%�%E�O)a a a ��a *�k+ %a %�%a %Y hO�a &W X  *a ����a + � �K���
� .Mth:NuHenull���     ****� 0 	thenumber 	theNumber� � 
� 
Plac {��� � 0 	chunksize 	chunkSize�  �     ��!��
�� 
Pref! {�������� 0 	hasprefix 	hasPrefix��  
�� boovfals��   ������������������������������ 0 	thenumber 	theNumber�� 0 	chunksize 	chunkSize�� 0 	hasprefix 	hasPrefix�� 0 hextext hexText�� 0 	hexprefix 	hexPrefix�� 0 padtext padText�� 0 maxsize maxSize�� 0 
resultlist 
resultList�� 0 aref aRef�� 0 oldtids oldTIDs�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo >e��t���������������������������������#2H����Y|������"������������#�����������3@��$]������ (0 asintegerparameter asIntegerParameter�� (0 asbooleanparameter asBooleanParameter
�� 
kocl
�� 
list
�� .corecnte****       ****�� 00 aswholenumberparameter asWholeNumberParameter�� 
�� 
bool
�� 
long�� �� .0 throwinvalidparameter throwInvalidParameter������ 
�� 
cobj
�� 
leng�� 0 
resultlist 
resultList" ��%����&'��
�� .ascrinit****      � ****% k     	(( �����  ��  ��  & ���� 
0 _list_  ' ����
�� 
cobj�� 
0 _list_  �� 
b   �-E��� 
0 _list_  
�� 
pcnt
�� 
doub
�� 
errn���\��  # ������
�� 
errn���\��  
�� 
ctxt
�� 
ascr
�� 
txdl�� 0 etext eText$ ����)
�� 
errn�� 0 enumber eNumber) ����*
�� 
erob�� 0 efrom eFrom* �����
�� 
errt�� 
0 eto eTo�  �� �� 
0 _error  ���b  ��l+ E�Ob  ��l+ E�O�kv��l j b  ��l+ E�O�j
 ���& b  �����+ Y hOa E�O�j I�j	 �a �$�& (b  �a �a a �$%a %a �$k%�+ Y hOa E�O�'E�Y Ca E�O�j	 �a �$k�& (b  �a �a a �$%a %a �$k%�+ Y hO� �a %E�Y hO &h�ja a �a #k/�%E�O�a "E�[OY��O h�a ,�a �%E�[OY��O��%Y{�k
 ���& b  �a  �a !�+ Y hOa "a �$klvE[a k/E�Z[a l/E�ZO �kh�a #%E�[OY��Oa $a %K &S�O ӧa ',[�a l kh  ;�a (,�&E�O��a (,a )&
 �j�&
 ���& )a *a +lhY hW :X , -�� b  �a .�a /a �$k%�+ Y b  �a 0�a 1�+ Oa 2E�O &h�ja 3a �a #k/�%E�O�a "E�[OY��O��%[a 4\[Z�'\Zi2�a (,F[OY�AO_ 5a 6,E�Oa 7_ 5a 6,FO� a 8�a ',%E�Y �a ',a 4&E�O�_ 5a 6,FO�W X 9 :*a ;����a <+ =� �m��+,�
� .Mth:HeNunull���     ctxt� 0 hextext hexText� �-.
� 
Plac- {���� 0 	chunksize 	chunkSize�  �  . �/�
� 
Prec/ {���� 0 	isprecise 	isPrecise�  
� boovtrue�  + ������������� 0 hextext hexText� 0 	chunksize 	chunkSize� 0 	isprecise 	isPrecise� 0 	thenumber 	theNumber� 0 
isnegative 
isNegative� 0 charref charRef� 0 i  � 0 
resultlist 
resultList� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo, 2}~���������������������������0��0�TV�]1~����2���� "0 astextparameter asTextParameter� (0 asintegerparameter asIntegerParameter� 
� 
bool
� 
long� � .0 throwinvalidparameter throwInvalidParameter� (0 asbooleanparameter asBooleanParameter
� 
ctxt
� 
kocl
� 
cobj
� .corecnte****       ****� 
� misccura
� 
psof
� 
psin
� .sysooffslong    ��� null
� 
errn��@�  0 ���
� 
errn��@�  ��Y
� 
erob
� 
leng� 0 
resultlist 
resultList1 �3��45�
� .ascrinit****      � ****3 k     66 ]��  �  �  4 �� 
0 _list_  5 �� 
0 _list_  � jv�� 
0 _list_  � 0 etext eText2 ��~7
� 
errn�~ 0 enumber eNumber7 �}�|8
�} 
erob�| 0 efrom eFrom8 �{�z�y
�{ 
errt�z 
0 eto eTo�y  � � 
0 _error  �cN��Fb  ��l+ E�Ob  ��l+ E�O�j
 ���& b  �����+ Y hOb  ��l+ E�O�j  � �jE�O��E�O� �[a \[Zl\Zi2E�Y hO�a  �[a \[Zm\Zi2E�Y hO U�[a a l kh �a  E�Oa  *a �a a � UE�O�j  )a a lhY hO��kE�[OY��W X  )a a a  ��a !O�	 	��k �& )a a a  ��a "Y hO� 	�'E�Y hO�Y�a #,�#j )a a a  ��a $�%a %%Y hOa &a 'K (S�O �k�a #,E�h jE�O |�[a \[Z�\Z��k2[a a l kh �a  E�Oa  *a �a a )� UE�O�j  &)a a a  �[a \[Z�\Z��k2�a *Y hO��kE�[OY��O�	 	��k �& &)a a a  �[a \[Z�\Z��k2�a +Y hO��a ,,6F[OY�<O�a ,,EVW X - .*a /����a 0+ 1� �x��w�v9:�u
�x .Mth:DeRanull���     doub�w 0 x  �v  9 �t�s�r�q�p�t 0 x  �s 0 etext eText�r 0 enumber eNumber�q 0 efrom eFrom�p 
0 eto eTo: �o�n�m�l;	�k�j
�o 
doub
�n 
pi  �m ��l 0 etext eText; �i�h<
�i 
errn�h 0 enumber eNumber< �g�f=
�g 
erob�f 0 efrom eFrom= �e�d�c
�e 
errt�d 
0 eto eTo�c  �k �j 
0 _error  �u  ��&��! W X  *塢���+ � �b	%�a�`>?�_
�b .Mth:RaDenull���     doub�a 0 x  �`  > �^�]�\�[�Z�^ 0 x  �] 0 etext eText�\ 0 enumber eNumber�[ 0 efrom eFrom�Z 
0 eto eTo? �Y�X�W�V@	=�U�T
�Y 
doub
�X 
pi  �W ��V 0 etext eText@ �S�RA
�S 
errn�R 0 enumber eNumberA �Q�PB
�Q 
erob�P 0 efrom eFromB �O�N�M
�O 
errt�N 
0 eto eTo�M  �U �T 
0 _error  �_  ��&��!!W X  *塢���+ � �L	O�K�JCD�I
�L .Mth:Abs_null���     nmbr�K 0 x  �J  C �H�G�F�E�D�H 0 x  �G 0 etext eText�F 0 enumber eNumber�E 0 efrom eFrom�D 
0 eto eToD �C�BE	n�A�@
�C 
nmbr�B 0 etext eTextE �?�>F
�? 
errn�> 0 enumber eNumberF �=�<G
�= 
erob�< 0 efrom eFromG �;�:�9
�; 
errt�: 
0 eto eTo�9  �A �@ 
0 _error  �I * ��&E�O�j �'Y �W X  *㡢���+ � �8	~�7�6HI�5
�8 .Mth:CmpNnull���     ****�7 �4J�4 J  �3�2�3 0 n1  �2 0 n2  �6  H 	�1�0�/�.�-�,�+�*�)�1 0 n1  �0 0 n2  �/ 0 dn  �. 0 dm  �- 0 d  �, 0 etext eText�+ 0 enumber eNumber�* 0 efrom eFrom�) 
0 eto eToI �(�'�&�%�$�#�"K	��!� 
�( 
kocl
�' 
long
�& .corecnte****       ****
�% 
doub
�$ 
cobj
�# 
bool�" 0 etext eTextK ��L
� 
errn� 0 enumber eNumberL ��M
� 
erob� 0 efrom eFromM ���
� 
errt� 
0 eto eTo�  �! �  
0 _error  �5 � ���lv��l l  ��  jY hY s��&��&lvE[�k/E�Z[�l/E�ZO�j  b  � E�Y b  � E�O�'E�O�� ��lvE[�k/E�Z[�l/E�ZY hO��E�O��	 ���& jY hO�� iY kW X  *襦���+ 
� �
��NO�
� .Mth:MinNnull���     ****� 0 thelist theList�  N 	���������� 0 thelist theList� 0 
listobject 
listObject� 0 	theresult 	theResult� 0 aref aRef� 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToO �
P�
�	�����Q
?��� 0 
listobject 
listObjectP �R� ��ST��
� .ascrinit****      � ****R k     UU 
����  �   ��  S ���� 
0 _list_  T ������ "0 aslistparameter asListParameter�� 
0 _list_  �� b  b   k+  ��
 
0 _list_  
�	 
cobj
� 
nmbr
� 
kocl
� .corecnte****       ****
� 
pcnt� 0 etext eTextQ ����V
�� 
errn�� 0 enumber eNumberV ����W
�� 
erob�� 0 efrom eFromW ������
�� 
errt�� 
0 eto eTo��  � � 
0 _error  � X G��K S�O��,�k/�&E�O +��,[��l kh ��,�&E�O�� �E�Y h[OY��O�W X 	 
*륦���+ � ��
O����XY��
�� .Mth:MaxNnull���     ****�� 0 thelist theList��  X 	�������������������� 0 thelist theList�� 0 
listobject 
listObject�� 0 	theresult 	theResult�� 0 aref aRef�� 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToY ��
WZ��������������[
������� 0 
listobject 
listObjectZ ��\����]^��
�� .ascrinit****      � ****\ k     __ 
W����  ��  ��  ] ���� 
0 _list_  ^ ������ "0 aslistparameter asListParameter�� 
0 _list_  �� b  b   k+  ��� 
0 _list_  
�� 
cobj
�� 
nmbr
�� 
kocl
�� .corecnte****       ****
�� 
pcnt�� 0 etext eText[ ����`
�� 
errn�� 0 enumber eNumber` ����a
�� 
erob�� 0 efrom eFroma ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� X G��K S�O��,�k/�&E�O +��,[��l kh ��,�&E�O�� �E�Y h[OY��O�W X 	 
*륦���+ � ��
�����bc��
�� .Mth:RouNnull���     nmbr�� 0 num  �� ��de
�� 
Placd {�������� 0 decimalplaces decimalPlaces��  ��  e ��f��
�� 
Diref {�������� &0 roundingdirection roundingDirection��  
�� MRndRNhE��  b ��������� 0 num  � 0 decimalplaces decimalPlaces� &0 roundingdirection roundingDirection� 0 themultiplier theMultiplier� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToc 
��
����
�
��.��������g0��� "0 asrealparameter asRealParameter� (0 asintegerparameter asIntegerParameter� 

� MRndRNhE
� MRndRNhT
� MRndRNhF
� MRndRN_T
� MRndRN_F
� MRndRN_U
� 
bool
� MRndRN_D� >0 throwinvalidconstantparameter throwInvalidConstantParameter� 0 etext eTextg ��h
� 
errn� 0 enumber eNumberh ��i
� 
erob� 0 efrom eFromi ���
� 
errt� 
0 eto eTo�  � � 
0 _error  ����b  ��l+ E�Ob  ��l+ E�O�j �$E�O�� � �!E�Y hO��  3��lv�l!k#kv 
�k"E�Y �j ��k"E�Y 	��k"E�Y��  1��lv�k#kv 
�k"E�Y �j ��k"E�Y 	��k"E�Y ��  C��lv�k#kv �j �k"kE�Y 	�k"kE�Y �j ��k"E�Y 	��k"E�Y ���  
�k"E�Y ���  ,�k#j  
�k"E�Y �j �k"kE�Y 	�k"kE�Y a��  $�j
 	�k#j �& 
�k"E�Y 	�k"kE�Y 9�a   $�j
 	�k#j �& 
�k"E�Y 	�k"kE�Y b  �a l+ O�j  	�k"Y �j 	��"Y ��!W X  *a ����a + � �L��jk�� 0 _sin  � �l� l  �� 0 x  �  j ������� 0 x  � 0 isneg isNeg� 0 y  � 0 z  � 0 z2  � 0 zz  k �������������� %&'()*�h
� 
pi  � �� � � 
� 
bool� ��#��! E�O�jE�O� 	�'E�Y hO���! k"E�O��� k"� E�O�l#k  �kE�O�kE�Y hO��#E�O�m �E�O��E�Y hO��� �� �� E�O�� E�O�k 
 �l �& *�l!�� � �� �� �� a � a  E�Y +��� a � a � a � a � a � a  E�O� 	�'E�Y hO�� �=��mn�
� .Mth:Sin_null���     doub� 0 x  �  m ������ 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTon ���oQ��
� 
nmbr� 0 _sin  � 0 etext eTexto ��p
� 
errn� 0 enumber eNumberp �~�}q
�~ 
erob�} 0 efrom eFromq �|�{�z
�| 
errt�{ 
0 eto eTo�z  � � 
0 _error  �  *��&k+ W X  *䡢���+ � �ya�x�wrs�v
�y .Mth:Cos_null���     doub�x 0 x  �w  r �u�t�s�r�q�u 0 x  �t 0 etext eText�s 0 enumber eNumber�r 0 efrom eFrom�q 
0 eto eTos �p�o�n�mtx�l�k
�p 
nmbr�o Z�n 0 _sin  �m 0 etext eTextt �j�iu
�j 
errn�i 0 enumber eNumberu �h�gv
�h 
erob�g 0 efrom eFromv �f�e�d
�f 
errt�e 
0 eto eTo�d  �l �k 
0 _error  �v ! *��&�k+ W X  *塢���+ � �c��b�awx�`
�c .Mth:Tan_null���     doub�b 0 x  �a  w 
�_�^�]�\�[�Z�Y�X�W�V�_ 0 x  �^ 0 isneg isNeg�] 0 y  �\ 0 z  �[ 0 z2  �Z 0 zz  �Y 0 etext eText�X 0 enumber eNumber�W 0 efrom eFrom�V 
0 eto eTox �U�T�S�R�Q�P�O�N��M�L�K��J	234GHIJ�I�Hyn�G�F
�U 
nmbr�T Z�S
�R 
bool
�Q 
errn�P�s
�O 
erob�N �Mh
�L 
pi  �K ��J �I �H 0 etext eTexty �E�Dz
�E 
errn�D 0 enumber eNumberz �C�B{
�C 
erob�B 0 efrom eFrom{ �A�@�?
�A 
errt�@ 
0 eto eTo�?  �G �F 
0 _error  �` ��&E�O�� 
 �� �& )�����Y hO��#��! E�O�jE�O� 	�'E�Y hO���!!k"E�O��� k"� E�O�l#k  �kE�O�kE�Y hO��� �� �a  E�O�� E�O�a  4��� a � a � a  �a � a � a � a !E�Y �E�O�l 
 	�a  �& 
i�!E�Y hO� 	�'E�Y hO�W X  *a ����a + � �>��=�<|}�;�> 	0 _asin  �= �:~�: ~  �9�9 0 x  �<  | �8�7�6�5�4�8 0 x  �7 0 isneg isNeg�6 0 zz  �5 0 p  �4 0 z  } �3�2�1�0�������������/
HIJKLMefghi�.
�3 
errn�2�Y
�1 
erob�0 
�/ 
pi  �. ��; ��jE�O� 	�'E�Y hO�k )�����Y hO�� Xk�E�O�� �� �� �� � ��� �� �� �!E�O���$E�O_ �!�E�O�� a E�O��_ �!E�Y ]�a  �E�Y O�� E�O�a � a � a � a � a � a  �a � a � a � a � a !� �E�O� 	�'E�Y hO�_ a !!� �-��,�+��*
�- .Mth:Sinanull���     doub�, 0 x  �+   �)�(�'�&�%�) 0 x  �( 0 etext eText�' 0 enumber eNumber�& 0 efrom eFrom�% 
0 eto eTo� �$�#�"���!� 
�$ 
nmbr�# 	0 _asin  �" 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  �! �  
0 _error  �*  *��&k+ W X  *䡢���+ � �������
� .Mth:Cosanull���     doub� 0 x  �  � ������ 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� ��������
� Z
� 
nmbr� 	0 _asin  � 0 etext eText� �	��
�	 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � �
 
0 _error  � ! �*��&k+ W X  *塢���+ � ���� ����
� .Mth:Tananull���     doub� 0 x  �   � ������������ 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� �������������
�� 
nmbr�� 	0 _asin  �� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� + ��&E�O*��� k�$!k+ W X  *塢���+ � ����������
�� .Mth:Sinhnull���     doub�� 0 x  ��  � ������������ 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� �����0����
�� 
nmbr�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� / ��&E�O�b  �$b  �'$ W X  *䡢���+ � ��@��������
�� .Mth:Coshnull���     doub�� 0 x  ��  � ������������ 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ��P���c����
�� 
nmbr�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� / ��&E�O�b  �$b  �'$ W X  *䡢���+ � ��s��������
�� .Mth:Tanhnull���     doub�� 0 x  ��  � ��������� 0 x  �� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� ������
� 
nmbr� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �� > -��&E�Ob  �$b  �'$b  �$b  �'$!W X  *㡢���+ � �������� 
0 _frexp  � ��� �  �� 0 m  �  � ���� 0 m  � 0 isneg isNeg� 0 e  � ���
� 
bool� o�j  
�jlvY hO�jE�O� 	�'E�Y hOjE�O 3h��	 �k�&�k �l!E�O�kE�Y �l E�O�kE�[OY��O� 	�'E�Y hO��lv� ������� 	0 _logn  � ��� �  �� 0 x  �  � ����� 0 x  � 0 e  � 0 z  � 0 y  � ��"����BS������������ 
� 
errn��Y� 
0 _frexp  
� 
cobj���
� 
bool�<�j )��l�Y hO*�k+ E[�k/E�Z[�l/E�ZO��
 �l�& j�� �kE�O��E�O� �E�Y �kE�O� �E�O��!E�O�� E�O�� � �� � ��� �� �!E�O�E�O��� ��a  E�Y ��� �kE�Ol� kE�Y �kE�O�� E�O�� a � a � a � a � a � a  �a � a � a � a � a !E�O�j ��� E�Y hO��l!E�O��E�O�j ��a  E�Y hO�� �Q�����
� .Mth:Lognnull���     doub� 0 x  �  � ������� 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom�� 
0 eto eTo� �������e����
�� 
nmbr�� 	0 _logn  �� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �  *��&k+ W X  *䡢���+ � ��u�������
�� .Mth:Lo10null���     doub�� 0 x  ��  � �~�}�|�{�z�~ 0 x  �} 0 etext eText�| 0 enumber eNumber�{ 0 efrom eFrom�z 
0 eto eTo� 
�y�x����w���v�u
�y 
nmbr�x 	0 _logn  �w 0 etext eText� �t�s�
�t 
errn�s 0 enumber eNumber� �r�q�
�r 
erob�q 0 efrom eFrom� �p�o�n
�p 
errt�o 
0 eto eTo�n  �v �u 
0 _error  � % *��&k+ �!� �!W X  *硢���+ 	� �m��l�k���j
�m .Mth:Logbnull���     doub�l 0 x  �k �i�h�g
�i 
Base�h 0 b  �g  � �f�e�d�c�b�a�f 0 x  �e 0 b  �d 0 etext eText�c 0 enumber eNumber�b 0 efrom eFrom�a 
0 eto eTo� �`�_�^���]�\
�` 
nmbr�_ 	0 _logn  �^ 0 etext eText� �[�Z�
�[ 
errn�Z 0 enumber eNumber� �Y�X�
�Y 
erob�X 0 efrom eFrom� �W�V�U
�W 
errt�V 
0 eto eTo�U  �] �\ 
0 _error  �j ( *��&k+ *��&k+ !W X  *䢣���+ ascr  ��ޭ