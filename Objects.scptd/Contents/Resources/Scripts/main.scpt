FasdUAS 1.101.10   ��   ��    k             l      ��  ��   JD Objects -- additional data structures

Notes:

- DictionaryCollection objects, being native code, are approximately 1/1000 as fast as [kludge-optimized] AppleScript lists when getting and setting items, and use a fixed-size bucket list so degrade in performance roughly in proportion to the number of items added, so are not suitable for heavy duty use where performance is a concern. For tasks where both keys and values are simple data types � numbers, text, booleans � better performance may be obtained using NSMutableDictionary instances via the AppleScriptObjC bridge. 

- NSMutableDictionary should not be used to more complex values � lists, records, object specifiers, script objects, etc. � due to the limitations of the ASOC bridge (e.g. records lose keyword-based properties, object specifiers forget their target application, large numbers of script objects crash ASOC), whereas DictionaryCollection can safely store any AppleScript value without problem.

- DictionaryCollection objects automatically copy date objects that are used as item keys. Item values are never copied.
     � 	 	�   O b j e c t s   - -   a d d i t i o n a l   d a t a   s t r u c t u r e s 
 
 N o t e s : 
 
 -   D i c t i o n a r y C o l l e c t i o n   o b j e c t s ,   b e i n g   n a t i v e   c o d e ,   a r e   a p p r o x i m a t e l y   1 / 1 0 0 0   a s   f a s t   a s   [ k l u d g e - o p t i m i z e d ]   A p p l e S c r i p t   l i s t s   w h e n   g e t t i n g   a n d   s e t t i n g   i t e m s ,   a n d   u s e   a   f i x e d - s i z e   b u c k e t   l i s t   s o   d e g r a d e   i n   p e r f o r m a n c e   r o u g h l y   i n   p r o p o r t i o n   t o   t h e   n u m b e r   o f   i t e m s   a d d e d ,   s o   a r e   n o t   s u i t a b l e   f o r   h e a v y   d u t y   u s e   w h e r e   p e r f o r m a n c e   i s   a   c o n c e r n .   F o r   t a s k s   w h e r e   b o t h   k e y s   a n d   v a l u e s   a r e   s i m p l e   d a t a   t y p e s      n u m b e r s ,   t e x t ,   b o o l e a n s      b e t t e r   p e r f o r m a n c e   m a y   b e   o b t a i n e d   u s i n g   N S M u t a b l e D i c t i o n a r y   i n s t a n c e s   v i a   t h e   A p p l e S c r i p t O b j C   b r i d g e .   
 
 -   N S M u t a b l e D i c t i o n a r y   s h o u l d   n o t   b e   u s e d   t o   m o r e   c o m p l e x   v a l u e s      l i s t s ,   r e c o r d s ,   o b j e c t   s p e c i f i e r s ,   s c r i p t   o b j e c t s ,   e t c .      d u e   t o   t h e   l i m i t a t i o n s   o f   t h e   A S O C   b r i d g e   ( e . g .   r e c o r d s   l o s e   k e y w o r d - b a s e d   p r o p e r t i e s ,   o b j e c t   s p e c i f i e r s   f o r g e t   t h e i r   t a r g e t   a p p l i c a t i o n ,   l a r g e   n u m b e r s   o f   s c r i p t   o b j e c t s   c r a s h   A S O C ) ,   w h e r e a s   D i c t i o n a r y C o l l e c t i o n   c a n   s a f e l y   s t o r e   a n y   A p p l e S c r i p t   v a l u e   w i t h o u t   p r o b l e m . 
 
 -   D i c t i o n a r y C o l l e c t i o n   o b j e c t s   a u t o m a t i c a l l y   c o p y   d a t e   o b j e c t s   t h a t   a r e   u s e d   a s   i t e m   k e y s .   I t e m   v a l u e s   a r e   n e v e r   c o p i e d . 
   
  
 l     ��������  ��  ��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      support     �      s u p p o r t      l     ��������  ��  ��        l          j     �� �� 0 _support    N          4     �� !
�� 
scpt ! m     " " � # #  T y p e S u p p o r t  "  used for parameter checking     � $ $ 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g   % & % l     ��������  ��  ��   &  ' ( ' i   
 ) * ) I      �� +���� 
0 _error   +  , - , o      ���� 0 handlername handlerName -  . / . o      ���� 0 etext eText /  0 1 0 o      ���� 0 enumber eNumber 1  2 3 2 o      ���� 0 efrom eFrom 3  4�� 4 o      ���� 
0 eto eTo��  ��   * n     5 6 5 I    �� 7���� &0 throwcommanderror throwCommandError 7  8 9 8 m     : : � ; ;  O b j e c t s 9  < = < o    ���� 0 handlername handlerName =  > ? > o    ���� 0 etext eText ?  @ A @ o    	���� 0 enumber eNumber A  B C B o   	 
���� 0 efrom eFrom C  D�� D o   
 ���� 
0 eto eTo��  ��   6 o     ���� 0 _support   (  E F E l     ��������  ��  ��   F  G H G l     ��������  ��  ��   H  I J I l     �� K L��   K J D--------------------------------------------------------------------    L � M M � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - J  N O N l     �� P Q��   P   Collections    Q � R R    C o l l e c t i o n s O  S T S l     ��������  ��  ��   T  U V U i    W X W I      �� Y����  0 _makeemptylist _makeEmptyList Y  Z�� Z o      ���� 0 n  ��  ��   X l    ! [ \ ] [ k     ! ^ ^  _ ` _ r      a b a J      c c  d�� d m     ��
�� 
msng��   b o      ���� 0 l   `  e f e V     g h g k     i i  j k j r     l m l b     n o n o    ���� 0 l   o o    ���� 0 l   m o      ���� 0 l   k  p�� p r     q r q _     s t s o    ���� 0 n   t m    ����  r o      ���� 0 n  ��   h ?   
  u v u o   
 ���� 0 n   v m    ����  f  w�� w L    ! x x o     ���� 0 l  ��   \ � � make a list of size n where n is a power of two, e.g. _makeBucketList(1024) returns a 1024 (2^10) item list (other values of n are rounded down automatically, e.g. n=1000 gives a 512-item list)    ] � y y�   m a k e   a   l i s t   o f   s i z e   n   w h e r e   n   i s   a   p o w e r   o f   t w o ,   e . g .   _ m a k e B u c k e t L i s t ( 1 0 2 4 )   r e t u r n s   a   1 0 2 4   ( 2 ^ 1 0 )   i t e m   l i s t   ( o t h e r   v a l u e s   o f   n   a r e   r o u n d e d   d o w n   a u t o m a t i c a l l y ,   e . g .   n = 1 0 0 0   g i v e s   a   5 1 2 - i t e m   l i s t ) V  z { z l     ��������  ��  ��   {  | } | l     ��������  ��  ��   }  ~  ~ l     �� � ���   �  -----    � � � � 
 - - - - -   � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i    � � � I     ������
�� .Obj:Dictnull��� ��� null��  ��   � l     � � � � k      � �  � � � l      �� � ���   �}w
		Create a basic hashmap, analogous to Cocoa's NSDictionary class. Uses NSString to generate key hashes from text-based keys (non-text keys will be coerced to text). Items are stored in a fixed-sized bucket list where each bucket contains either `missing value` or a linked list composed of AS records.

		Note: While Cocoa's NSMutableDictionary class may be used via AppleScript-ObjC, it is really only suitable for storing simple AppleScript values such as text and numbers; other values such as `missing value`, records, references, and script objects cannot reliably cross the ASOC bridge without being corrupted (e.g. references lose their target application information) or crashing (e.g. ASOC can't handle large numbers of script objects). For general-purpose use, it is safest to use a mostly-native AppleScript implementation, using Cocoa APIs only to speed up key hashing.		
	    � � � �� 
 	 	 C r e a t e   a   b a s i c   h a s h m a p ,   a n a l o g o u s   t o   C o c o a ' s   N S D i c t i o n a r y   c l a s s .   U s e s   N S S t r i n g   t o   g e n e r a t e   k e y   h a s h e s   f r o m   t e x t - b a s e d   k e y s   ( n o n - t e x t   k e y s   w i l l   b e   c o e r c e d   t o   t e x t ) .   I t e m s   a r e   s t o r e d   i n   a   f i x e d - s i z e d   b u c k e t   l i s t   w h e r e   e a c h   b u c k e t   c o n t a i n s   e i t h e r   ` m i s s i n g   v a l u e `   o r   a   l i n k e d   l i s t   c o m p o s e d   o f   A S   r e c o r d s . 
 
 	 	 N o t e :   W h i l e   C o c o a ' s   N S M u t a b l e D i c t i o n a r y   c l a s s   m a y   b e   u s e d   v i a   A p p l e S c r i p t - O b j C ,   i t   i s   r e a l l y   o n l y   s u i t a b l e   f o r   s t o r i n g   s i m p l e   A p p l e S c r i p t   v a l u e s   s u c h   a s   t e x t   a n d   n u m b e r s ;   o t h e r   v a l u e s   s u c h   a s   ` m i s s i n g   v a l u e ` ,   r e c o r d s ,   r e f e r e n c e s ,   a n d   s c r i p t   o b j e c t s   c a n n o t   r e l i a b l y   c r o s s   t h e   A S O C   b r i d g e   w i t h o u t   b e i n g   c o r r u p t e d   ( e . g .   r e f e r e n c e s   l o s e   t h e i r   t a r g e t   a p p l i c a t i o n   i n f o r m a t i o n )   o r   c r a s h i n g   ( e . g .   A S O C   c a n ' t   h a n d l e   l a r g e   n u m b e r s   o f   s c r i p t   o b j e c t s ) .   F o r   g e n e r a l - p u r p o s e   u s e ,   i t   i s   s a f e s t   t o   u s e   a   m o s t l y - n a t i v e   A p p l e S c r i p t   i m p l e m e n t a t i o n ,   u s i n g   C o c o a   A P I s   o n l y   t o   s p e e d   u p   k e y   h a s h i n g . 	 	 
 	 �  ��� � h     �� ��� ,0 dictionarycollection DictionaryCollection � k       � �  � � � x     �� �����   � 4    �� �
�� 
frmk � m     � � � � �  F o u n d a t i o n��   �  � � � l     ��������  ��  ��   �  � � � l      � � � � j    �� ��� 0 _buckets   � I    �� �����  0 _makeemptylist _makeEmptyList �  ��� � m    ���� ��  ��   � v p DictionaryCollections currently use a fixed-size bucket list (2^10=1024 items seems to be a reasonable default)    � � � � �   D i c t i o n a r y C o l l e c t i o n s   c u r r e n t l y   u s e   a   f i x e d - s i z e   b u c k e t   l i s t   ( 2 ^ 1 0 = 1 0 2 4   i t e m s   s e e m s   t o   b e   a   r e a s o n a b l e   d e f a u l t ) �  � � � j    �� ��� 	0 _size   � n     � � � 1    ��
�� 
leng � n    � � � o    ���� 0 _buckets   �  f     �  � � � j    �� ��� 
0 _count   � m    ����   �  � � � l     ��������  ��  ��   �  � � � i   ! � � � I      �� ����� 
0 _error   �  � � � o      ���� 0 handlername handlerName �  � � � o      ���� 0 etext eText �  � � � o      ���� 0 enumber eNumber �  � � � o      ���� 0 efrom eFrom �  ��� � o      ���� 
0 eto eTo��  ��   � n     � � � I    �� ����� $0 throwmethoderror throwMethodError �  � � � m     � � � � �  O b j e c t s �  � � � m     � � � � � ( D i c t i o n a r y C o l l e c t i o n �  � � � o    ���� 0 handlername handlerName �  � � � o    	���� 0 etext eText �  � � � o   	 
���� 0 enumber eNumber �  � � � o   
 ���� 0 efrom eFrom �  ��� � o    ���� 
0 eto eTo��  ��   � o     ���� 0 _support   �  � � � l     ��������  ��  ��   �  � � � i  " % � � � I      �� ����� 0 	_keyindex 	_keyIndex �  ��� � o      ���� 0 thekey theKey��  ��   � Q     � � � � k    � � �  � � � l   K � � � � Z   K � ����� � G    > � � � G    . � � � G     � � � >     � � � l    ���~ � I   �} � �
�} .corecnte****       **** � J     � �  ��| � o    �{�{ 0 thekey theKey�|   � �z ��y
�z 
kocl � m    �x
�x 
obj �y  �  �~   � m    �w�w   � >     � � � l    ��v�u � I   �t � �
�t .corecnte****       **** � J     � �  ��s � o    �r�r 0 thekey theKey�s   � �q ��p
�q 
kocl � m    �o
�o 
list�p  �v  �u   � m    �n�n   � >   ! , �  � l  ! *�m�l I  ! *�k
�k .corecnte****       **** J   ! $ �j o   ! "�i�i 0 thekey theKey�j   �h�g
�h 
kocl m   % &�f
�f 
reco�g  �m  �l    m   * +�e�e   � >   1 < l  1 :	�d�c	 I  1 :�b

�b .corecnte****       ****
 J   1 4 �a o   1 2�`�` 0 thekey theKey�a   �_�^
�_ 
kocl m   5 6�]
�] 
scpt�^  �d  �c   m   : ;�\�\   � R   A G�[�Z
�[ .ascrerr ****      � ****�Z   �Y�X
�Y 
errn m   C D�W�W�\�X  ��  ��   � "  explicitly disallowed types    � � 8   e x p l i c i t l y   d i s a l l o w e d   t y p e s �  Z   L ��V E  L W J   L Q  m   L M�U
�U 
type  m   M N�T
�T 
pcls �S m   N O�R
�R 
enum�S   J   Q V  �Q  n  Q T!"! m   R T�P
�P 
pcls" o   Q R�O�O 0 thekey theKey�Q   l  Z j#$%# r   Z j&'& n  Z h()( I   d h�N�M�L�N 0 typecodevalue typeCodeValue�M  �L  ) n  Z d*+* I   _ d�K,�J�K 0 
asnsobject 
asNSObject, -�I- o   _ `�H�H 0 thekey theKey�I  �J  + o   Z _�G�G 0 _support  ' o      �F�F 0 hashnum hashNum$ caution: coercing a type class or constant symbol to text is problematic, as the resulting string may contain either its literal name or its raw four-char code depending on the terminology available at the time (furthermore, terminology conflicts and synonyms may cause its literal name to change); to avoid these problems, it's better to send the value over the ASOC to convert it to an NSAppleEventDescriptor, from which its raw four-char code can be obtained as an Int32 which can be safely used as its hashNum   % �..   c a u t i o n :   c o e r c i n g   a   t y p e   c l a s s   o r   c o n s t a n t   s y m b o l   t o   t e x t   i s   p r o b l e m a t i c ,   a s   t h e   r e s u l t i n g   s t r i n g   m a y   c o n t a i n   e i t h e r   i t s   l i t e r a l   n a m e   o r   i t s   r a w   f o u r - c h a r   c o d e   d e p e n d i n g   o n   t h e   t e r m i n o l o g y   a v a i l a b l e   a t   t h e   t i m e   ( f u r t h e r m o r e ,   t e r m i n o l o g y   c o n f l i c t s   a n d   s y n o n y m s   m a y   c a u s e   i t s   l i t e r a l   n a m e   t o   c h a n g e ) ;   t o   a v o i d   t h e s e   p r o b l e m s ,   i t ' s   b e t t e r   t o   s e n d   t h e   v a l u e   o v e r   t h e   A S O C   t o   c o n v e r t   i t   t o   a n   N S A p p l e E v e n t D e s c r i p t o r ,   f r o m   w h i c h   i t s   r a w   f o u r - c h a r   c o d e   c a n   b e   o b t a i n e d   a s   a n   I n t 3 2   w h i c h   c a n   b e   s a f e l y   u s e d   a s   i t s   h a s h N u m�V   l  m �/01/ k   m �22 343 Z   m �56�E75 E  m w898 J   m q:: ;<; m   m n�D
�D 
long< =�C= m   n o�B
�B 
doub�C  9 J   q v>> ?�A? n  q t@A@ m   r t�@
�@ 
pclsA o   q r�?�? 0 thekey theKey�A  6 l  z �BCDB k   z �EE FGF l  z z�>HI�>  H � � TO DO: need a decent number hashing algorithm that neither overflows not habitually returns 0 (ironically enough, NSNumber's hash fails on doubles outside of �2^63)   I �JJJ   T O   D O :   n e e d   a   d e c e n t   n u m b e r   h a s h i n g   a l g o r i t h m   t h a t   n e i t h e r   o v e r f l o w s   n o t   h a b i t u a l l y   r e t u r n s   0   ( i r o n i c a l l y   e n o u g h ,   N S N u m b e r ' s   h a s h   f a i l s   o n   d o u b l e s   o u t s i d e   o f   � 2 ^ 6 3 )G KLK r   z }MNM o   z {�=�= 0 thekey theKeyN o      �<�< 0 hashnum hashNumL OPO r   ~ �QRQ `   ~ �STS o   ~ �;�; 0 thekey theKeyT m    ��:�: R o      �9�9 0 divnum divNumP UVU Z  � �WX�8�7W >   � �YZY o   � ��6�6 0 divnum divNumZ m   � ��5�5  X r   � �[\[ \   � �]^] o   � ��4�4 0 hashnum hashNum^ ^   � �_`_ m   � ��3�3 ` o   � ��2�2 0 divnum divNum\ o      �1�1 0 hashnum hashNum�8  �7  V aba Z  � �cd�0�/c A   � �efe o   � ��.�. 0 hashnum hashNumf m   � ��-�-  d r   � �ghg d   � �ii o   � ��,�, 0 hashnum hashNumh o      �+�+ 0 hashnum hashNum�0  �/  b j�*j Z  � �kl�)�(k A   � �mnm o   � ��'�' 0 hashnum hashNumn m   � �oo it���bZl r   � �pqp ]   � �rsr o   � ��&�& 0 hashnum hashNums m   � ��%�%  J�q o      �$�$ 0 hashnum hashNum�)  �(  �*  C � � note: integers and reals that are numerically equalmust always produce same hash, since the linked list lookup compares integer and real keys for numeric equality (e.g. 1 = 1.0)    D �ttf   n o t e :   i n t e g e r s   a n d   r e a l s   t h a t   a r e   n u m e r i c a l l y   e q u a l m u s t   a l w a y s   p r o d u c e   s a m e   h a s h ,   s i n c e   t h e   l i n k e d   l i s t   l o o k u p   c o m p a r e s   i n t e g e r   a n d   r e a l   k e y s   f o r   n u m e r i c   e q u a l i t y   ( e . g .   1   =   1 . 0 )  �E  7 r   � �uvu n  � �wxw I   � ��#�"�!�# 0 hash  �"  �!  x n  � �yzy I   � �� {��  ,0 asnormalizednsstring asNormalizedNSString{ |�| c   � �}~} o   � ��� 0 thekey theKey~ m   � ��
� 
ctxt�  �  z o   � ��� 0 _support  v o      �� 0 hashnum hashNum4 � l  � �����  � � � `-[NSString hash]` returns UInt64 which ASOC unpacks as Double, so discard least significant bits when precision is lost due to rounding   � ���   ` - [ N S S t r i n g   h a s h ] `   r e t u r n s   U I n t 6 4   w h i c h   A S O C   u n p a c k s   a s   D o u b l e ,   s o   d i s c a r d   l e a s t   s i g n i f i c a n t   b i t s   w h e n   p r e c i s i o n   i s   l o s t   d u e   t o   r o u n d i n g� ��� Z  � ������ ?   � ���� o   � ��� 0 hashnum hashNum� m   � ��� C������� r   � ���� _   � ���� o   � ��� 0 hashnum hashNum� m   � ��� � o      �� 0 hashnum hashNum�  �  �  0f` TO DO: what AS types are safe to use as keys? currently, all keys except those already explicitly disallowed or specially processed are coerced to text for hashing, rejecting any values that cause coercion errors if/when they occur, but to guarantee reliability it may be best to whitelist only AS types that are guaranteed to be safe for use as keys    1 ����   T O   D O :   w h a t   A S   t y p e s   a r e   s a f e   t o   u s e   a s   k e y s ?   c u r r e n t l y ,   a l l   k e y s   e x c e p t   t h o s e   a l r e a d y   e x p l i c i t l y   d i s a l l o w e d   o r   s p e c i a l l y   p r o c e s s e d   a r e   c o e r c e d   t o   t e x t   f o r   h a s h i n g ,   r e j e c t i n g   a n y   v a l u e s   t h a t   c a u s e   c o e r c i o n   e r r o r s   i f / w h e n   t h e y   o c c u r ,   b u t   t o   g u a r a n t e e   r e l i a b i l i t y   i t   m a y   b e   b e s t   t o   w h i t e l i s t   o n l y   A S   t y p e s   t h a t   a r e   g u a r a n t e e d   t o   b e   s a f e   f o r   u s e   a s   k e y s   ��� L   � ��� [   � ���� `   � ���� o   � ��� 0 hashnum hashNum� o   � ��� 	0 _size  � m   � ��� �   � R      ���
� .ascrerr ****      � ****�  � ���

� 
errn� d      �� m      �	�	��
   � R   ����
� .ascrerr ****      � ****� m  �� ��� " I n v a l i d   k e y   t y p e .� ���
� 
errn� m   � ����Y� ���
� 
erob� o   � ��� 0 thekey theKey�   � ��� l     ��� �  �  �   � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  & )��� I      �������� 0 
countitems 
countItems��  ��  � L     �� o     ���� 
0 _count  � ��� l     ��������  ��  ��  � ��� i  * -��� I      ������� 0 additem addItem� ��� o      ���� 0 thekey theKey� ���� o      ���� 0 thevalue theValue��  ��  � Q     ����� k    ��� ��� r    ��� I    	������� 0 	_keyindex 	_keyIndex� ���� o    ���� 0 thekey theKey��  ��  � o      ���� 0 keyindex keyIndex� ��� l   ���� s    ��� o    ���� 0 thekey theKey� o      ���� 0 thekey theKey�-' while dates can be used as keys, it's essential that keys stored in linked lists are never mutated so they must be copied first (this is a no-op for text, numbers, and other immutable types, while other types for which copying is problematic, e.g. script objects, are already forbidden as keys)   � ���N   w h i l e   d a t e s   c a n   b e   u s e d   a s   k e y s ,   i t ' s   e s s e n t i a l   t h a t   k e y s   s t o r e d   i n   l i n k e d   l i s t s   a r e   n e v e r   m u t a t e d   s o   t h e y   m u s t   b e   c o p i e d   f i r s t   ( t h i s   i s   a   n o - o p   f o r   t e x t ,   n u m b e r s ,   a n d   o t h e r   i m m u t a b l e   t y p e s ,   w h i l e   o t h e r   t y p e s   f o r   w h i c h   c o p y i n g   i s   p r o b l e m a t i c ,   e . g .   s c r i p t   o b j e c t s ,   a r e   a l r e a d y   f o r b i d d e n   a s   k e y s )� ��� r    ��� n    ��� 4    ���
�� 
cobj� o    ���� 0 keyindex keyIndex� n   ��� o    ���� 0 _buckets  �  f    � o      ���� 0 	founditem 	foundItem� ��� Z    D������� =   ��� o    ���� 0 	founditem 	foundItem� m    ��
�� 
msng� l    @���� k     @�� ��� r     /��� K     (�� ������ 0 k  � o   ! "���� 0 thekey theKey� ������ 0 v  � o   # $���� 0 thevalue theValue� ������� 0 nextitem nextItem� m   % &��
�� 
msng��  � n      ��� 4   + .���
�� 
cobj� o   , -���� 0 keyindex keyIndex� n  ( +��� o   ) +���� 0 _buckets  �  f   ( )� ��� r   0 =��� [   0 7��� o   0 5���� 
0 _count  � m   5 6���� � o      ���� 
0 _count  � ���� L   > @����  ��  �   insert new item   � ���     i n s e r t   n e w   i t e m��  ��  � ���� P   E ����� T   J ��� k   O ��� ��� Z   O {������� =  O T��� n   O R��� o   P R���� 0 k  � o   O P���� 0 	founditem 	foundItem� o   R S���� 0 thekey theKey� l  W w�� � k   W w  r   W \ n   W Z o   X Z���� 0 v   o   W X���� 0 	founditem 	foundItem o      ���� 0 oldvalue oldValue 	 r   ] t

 J   ] a  o   ] ^���� 0 thekey theKey �� o   ^ _���� 0 thevalue theValue��   J        n       o   g i���� 0 k   o   f g���� 0 	founditem 	foundItem �� n       o   p r���� 0 v   o   o p���� 0 	founditem 	foundItem��  	 �� L   u w����  ��  �   replace existing item     � ,   r e p l a c e   e x i s t i n g   i t e m��  ��  �  Z   | ����� =  | � n   |  !  o   } ���� 0 nextitem nextItem! o   | }���� 0 	founditem 	foundItem m    ���
�� 
msng l  � �"#$" k   � �%% &'& r   � �()( K   � �** ��+,�� 0 k  + o   � ����� 0 thekey theKey, ��-.�� 0 v  - o   � ����� 0 thevalue theValue. ��/���� 0 nextitem nextItem/ m   � ���
�� 
msng��  ) n      010 o   � ����� 0 nextitem nextItem1 o   � ����� 0 	founditem 	foundItem' 232 r   � �454 [   � �676 o   � ����� 
0 _count  7 m   � ����� 5 o      ���� 
0 _count  3 8��8 L   � �����  ��  #   insert new item   $ �99     i n s e r t   n e w   i t e m��  ��   :��: r   � �;<; n   � �=>= o   � ����� 0 nextitem nextItem> o   � ����� 0 	founditem 	foundItem< o      ���� 0 	founditem 	foundItem��  � ��?
�� conscase? ��@
�� consdiac@ ��A
�� conshyphA ��B
�� conspuncB ����
�� conswhit��  � ����
�� consnume��  ��  � R      ��CD
�� .ascrerr ****      � ****C o      ���� 0 etext eTextD ��EF
�� 
errnE o      ���� 0 enumber eNumberF ��GH
�� 
erobG o      ���� 0 efrom eFromH ��I��
�� 
errtI o      ���� 
0 eto eTo��  � I   � ���J���� 
0 _error  J KLK m   � �MM �NN  a d d I t e mL OPO o   � ����� 0 etext eTextP QRQ o   � ����� 0 enumber eNumberR STS o   � ����� 0 efrom eFromT U��U o   � ����� 
0 eto eTo��  ��  � VWV l     ��������  ��  ��  W XYX i  . 1Z[Z I      ��\���� 0 
removeitem 
removeItem\ ]��] o      ���� 0 thekey theKey��  ��  [ Q     �^_`^ k    �aa bcb r    ded I    	��f���� 0 	_keyindex 	_keyIndexf g��g o    ���� 0 thekey theKey��  ��  e o      ���� 0 keyindex keyIndexc hih r    jkj n    lml 4    ��n
�� 
cobjn o    ���� 0 keyindex keyIndexm n   opo o    �� 0 _buckets  p  f    k o      �~�~ 0 	founditem 	foundItemi qrq P    wstus k    vvv wxw r    yzy m    �}
�} 
msngz o      �|�| 0 previtem prevItemx {�{{ V    v|}| k   & q~~ � r   & +��� n   & )��� o   ' )�z�z 0 k  � o   & '�y�y 0 	founditem 	foundItem� o      �x�x 0 foundkey foundKey� ��� Z   , g���w�v� =  , /��� o   , -�u�u 0 foundkey foundKey� o   - .�t�t 0 thekey theKey� k   2 c�� ��� r   2 7��� n   2 5��� o   3 5�s�s 0 v  � o   2 3�r�r 0 	founditem 	foundItem� o      �q�q 0 thevalue theValue� ��� Z   8 R���p�� =  8 ;��� o   8 9�o�o 0 previtem prevItem� m   9 :�n
�n 
msng� r   > H��� n   > A��� o   ? A�m�m 0 nextitem nextItem� o   > ?�l�l 0 	founditem 	foundItem� n      ��� 4   D G�k�
�k 
cobj� o   E F�j�j 0 keyindex keyIndex� n  A D��� o   B D�i�i 0 _buckets  �  f   A B�p  � r   K R��� n   K N��� o   L N�h�h 0 nextitem nextItem� o   K L�g�g 0 	founditem 	foundItem� n      ��� o   O Q�f�f 0 nextitem nextItem� o   N O�e�e 0 previtem prevItem� ��� r   S `��� \   S Z��� o   S X�d�d 
0 _count  � m   X Y�c�c � o      �b�b 
0 _count  � ��a� l  a c���� L   a c�� o   a b�`�` 0 thevalue theValue�   return the removed value   � ��� 2   r e t u r n   t h e   r e m o v e d   v a l u e�a  �w  �v  � ��� r   h k��� o   h i�_�_ 0 	founditem 	foundItem� o      �^�^ 0 previtem prevItem� ��]� r   l q��� n   l o��� o   m o�\�\ 0 nextitem nextItem� o   l m�[�[ 0 	founditem 	foundItem� o      �Z�Z 0 	founditem 	foundItem�]  } >  " %��� o   " #�Y�Y 0 	founditem 	foundItem� m   # $�X
�X 
msng�{  t �W�
�W conscase� �V�
�V consdiac� �U�
�U conshyph� �T�
�T conspunc� �S�R
�S conswhit�R  u �Q�P
�Q consnume�P  r ��O� R   x ��N��
�N .ascrerr ****      � ****� m   ~ �� ���  I t e m   n o t   f o u n d .� �M��
�M 
errn� m   z {�L�L�@� �K��J
�K 
erob� o   | }�I�I 0 thekey theKey�J  �O  _ R      �H��
�H .ascrerr ****      � ****� o      �G�G 0 etext eText� �F��
�F 
errn� o      �E�E 0 enumber eNumber� �D��
�D 
erob� o      �C�C 0 efrom eFrom� �B��A
�B 
errt� o      �@�@ 
0 eto eTo�A  ` I   � ��?��>�? 
0 _error  � ��� m   � ��� ���  r e m o v e I t e m� ��� o   � ��=�= 0 etext eText� ��� o   � ��<�< 0 enumber eNumber� ��� o   � ��;�; 0 efrom eFrom� ��:� o   � ��9�9 
0 eto eTo�:  �>  Y ��� l     �8�7�6�8  �7  �6  � ��� i  2 5��� I      �5�4�3�5  0 deleteallitems deleteAllItems�4  �3  � k     !�� ��� r     
��� I     �2��1�2  0 _makeemptylist _makeEmptyList� ��0� m    �/�/ �0  �1  � n     ��� o    	�.�. 0 _buckets  �  f    � ��� r    ��� n    ��� 1    �-
�- 
leng� n   ��� o    �,�, 0 _buckets  �  f    � o      �+�+ 	0 _size  � ��� r    ��� m    �*�*  � o      �)�) 
0 _count  � ��(� L    !�'�'  �(  � ��� l     �&�%�$�&  �%  �$  � ��� i  6 9��� I      �# �"�# 0 getitem getItem  �! o      � �  0 thekey theKey�!  �"  � Q     Z k    D  P    ;	
 k    :  r     n     4    �
� 
cobj I    ��� 0 	_keyindex 	_keyIndex � o    �� 0 thekey theKey�  �   n    o   	 �� 0 _buckets    f    	 o      �� 0 	founditem 	foundItem � V    : k    5  Z   /�� =   #  n    !!"! o    !�� 0 k  " o    �� 0 	founditem 	foundItem  o   ! "�� 0 thekey theKey L   & +## n   & *$%$ o   ' )�� 0 v  % o   & '�� 0 	founditem 	foundItem�  �   &�& r   0 5'(' n   0 3)*) o   1 3�� 0 nextitem nextItem* o   0 1�� 0 	founditem 	foundItem( o      �� 0 	founditem 	foundItem�   >   +,+ o    �� 0 	founditem 	foundItem, m    �
� 
msng�  	 �
-
�
 conscase- �	.
�	 consdiac. �/
� conshyph/ �0
� conspunc0 ��
� conswhit�  
 ��
� consnume�   1�1 R   < D�23
� .ascrerr ****      � ****2 m   B C44 �55  I t e m   n o t   f o u n d .3 � 67
�  
errn6 m   > ?�����@7 ��8��
�� 
erob8 o   @ A���� 0 thekey theKey��  �   R      ��9:
�� .ascrerr ****      � ****9 o      ���� 0 etext eText: ��;<
�� 
errn; o      ���� 0 enumber eNumber< ��=>
�� 
erob= o      ���� 0 efrom eFrom> ��?��
�� 
errt? o      ���� 
0 eto eTo��   I   L Z��@���� 
0 _error  @ ABA m   M PCC �DD  g e t I t e mB EFE o   P Q���� 0 etext eTextF GHG o   Q R���� 0 enumber eNumberH IJI o   R S���� 0 efrom eFromJ K��K o   S T���� 
0 eto eTo��  ��  � LML l     ��������  ��  ��  M NON i  : =PQP I      ��R���� 0 containsitem containsItemR S��S o      ���� 0 thekey theKey��  ��  Q Q     TUVT k    WW XYX I    	��Z���� 0 getitem getItemZ [��[ o    ���� 0 thekey theKey��  ��  Y \��\ L   
 ]] m   
 ��
�� boovtrue��  U R      ����^
�� .ascrerr ****      � ****��  ^ ��_��
�� 
errn_ d      `` m      �������  V L    aa m    ��
�� boovfalsO bcb l     ��������  ��  ��  c ded l     ��������  ��  ��  e fgf l     ��������  ��  ��  g hih i  > Ajkj I      �������� &0 objectdescription objectDescription��  ��  k L     
ll b     	mnm b     opo m     qq �rr 0 � d i c t i o n a r y   c o l l e c t i o n   (p o    ���� 
0 _count  n m    ss �tt    i t e m s ) �i uvu l     ��������  ��  ��  v wxw i  B Eyzy I      �������� 0 
copyobject 
copyObject��  ��  z Q     �{|}{ k    �~~ � r    
��� I   ������
�� .Obj:Dictnull��� ��� null��  ��  � o      ���� 0 	newobject 	newObject� ��� Z    �������� ?    ��� o    ���� 
0 _count  � m    ����  � k    ��� ��� l   +���� Z   +������� >     ��� n    ��� 1    ��
�� 
leng� n   ��� o    ���� 0 _buckets  �  f    � n    ��� 1    ��
�� 
leng� n   ��� o    ���� 0 _buckets  � o    ���� 0 	newobject 	newObject� R   # '�����
�� .ascrerr ****      � ****� m   % &�� ��� 0 M i s m a t c h e d   b u c k e t   l i s t s .��  ��  ��  � � � sanity check as this copyObject() implementation requires all bucket lists to be same length, and will need revised if growable bucket lists are supported in future   � ���J   s a n i t y   c h e c k   a s   t h i s   c o p y O b j e c t ( )   i m p l e m e n t a t i o n   r e q u i r e s   a l l   b u c k e t   l i s t s   t o   b e   s a m e   l e n g t h ,   a n d   w i l l   n e e d   r e v i s e d   i f   g r o w a b l e   b u c k e t   l i s t s   a r e   s u p p o r t e d   i n   f u t u r e� ���� Y   , ��������� k   ; ��� ��� r   ; C��� n   ; A��� 4   > A���
�� 
cobj� o   ? @���� 0 i  � n  ; >��� o   < >���� 0 _buckets  �  f   ; <� o      ���� 0 	oldbucket 	oldBucket� ���� Z   D �������� >  D G��� o   D E���� 0 	oldbucket 	oldBucket� m   E F��
�� 
msng� l  J ����� k   J ��� ��� r   J X��� K   J V�� ������ 0 k  � n  K N��� o   L N���� 0 k  � o   K L���� 0 	oldbucket 	oldBucket� ������ 0 v  � n  O R��� o   P R���� 0 v  � o   O P���� 0 	oldbucket 	oldBucket� ������� 0 nextitem nextItem� m   S T��
�� 
msng��  � o      ���� 0 	newbucket 	newBucket� ��� r   Y a��� o   Y Z���� 0 	newbucket 	newBucket� n      ��� 4   ] `���
�� 
cobj� o   ^ _���� 0 i  � n  Z ]��� o   [ ]���� 0 _buckets  � o   Z [���� 0 	newobject 	newObject� ���� V   b ���� k   l ��� ��� r   l q��� n   l o��� o   m o���� 0 nextitem nextItem� o   l m���� 0 	oldbucket 	oldBucket� o      ���� 0 	oldbucket 	oldBucket� ��� r   r ���� K   r ~�� ������ 0 k  � n  s v��� o   t v���� 0 k  � o   s t���� 0 	oldbucket 	oldBucket� ������ 0 v  � n  w z��� o   x z���� 0 v  � o   w x���� 0 	oldbucket 	oldBucket� ������� 0 nextitem nextItem� m   { |��
�� 
msng��  � o      ���� 0 tmp  � ��� r   � ���� o   � ����� 0 tmp  � n     ��� o   � ����� 0 nextitem nextItem� o   � ����� 0 	newbucket 	newBucket� ���� r   � ���� o   � ����� 0 tmp  � o      ���� 0 	newbucket 	newBucket��  � >  f k��� n   f i��� o   g i���� 0 nextitem nextItem� o   f g���� 0 	oldbucket 	oldBucket� m   i j��
�� 
msng��  � _ Y shallow copy the linked list and add it new newObject's bucket list at the same position   � ��� �   s h a l l o w   c o p y   t h e   l i n k e d   l i s t   a n d   a d d   i t   n e w   n e w O b j e c t ' s   b u c k e t   l i s t   a t   t h e   s a m e   p o s i t i o n��  ��  ��  �� 0 i  � m   / 0���� � n   0 6��� 1   3 5��
�� 
leng� n  0 3��� o   1 3���� 0 _buckets  �  f   0 1��  ��  ��  ��  � ��� L   � ��� o   � ��~�~ 0 	newobject 	newObject�  | R      �}��
�} .ascrerr ****      � ****� o      �|�| 0 etext eText� �{��
�{ 
errn� o      �z�z 0 enumber eNumber� �y��
�y 
erob� o      �x�x 0 efrom eFrom� �w��v
�w 
errt� o      �u�u 
0 eto eTo�v  } I   � ��t �s�t 
0 _error     m   � � �  c o p y O b j e c t  o   � ��r�r 0 etext eText  o   � ��q�q 0 enumber eNumber 	
	 o   � ��p�p 0 efrom eFrom
 �o o   � ��n�n 
0 eto eTo�o  �s  x  l     �m�l�k�m  �l  �k    l     �j�i�h�j  �i  �h    l     �g�f�e�g  �f  �e    i  F I I      �d�c�d 0 adddictionary addDictionary �b o      �a�a $0 dictionaryobject dictionaryObject�b  �c   Q    X k   F  Z   C�`�_ ?    
 !  n   "#" I    �^�]�\�^ 0 
countitems 
countItems�]  �\  # o    �[�[ $0 dictionaryobject dictionaryObject! m    	�Z�Z   k   ?$$ %&% l   #'()' Z   #*+�Y�X* >    ,-, n    ./. 1    �W
�W 
leng/ n   010 o    �V�V 0 _buckets  1  f    - n    232 1    �U
�U 
leng3 n   454 o    �T�T 0 _buckets  5 o    �S�S $0 dictionaryobject dictionaryObject+ R    �R6�Q
�R .ascrerr ****      � ****6 m    77 �88 0 M i s m a t c h e d   b u c k e t   l i s t s .�Q  �Y  �X  (   sanity check, as above   ) �99 .   s a n i t y   c h e c k ,   a s   a b o v e& :�P: P   $?;<=; Y   )>>�O?@�N> k   89AA BCB r   8 @DED n   8 >FGF 4   ; >�MH
�M 
cobjH o   < =�L�L 0 i  G n  8 ;IJI o   9 ;�K�K 0 _buckets  J o   8 9�J�J $0 dictionaryobject dictionaryObjectE o      �I�I 0 otherbucket otherBucketC K�HK Z   A9LM�G�FL >  A DNON o   A B�E�E 0 otherbucket otherBucketO m   B C�D
�D 
msngM l  G5PQRP k   G5SS TUT r   G OVWV n   G MXYX 4   J M�CZ
�C 
cobjZ o   K L�B�B 0 i  Y n  G J[\[ o   H J�A�A 0 _buckets  \  f   G HW o      �@�@ 0 mybucket myBucketU ]�?] Z   P5^_�>`^ =  P Saba o   P Q�=�= 0 mybucket myBucketb m   Q R�<
�< 
msng_ l  V �cdec k   V �ff ghg r   V diji K   V bkk �;lm�; 0 k  l n  W Znon o   X Z�:�: 0 k  o o   W X�9�9 0 otherbucket otherBucketm �8pq�8 0 v  p n  [ ^rsr o   \ ^�7�7 0 v  s o   [ \�6�6 0 otherbucket otherBucketq �5t�4�5 0 nextitem nextItemt m   _ `�3
�3 
msng�4  j o      �2�2 0 mybucket myBucketh uvu r   e rwxw [   e lyzy o   e j�1�1 
0 _count  z m   j k�0�0 x o      �/�/ 
0 _count  v {|{ r   s {}~} o   s t�.�. 0 mybucket myBucket~ n      � 4   w z�-�
�- 
cobj� o   x y�,�, 0 i  � n  t w��� o   u w�+�+ 0 _buckets  �  f   t u| ��*� V   | ���� k   � ��� ��� r   � ���� n   � ���� o   � ��)�) 0 nextitem nextItem� o   � ��(�( 0 otherbucket otherBucket� o      �'�' 0 otherbucket otherBucket� ��� r   � ���� K   � ��� �&���& 0 k  � n  � ���� o   � ��%�% 0 k  � o   � ��$�$ 0 otherbucket otherBucket� �#���# 0 v  � n  � ���� o   � ��"�" 0 v  � o   � ��!�! 0 otherbucket otherBucket� � ���  0 nextitem nextItem� m   � ��
� 
msng�  � o      �� 0 tmp  � ��� r   � ���� [   � ���� o   � ��� 
0 _count  � m   � ��� � o      �� 
0 _count  � ��� r   � ���� o   � ��� 0 tmp  � n     ��� o   � ��� 0 nextitem nextItem� o   � ��� 0 mybucket myBucket� ��� r   � ���� o   � ��� 0 tmp  � o      �� 0 mybucket myBucket�  � >  � ���� n   � ���� o   � ��� 0 nextitem nextItem� o   � ��� 0 otherbucket otherBucket� m   � ��
� 
msng�*  d   �by shallow copy   e ��� "   & b y   s h a l l o w   c o p y�>  ` l  �5���� V   �5��� k   �0�� ��� r   � ���� o   � ��� 0 mybucket myBucket� o      �� 0 tmp  � ��� T   �*�� k   �%�� ��� Z   ������ =  � ���� n  � ���� o   � ��� 0 k  � o   � ��� 0 tmp  � n  � ���� o   � ��� 0 k  � o   � ��
�
 0 otherbucket otherBucket� l  � ����� k   � ��� ��� r   � ���� n  � ���� J   � ��� ��� o   � ��	�	 0 k  � ��� o   � ��� 0 v  �  � o   � ��� 0 otherbucket otherBucket� n     ��� J   � ��� ��� o   � ��� 0 k  � ��� o   � ��� 0 v  �  � o   � ��� 0 tmp  � ���  S   � ��  �   replace   � ���    r e p l a c e� ��� =  � ���� n  � ���� o   � �� �  0 nextitem nextItem� o   � ����� 0 tmp  � m   � ���
�� 
msng� ���� l  ����� k   ��� ��� r   ���� K   ��� ������ 0 k  � n  � ���� o   � ����� 0 k  � o   � ����� 0 otherbucket otherBucket� ������ 0 v  � n  ��� o  ���� 0 v  � o   ���� 0 otherbucket otherBucket� ������� 0 nextitem nextItem� m  ��
�� 
msng��  � n     ��� o  
���� 0 nextitem nextItem� o  ���� 0 tmp  � ��� r  ��� [  ��� o  ���� 
0 _count  � m  ���� � o      ���� 
0 _count  �  ��   S  ��  �   append   � �    a p p e n d��  �  � �� r   % n  # o  !#���� 0 nextitem nextItem o   !���� 0 tmp   o      ���� 0 tmp  ��  � �� r  +0	 n  +.

 o  ,.���� 0 nextitem nextItem o  +,���� 0 otherbucket otherBucket	 o      ���� 0 otherbucket otherBucket��  � >  � � o   � ����� 0 otherbucket otherBucket m   � ���
�� 
msng� 9 3 �by merging into this dictionary's existing bucket   � � f   & b y   m e r g i n g   i n t o   t h i s   d i c t i o n a r y ' s   e x i s t i n g   b u c k e t�?  Q * $ transfer other dictionary's bucket�   R � H   t r a n s f e r   o t h e r   d i c t i o n a r y ' s   b u c k e t &�G  �F  �H  �O 0 i  ? m   , -���� @ n   - 3 1   0 2��
�� 
leng n  - 0 o   . 0���� 0 _buckets   o   - .���� $0 dictionaryobject dictionaryObject�N  < ��
�� conscase ��
�� consdiac ��
�� conshyph ��
�� conspunc ����
�� conswhit��  = ����
�� consnume��  �P  �`  �_   �� L  DF����  ��   R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��   I  NX�� ���� 
0 _error    !"! m  OP## �$$  a d d D i c t i o n a r y" %&% o  PQ���� 0 etext eText& '(' o  QR���� 0 enumber eNumber( )*) o  RS���� 0 efrom eFrom* +��+ o  ST���� 
0 eto eTo��  ��   ,-, l     ��������  ��  ��  - ./. l     ��������  ��  ��  / 010 l     ��������  ��  ��  1 232 i  J M454 I      ��6���� $0 addkeysandvalues addKeysAndValues6 7��7 o      ���� 0 keyvaluelist keyValueList��  ��  5 l    �89:8 Q     �;<=; k    �>> ?@? Z   AB����A =    CDC l   E����E I   ��FG
�� .corecnte****       ****F J    HH I��I o    ���� 0 keyvaluelist keyValueList��  G ��J��
�� 
koclJ m    ��
�� 
list��  ��  ��  D m    ����  B R    ��KL
�� .ascrerr ****      � ****K m    MM �NN 6 N o t   a   v a l i d   k e y - v a l u e   l i s t .L ��OP
�� 
errnO m    �����\P ��Q��
�� 
erobQ o    ���� 0 keyvaluelist keyValueList��  ��  ��  @ RSR h    %��T�� 0 
listobject 
listObjectT j     ��U�� 
0 _list_  U o     ���� 0 keyvaluelist keyValueListS VWV X   & �X��YX k   8 �ZZ [\[ r   8 =]^] n  8 ;_`_ 1   9 ;��
�� 
pcnt` o   8 9���� 0 aref aRef^ o      ���� 0 keyvalue keyValue\ a��a Q   > �bcdb k   A qee fgf Z  A chi����h G   A Vjkj =   A Llml l  A Jn����n I  A J��op
�� .corecnte****       ****o J   A Dqq r��r o   A B���� 0 keyvalue keyValue��  p ��s��
�� 
kocls m   E F��
�� 
list��  ��  ��  m m   J K����  k >   O Ttut n  O Rvwv 1   P R��
�� 
lengw o   O P���� 0 keyvalue keyValueu m   R S���� i R   Y _����x
�� .ascrerr ****      � ****��  x ��y��
�� 
errny m   [ \�����\��  ��  ��  g z��z I   d q��{���� 0 additem addItem{ |}| n  e i~~ 4   f i���
�� 
cobj� m   g h����  o   e f���� 0 keyvalue keyValue} ���� n  i m��� 4   j m���
�� 
cobj� m   k l���� � o   i j���� 0 keyvalue keyValue��  ��  ��  c R      �����
�� .ascrerr ****      � ****��  � ����
�� 
errn� o      �~�~ 0 n  �  d R   y ��}��
�} .ascrerr ****      � ****� m    ��� ��� 6 N o t   a   v a l i d   k e y - v a l u e   p a i r .� �|��
�| 
errn� o   { |�{�{ 0 n  � �z��y
�z 
erob� o   } ~�x�x 0 aref aRef�y  ��  �� 0 aref aRefY n  ) ,��� o   * ,�w�w 
0 _list_  � o   ) *�v�v 0 
listobject 
listObjectW ��u� L   � ��t�t  �u  < R      �s��
�s .ascrerr ****      � ****� o      �r�r 0 etext eText� �q��
�q 
errn� o      �p�p 0 enumber eNumber� �o��
�o 
erob� o      �n�n 0 efrom eFrom� �m��l
�m 
errt� o      �k�k 
0 eto eTo�l  = I   � ��j��i�j 
0 _error  � ��� m   � ��� ���   a d d K e y s A n d V a l u e s� ��� o   � ��h�h 0 etext eText� ��� o   � ��g�g 0 enumber eNumber� ��� o   � ��f�f 0 efrom eFrom� ��e� o   � ��d�d 
0 eto eTo�e  �i  9 %  list of form {{KEY,VALUE},...}   : ��� >   l i s t   o f   f o r m   { { K E Y , V A L U E } , . . . }3 ��� l     �c�b�a�c  �b  �a  � ��� i  N Q��� I      �`�_�^�` $0 getkeysandvalues getKeysAndValues�_  �^  � k     K�� ��� h     �]��] 0 
listobject 
listObject� j     �\��\ 
0 _list_  � J     �[�[  � ��� X    E��Z�� k    @�� ��� r    ��� n   ��� 1    �Y
�Y 
pcnt� o    �X�X 0 	bucketref 	bucketRef� o      �W�W 0 mybucket myBucket� ��V� V     @��� k   ( ;�� ��� r   ( 5��� J   ( 0�� ��� n  ( +��� o   ) +�U�U 0 k  � o   ( )�T�T 0 mybucket myBucket� ��S� n  + .��� o   , .�R�R 0 v  � o   + ,�Q�Q 0 mybucket myBucket�S  � n      ���  ;   3 4� n  0 3��� o   1 3�P�P 
0 _list_  � o   0 1�O�O 0 
listobject 
listObject� ��N� r   6 ;��� n  6 9��� o   7 9�M�M 0 nextitem nextItem� o   6 7�L�L 0 mybucket myBucket� o      �K�K 0 mybucket myBucket�N  � >  $ '��� o   $ %�J�J 0 mybucket myBucket� m   % &�I
�I 
msng�V  �Z 0 	bucketref 	bucketRef� n   ��� o    �H�H 0 _buckets  �  f    � ��G� L   F K�� n  F J��� o   G I�F�F 
0 _list_  � o   F G�E�E 0 
listobject 
listObject�G  � ��� l     �D�C�B�D  �C  �B  � ��� i  R U��� I      �A�@�?�A 0 getkeys getKeys�@  �?  � k     F�� ��� h     �>��> 0 
listobject 
listObject� j     �=��= 
0 _list_  � J     �<�<  � ��� X    @��;�� k    ;�� ��� r    ��� n   ��� 1    �:
�: 
pcnt� o    �9�9 0 	bucketref 	bucketRef� o      �8�8 0 mybucket myBucket� ��7� V     ;��� k   ( 6�� ��� r   ( 0��� n  ( +��� o   ) +�6�6 0 k  � o   ( )�5�5 0 mybucket myBucket� n      ���  ;   . /� n  + .��� o   , .�4�4 
0 _list_  � o   + ,�3�3 0 
listobject 
listObject�  �2  r   1 6 n  1 4 o   2 4�1�1 0 nextitem nextItem o   1 2�0�0 0 mybucket myBucket o      �/�/ 0 mybucket myBucket�2  � >  $ ' o   $ %�.�. 0 mybucket myBucket m   % &�-
�- 
msng�7  �; 0 	bucketref 	bucketRef� n    o    �,�, 0 _buckets    f    � 	�+	 L   A F

 n  A E o   B D�*�* 
0 _list_   o   A B�)�) 0 
listobject 
listObject�+  �  l     �(�'�&�(  �'  �&    i  V Y I      �%�$�#�% 0 	getvalues 	getValues�$  �#   k     F  h     �"�" 0 
listobject 
listObject j     �!�! 
0 _list_   J     � �     X    @� k    ;  r      n   !"! 1    �
� 
pcnt" o    �� 0 	bucketref 	bucketRef  o      �� 0 mybucket myBucket #�# V     ;$%$ k   ( 6&& '(' r   ( 0)*) n  ( ++,+ o   ) +�� 0 v  , o   ( )�� 0 mybucket myBucket* n      -.-  ;   . /. n  + ./0/ o   , .�� 
0 _list_  0 o   + ,�� 0 
listobject 
listObject( 1�1 r   1 6232 n  1 4454 o   2 4�� 0 nextitem nextItem5 o   1 2�� 0 mybucket myBucket3 o      �� 0 mybucket myBucket�  % >  $ '676 o   $ %�� 0 mybucket myBucket7 m   % &�
� 
msng�  � 0 	bucketref 	bucketRef n   898 o    �� 0 _buckets  9  f     :�: L   A F;; n  A E<=< o   B D�� 
0 _list_  = o   A B�� 0 
listobject 
listObject�   >�> l     ��
�	�  �
  �	  �  ��   � � { key-value collection, analogous to NSMutableDictionary (note: keys must be text, or objects that reliably coerce to text)	    � �?? �   k e y - v a l u e   c o l l e c t i o n ,   a n a l o g o u s   t o   N S M u t a b l e D i c t i o n a r y   ( n o t e :   k e y s   m u s t   b e   t e x t ,   o r   o b j e c t s   t h a t   r e l i a b l y   c o e r c e   t o   t e x t ) 	 � @A@ l     ����  �  �  A BCB l     ����  �  �  C DED l     �FG�  F  -----   G �HH 
 - - - - -E IJI l     �� ���  �   ��  J KLK l     ��������  ��  ��  L MNM i   OPO I     ������
�� .Obj:Stacnull��� ��� null��  ��  P l    QRSQ h     ��T�� "0 stackcollection StackCollectionT k      UU VWV l     ��������  ��  ��  W XYX j     ��Z�� 	0 _head  Z m     ��
�� 
msngY [\[ j    ��]�� 
0 _count  ] m    ����  \ ^_^ l     ��������  ��  ��  _ `a` i   	bcb I      ��d���� 
0 _error  d efe o      ���� 0 handlername handlerNamef ghg o      ���� 0 etext eTexth iji o      ���� 0 enumber eNumberj klk o      ���� 0 efrom eFroml m��m o      ���� 
0 eto eTo��  ��  c n    non I    ��p���� $0 throwmethoderror throwMethodErrorp qrq m    ss �tt  O b j e c t sr uvu m    ww �xx  S t a c k C o l l e c t i o nv yzy o    ���� 0 handlername handlerNamez {|{ o    	���� 0 etext eText| }~} o   	 
���� 0 enumber eNumber~ � o   
 ���� 0 efrom eFrom� ���� o    ���� 
0 eto eTo��  ��  o o     ���� 0 _support  a ��� l     ��������  ��  ��  � ��� i  
 ��� I      �������� 0 
countitems 
countItems��  ��  � L     �� o     ���� 
0 _count  � ��� l     ��������  ��  ��  � ��� i   ��� I      ������� 0 additem addItem� ���� o      ���� 0 thevalue theValue��  ��  � k     !�� ��� l     ������  � . ( add a new value to the top of the stack   � ��� P   a d d   a   n e w   v a l u e   t o   t h e   t o p   o f   t h e   s t a c k� ��� r     ��� K     
�� ������ 0 v  � o    ���� 0 thevalue theValue� ������� 0 nextitem nextItem� o    ���� 	0 _head  ��  � o      ���� 	0 _head  � ��� r    ��� [    ��� o    ���� 
0 _count  � m    ���� � o      ���� 
0 _count  � ���� L    !����  ��  � ��� l     ��������  ��  ��  � ��� i   ��� I      �������� 0 
removeitem 
removeItem��  ��  � l    R���� Q     R���� k    @�� ��� Z   ������� =   
��� o    ���� 	0 _head  � m    	��
�� 
msng� R    ����
�� .ascrerr ****      � ****� m    �� ���  S t a c k   i s   e m p t y .� �����
�� 
errn� m    �����@��  ��  ��  � ��� r    !��� n    ��� o    ���� 0 v  � o    ���� 	0 _head  � o      ���� 0 thevalue theValue� ��� r   " /��� n   " )��� o   ' )���� 0 nextitem nextItem� o   " '���� 	0 _head  � o      ���� 	0 _head  � ��� r   0 =��� \   0 7��� o   0 5���� 
0 _count  � m   5 6���� � o      ���� 
0 _count  � ���� L   > @�� o   > ?���� 0 thevalue theValue��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I   H R������� 
0 _error  � ��� m   I J�� ���  r e m o v e I t e m� ��� o   J K���� 0 etext eText� ��� o   K L���� 0 enumber eNumber� ��� o   L M���� 0 efrom eFrom� ���� o   M N���� 
0 eto eTo��  ��  � * $ remove and return the topmost value   � ��� H   r e m o v e   a n d   r e t u r n   t h e   t o p m o s t   v a l u e� ��� l     ��������  ��  ��  � ��� i   ��� I      ��������  0 deleteallitems deleteAllItems��  ��  � k     �� ��� r     ��� m     ��
�� 
msng� o      ���� 	0 _head  � ��� r    ��� m    	����  � o      ���� 
0 _count  � ���� L    ����  ��  � ��� l     ��������  ��  ��  � ��� i   ��� I      �������� 0 getitem getItem��  ��  � l    3���� Q     3� � k    !  Z   ���� =   
 o    ���� 	0 _head   m    	��
�� 
msng R    ��	

�� .ascrerr ****      � ****	 m     �  S t a c k   i s   e m p t y .
 ����
�� 
errn m    �����@��  ��  ��   � L    ! n      o    �~�~ 0 v   o    �}�} 	0 _head  �    R      �|
�| .ascrerr ****      � **** o      �{�{ 0 etext eText �z
�z 
errn o      �y�y 0 enumber eNumber �x
�x 
erob o      �w�w 0 efrom eFrom �v�u
�v 
errt o      �t�t 
0 eto eTo�u   I   ) 3�s�r�s 
0 _error    m   * + �  g e t I t e m  o   + ,�q�q 0 etext eText  !  o   , -�p�p 0 enumber eNumber! "#" o   - .�o�o 0 efrom eFrom# $�n$ o   . /�m�m 
0 eto eTo�n  �r  � 3 - return the topmost value without removing it   � �%% Z   r e t u r n   t h e   t o p m o s t   v a l u e   w i t h o u t   r e m o v i n g   i t� &'& l     �l�k�j�l  �k  �j  ' ()( i   !*+* I      �i�h�g�i &0 objectdescription objectDescription�h  �g  + L     
,, b     	-.- b     /0/ m     11 �22 & � s t a c k   c o l l e c t i o n   (0 o    �f�f 
0 _count  . m    33 �44    i t e m s ) �) 565 l     �e�d�c�e  �d  �c  6 787 i  " %9:9 I      �b�a�`�b 0 
copyobject 
copyObject�a  �`  : k     i;; <=< r     >?> I    �_�^�]
�_ .Obj:Stacnull��� ��� null�^  �]  ? o      �\�\ 0 	newobject 	newObject= @A@ Z    fBC�[�ZB ?    DED o    �Y�Y 
0 _count  E m    �X�X  C k    bFF GHG r    IJI o    �W�W 
0 _count  J n     KLK o    �V�V 
0 _count  L o    �U�U 0 	newobject 	newObjectH MNM r    *OPO K    (QQ �TRS�T 0 v  R n   $TUT o   " $�S�S 0 v  U o    "�R�R 	0 _head  S �QV�P�Q 0 nextitem nextItemV m   % &�O
�O 
msng�P  P o      �N�N 0 newhead newHeadN WXW r   + 0YZY o   + ,�M�M 0 newhead newHeadZ n     [\[ o   - /�L�L 	0 _head  \ o   , -�K�K 0 	newobject 	newObjectX ]^] r   1 :_`_ n  1 8aba o   6 8�J�J 0 nextitem nextItemb o   1 6�I�I 	0 _head  ` o      �H�H 0 oldhead oldHead^ c�Gc V   ; bded k   C ]ff ghg r   C Miji K   C Kkk �Flm�F 0 v  l n  D Gnon o   E G�E�E 0 v  o o   D E�D�D 0 oldhead oldHeadm �Cp�B�C 0 nextitem nextItemp m   H I�A
�A 
msng�B  j o      �@�@ 0 tmp  h qrq r   N Ssts o   N O�?�? 0 tmp  t n     uvu o   P R�>�> 0 nextitem nextItemv o   O P�=�= 0 newhead newHeadr wxw r   T Wyzy o   T U�<�< 0 tmp  z o      �;�; 0 newhead newHeadx {�:{ r   X ]|}| n  X [~~ o   Y [�9�9 0 nextitem nextItem o   X Y�8�8 0 oldhead oldHead} o      �7�7 0 oldhead oldHead�:  e >  ? B��� o   ? @�6�6 0 oldhead oldHead� m   @ A�5
�5 
msng�G  �[  �Z  A ��4� L   g i�� o   g h�3�3 0 	newobject 	newObject�4  8 ��2� l     �1�0�/�1  �0  �/  �2  R !  Last-In-First-Out sequence   S ��� 6   L a s t - I n - F i r s t - O u t   s e q u e n c eN ��� l     �.�-�,�.  �-  �,  � ��� l     �+�*�)�+  �*  �)  � ��� i   ��� I     �(�'�&
�( .Obj:Queunull��� ��� null�'  �&  � l    ���� h     �%��% "0 queuecollection QueueCollection� k      �� ��� l     �$�#�"�$  �#  �"  � ��� j     �!��! 	0 _back  � m     � 
�  
msng� ��� j    ��� 
0 _front  � m    �
� 
msng� ��� j    ��� 
0 _count  � m    ��  � ��� l     ����  �  �  � ��� i  	 ��� I      ���� 
0 _error  � ��� o      �� 0 handlername handlerName� ��� o      �� 0 etext eText� ��� o      �� 0 enumber eNumber� ��� o      �� 0 efrom eFrom� ��� o      �� 
0 eto eTo�  �  � n    ��� I    ���� $0 throwmethoderror throwMethodError� ��� m    �� ���  O b j e c t s� ��� m    �� ���  Q u e u e C o l l e c t i o n� ��� o    �� 0 handlername handlerName� ��� o    	�� 0 etext eText� ��� o   	 
�� 0 enumber eNumber� ��� o   
 �� 0 efrom eFrom� ��
� o    �	�	 
0 eto eTo�
  �  � o     �� 0 _support  � ��� l     ����  �  �  � ��� i   ��� I      ���� 0 
countitems 
countItems�  �  � L     �� o     �� 
0 _count  � ��� l     � �����   ��  ��  � ��� i   ��� I      ������� 0 additem addItem� ���� o      ���� 0 thevalue theValue��  ��  � k     S�� ��� l     ������  � / ) add a new value to the back of the queue   � ��� R   a d d   a   n e w   v a l u e   t o   t h e   b a c k   o f   t h e   q u e u e� ��� r     ��� K     �� ������ 0 v  � o    ���� 0 thevalue theValue� ������� 0 nextitem nextItem� m    ��
�� 
msng��  � o      ���� 0 nextitem nextItem� ��� Z  	  ������� >  	 ��� o   	 ���� 	0 _back  � m    ��
�� 
msng� r    ��� o    ���� 0 nextitem nextItem� n      ��� o    ���� 0 nextitem nextItem� o    ���� 	0 _back  ��  ��  � ��� r   ! (��� o   ! "���� 0 nextitem nextItem� o      ���� 	0 _back  � ��� Z  ) B������� =  ) 0��� o   ) .���� 
0 _front  � m   . /��
�� 
msng� r   3 >��� o   3 8���� 	0 _back  � o      ���� 
0 _front  ��  ��  � ��� r   C P��� [   C J��� o   C H���� 
0 _count  � m   H I���� � o      ���� 
0 _count  � ���� L   Q S����  ��  � ��� l     ��������  ��  ��  � ��� i      I      �������� 0 
removeitem 
removeItem��  ��   l    h Q     h k    V 	
	 Z   ���� =   
 o    ���� 
0 _front   m    	��
�� 
msng R    ��
�� .ascrerr ****      � **** m     �  Q u e u e   i s   e m p t y . ����
�� 
errn m    �����@��  ��  ��  
  r    ! n     o    ���� 0 v   o    ���� 
0 _front   o      ���� 0 thevalue theValue  r   " / n   " ) o   ' )���� 0 nextitem nextItem o   " '���� 
0 _front   o      ���� 
0 _front    !  Z  0 E"#����" =  0 7$%$ o   0 5���� 
0 _front  % m   5 6��
�� 
msng# r   : A&'& m   : ;��
�� 
msng' o      ���� 	0 _back  ��  ��  ! ()( r   F S*+* \   F M,-, o   F K���� 
0 _count  - m   K L���� + o      ���� 
0 _count  ) .��. L   T V// o   T U���� 0 thevalue theValue��   R      ��01
�� .ascrerr ****      � ****0 o      ���� 0 etext eText1 ��23
�� 
errn2 o      ���� 0 enumber eNumber3 ��45
�� 
erob4 o      ���� 0 efrom eFrom5 ��6��
�� 
errt6 o      ���� 
0 eto eTo��   I   ^ h��7���� 
0 _error  7 898 m   _ `:: �;;  r e m o v e I t e m9 <=< o   ` a���� 0 etext eText= >?> o   a b���� 0 enumber eNumber? @A@ o   b c���� 0 efrom eFromA B��B o   c d���� 
0 eto eTo��  ��   < 6 remove and return the value at the front of the queue    �CC l   r e m o v e   a n d   r e t u r n   t h e   v a l u e   a t   t h e   f r o n t   o f   t h e   q u e u e� DED l     ��������  ��  ��  E FGF i   HIH I      ��������  0 deleteallitems deleteAllItems��  ��  I k     JJ KLK r     MNM m     ��
�� 
msngN o      ���� 	0 _back  L OPO r    QRQ m    	��
�� 
msngR o      ���� 
0 _front  P STS r    UVU m    ����  V o      ���� 
0 _count  T W��W L    ����  ��  G XYX l     ��������  ��  ��  Y Z[Z i    \]\ I      �������� 0 getitem getItem��  ��  ] l    3^_`^ Q     3abca k    !dd efe Z   gh����g =   
iji o    ���� 
0 _front  j m    	��
�� 
msngh R    ��kl
�� .ascrerr ****      � ****k m    mm �nn  Q u e u e   i s   e m p t y .l ��o��
�� 
errno m    �����@��  ��  ��  f p��p L    !qq n     rsr o    ���� 0 v  s o    ���� 
0 _front  ��  b R      ��tu
�� .ascrerr ****      � ****t o      ���� 0 etext eTextu ��vw
�� 
errnv o      ���� 0 enumber eNumberw ��xy
�� 
erobx o      ���� 0 efrom eFromy ��z��
�� 
errtz o      ���� 
0 eto eTo��  c I   ) 3��{���� 
0 _error  { |}| m   * +~~ �  g e t I t e m} ��� o   + ,���� 0 etext eText� ��� o   , -���� 0 enumber eNumber� ��� o   - .���� 0 efrom eFrom� ���� o   . /���� 
0 eto eTo��  ��  _ E ? return the value at the front of the queue without removing it   ` ��� ~   r e t u r n   t h e   v a l u e   a t   t h e   f r o n t   o f   t h e   q u e u e   w i t h o u t   r e m o v i n g   i t[ ��� l     ����~��  �  �~  � ��� i  ! $��� I      �}�|�{�} &0 objectdescription objectDescription�|  �{  � L     
�� b     	��� b     ��� m     �� ��� & � q u e u e   c o l l e c t i o n   (� o    �z�z 
0 _count  � m    �� ���    i t e m s ) �� ��� l     �y�x�w�y  �x  �w  � ��� i  % (��� I      �v�u�t�v 0 
copyobject 
copyObject�u  �t  � k     o�� ��� r     ��� I    �s�r�q
�s .Obj:Queunull��� ��� null�r  �q  � o      �p�p 0 	newobject 	newObject� ��� Z    l���o�n� ?    ��� o    �m�m 
0 _count  � m    �l�l  � k    h�� ��� r    ��� o    �k�k 
0 _count  � n     ��� o    �j�j 
0 _count  � o    �i�i 0 	newobject 	newObject� ��� r    *��� K    (�� �h���h 0 v  � n   $��� o   " $�g�g 0 v  � o    "�f�f 
0 _front  � �e��d�e 0 nextitem nextItem� m   % &�c
�c 
msng�d  � o      �b�b 0 newfront newFront� ��� r   + 0��� o   + ,�a�a 0 newfront newFront� n     ��� o   - /�`�` 
0 _front  � o   , -�_�_ 0 	newobject 	newObject� ��� r   1 :��� n  1 8��� o   6 8�^�^ 0 nextitem nextItem� o   1 6�]�] 
0 _front  � o      �\�\ 0 oldfront oldFront� ��� V   ; b��� k   C ]�� ��� r   C M��� K   C K�� �[���[ 0 v  � n  D G��� o   E G�Z�Z 0 v  � o   D E�Y�Y 0 oldfront oldFront� �X��W�X 0 nextitem nextItem� m   H I�V
�V 
msng�W  � o      �U�U 0 tmp  � ��� r   N S��� o   N O�T�T 0 tmp  � n     ��� o   P R�S�S 0 nextitem nextItem� o   O P�R�R 0 newfront newFront� ��� r   T W��� o   T U�Q�Q 0 tmp  � o      �P�P 0 newfront newFront� ��O� r   X ]��� n  X [��� o   Y [�N�N 0 nextitem nextItem� o   X Y�M�M 0 oldfront oldFront� o      �L�L 0 oldfront oldFront�O  � >  ? B��� o   ? @�K�K 0 oldfront oldFront� m   @ A�J
�J 
msng� ��I� r   c h��� o   c d�H�H 0 newfront newFront� n     ��� o   e g�G�G 	0 _back  � o   d e�F�F 0 	newobject 	newObject�I  �o  �n  � ��E� L   m o�� o   m n�D�D 0 	newobject 	newObject�E  � ��C� l     �B�A�@�B  �A  �@  �C  � "  First-In-First-Out sequence   � ��� 8   F i r s t - I n - F i r s t - O u t   s e q u e n c e� ��� l     �?�>�=�?  �>  �=  � ��� l     �<�;�:�<  �;  �:  � ��� l     �9���9  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �8���8  �   Timing/Profiling   � ��� "   T i m i n g / P r o f i l i n g� ��� l     �7�6�5�7  �6  �5  � ��� l     �4�3�2�4  �3  �2  � 	 		  i   			 I     �1�0	
�1 .Obj:Timenull��� ��� null�0  	 �/	�.
�/ 
Name	 |�-�,	�+	�-  �,  	 o      �*�* 0 nametext nameText�+  	 l     	�)�(	 m      				 �	
	
  �)  �(  �.  	 k     		 			 r     			 n    			 I    �'	�&�' "0 astextparameter asTextParameter	 			 o    �%�% 0 nametext nameText	 	�$	 m    		 �		  �$  �&  	 o     �#�# 0 _support  	 o      �"�" 0 nametext nameText	 	�!	 h    � 	�  0 timerobject TimerObject	 k      		 			 l     ����  �  �  	 			 x     �	��  	 4    �	 
� 
frmk	  m    	!	! �	"	"  F o u n d a t i o n�  	 	#	$	# l     	%	&	'	% j    �	(� 0 
_starttime 
_startTime	( m    �
� 
msng	& � � because AS can't serialize ASOC objects when saving or autosaving scripts, this object stores start and end times as NSTimeInterval - i.e. AS real - rather than NSDate instances.   	' �	)	)f   b e c a u s e   A S   c a n ' t   s e r i a l i z e   A S O C   o b j e c t s   w h e n   s a v i n g   o r   a u t o s a v i n g   s c r i p t s ,   t h i s   o b j e c t   s t o r e s   s t a r t   a n d   e n d   t i m e s   a s   N S T i m e I n t e r v a l   -   i . e .   A S   r e a l   -   r a t h e r   t h a n   N S D a t e   i n s t a n c e s .	$ 	*	+	* j    �	,� 0 _totalseconds _totalSeconds	, m    	-	-         	+ 	.	/	. j    �	0� 0 
_isrunning 
_isRunning	0 m    �
� boovfals	/ 	1	2	1 l     ����  �  �  	2 	3	4	3 i   	5	6	5 I      ���� 0 	timername 	timerName�  �  	6 L     	7	7 o     �� 0 nametext nameText	4 	8	9	8 l     ����  �  �  	9 	:	;	: i   	<	=	< I      �
�	��
 0 
starttimer 
startTimer�	  �  	= k     '	>	> 	?	@	? Z    	A	B��	A o     �� 0 
_isrunning 
_isRunning	B L    
��  �  �  	@ 	C	D	C r    	E	F	E m    �
� boovtrue	F o      �� 0 
_isrunning 
_isRunning	D 	G	H	G l   �� ���  �   ��  	H 	I	J	I r    $	K	L	K n   	M	N	M I    �������� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate��  ��  	N n   	O	P	O o    ���� 0 nsdate NSDate	P m    ��
�� misccura	L o      ���� 0 
_starttime 
_startTime	J 	Q��	Q L   % '	R	R  f   % &��  	; 	S	T	S l     ��������  ��  ��  	T 	U	V	U i   	W	X	W I      �������� 0 	stoptimer 	stopTimer��  ��  	X k     8	Y	Y 	Z	[	Z Z    	\	]����	\ H     	^	^ o     ���� 0 
_isrunning 
_isRunning	] L   	 	_	_ m   	 
����  ��  ��  	[ 	`	a	` r    	b	c	b \    	d	e	d l   	f����	f n   	g	h	g I    �������� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate��  ��  	h n   	i	j	i o    ���� 0 nsdate NSDate	j m    ��
�� misccura��  ��  	e o    ���� 0 
_starttime 
_startTime	c o      ���� 0 elapsedtime elapsedTime	a 	k	l	k r     -	m	n	m [     '	o	p	o o     %���� 0 _totalseconds _totalSeconds	p o   % &���� 0 elapsedtime elapsedTime	n o      ���� 0 _totalseconds _totalSeconds	l 	q	r	q r   . 5	s	t	s m   . /��
�� boovfals	t o      ���� 0 
_isrunning 
_isRunning	r 	u��	u L   6 8	v	v o   6 7���� 0 elapsedtime elapsedTime��  	V 	w	x	w l     ��������  ��  ��  	x 	y	z	y i    #	{	|	{ I      �������� 0 elapsedtime elapsedTime��  ��  	| Z     	}	~��		} o     ���� 0 
_isrunning 
_isRunning	~ L    	�	� \    	�	�	� l   	�����	� n   	�	�	� I   	 �������� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate��  ��  	� o    	���� 0 nsdate NSDate��  ��  	� o    ���� 0 
_starttime 
_startTime��  	 L    	�	� m    ����  	z 	�	�	� l     ��������  ��  ��  	� 	�	�	� i  $ '	�	�	� I      �������� 0 	totaltime 	totalTime��  ��  	� Z     	�	���	�	� o     ���� 0 
_isrunning 
_isRunning	� L    	�	� [    	�	�	� o    ���� 0 _totalseconds _totalSeconds	� I    �������� 0 elapsedtime elapsedTime��  ��  ��  	� L    	�	� o    ���� 0 _totalseconds _totalSeconds	� 	�	�	� l     ��������  ��  ��  	� 	�	�	� l     ��������  ��  ��  	� 	�	�	� i  ( +	�	�	� I      �������� &0 objectdescription objectDescription��  ��  	� k     F	�	� 	�	�	� Z     !	�	���	�	� o     ���� 0 
_isrunning 
_isRunning	� r    	�	�	� b    	�	�	� b    	�	�	� m    		�	� �	�	�  e l a p s e d   t i m e :  	� I   	 �������� 0 elapsedtime elapsedTime��  ��  	� m    	�	� �	�	�  s	� o      ���� 0 infotext infoText��  	� r    !	�	�	� b    	�	�	� b    	�	�	� m    	�	� �	�	�  t o t a l   t i m e :  	� I    �������� 0 	totaltime 	totalTime��  ��  	� m    	�	� �	�	�  s	� o      ���� 0 infotext infoText	� 	�	�	� Z  " ?	�	�����	� >   " +	�	�	� n  " )	�	�	� 1   ' )��
�� 
leng	� o   " '���� 0 nametext nameText	� m   ) *����  	� r   . ;	�	�	� b   . 9	�	�	� b   . 7	�	�	� b   . 5	�	�	� m   . /	�	� �	�	�  	� o   / 4���� 0 nametext nameText	� m   5 6	�	� �	�	�    	� o   7 8���� 0 infotext infoText	� o      ���� 0 infotext infoText��  ��  	� 	���	� L   @ F	�	� b   @ E	�	�	� b   @ C	�	�	� m   @ A	�	� �	�	�  � t i m e r   o b j e c t   (	� o   A B���� 0 infotext infoText	� m   C D	�	� �	�	�  ) ���  	� 	�	�	� l     ��������  ��  ��  	� 	�	�	� i  , /	�	�	� I      �������� 0 
copyobject 
copyObject��  ��  	� k     .	�	� 	�	�	� r     	�	�	� I    ����	�
�� .Obj:Timenull��� ��� null��  	� ��	���
�� 
Name	� o    ���� 0 nametext nameText��  	� o      ���� 0 	newobject 	newObject	� 	�	�	� r    	�	�	� o    ���� 0 
_starttime 
_startTime	� n     	�	�	� o    ���� 0 
_starttime 
_startTime	� o    ���� 0 	newobject 	newObject	� 	�	�	� r    !	�	�	� o    ���� 0 _totalseconds _totalSeconds	� n     	�	�	� o     ���� 0 _totalseconds _totalSeconds	� o    ���� 0 	newobject 	newObject	� 	�	�	� r   " +	�	�	� o   " '���� 0 
_isrunning 
_isRunning	� n     	�	�	� o   ( *���� 0 
_isrunning 
_isRunning	� o   ' (���� 0 	newobject 	newObject	� 	���	� L   , .	�	� o   , -���� 0 	newobject 	newObject��  	� 	���	� l     ��������  ��  ��  ��  �!  	 	�	�	� l     ��������  ��  ��  	� 	�	�	� l     ��������  ��  ��  	� 	���	� l     �������  ��  �  ��       	�~	�	�	�	�	�
 

�~  	� �}�|�{�z�y�x�w�} 0 _support  �| 
0 _error  �{  0 _makeemptylist _makeEmptyList
�z .Obj:Dictnull��� ��� null
�y .Obj:Stacnull��� ��� null
�x .Obj:Queunull��� ��� null
�w .Obj:Timenull��� ��� null	� 

   �v "
�v 
scpt	� �u *�t�s

�r�u 
0 _error  �t �q
�q 
  �p�o�n�m�l�p 0 handlername handlerName�o 0 etext eText�n 0 enumber eNumber�m 0 efrom eFrom�l 
0 eto eTo�s  
 �k�j�i�h�g�k 0 handlername handlerName�j 0 etext eText�i 0 enumber eNumber�h 0 efrom eFrom�g 
0 eto eTo
  :�f�e�f �e &0 throwcommanderror throwCommandError�r b   ࠡ����+ 	� �d X�c�b

�a�d  0 _makeemptylist _makeEmptyList�c �`
	�` 
	  �_�_ 0 n  �b  
 �^�]�^ 0 n  �] 0 l  
 �\
�\ 
msng�a "�kvE�O h�k��%E�O�l"E�[OY��O�	� �[ ��Z�Y


�X
�[ .Obj:Dictnull��� ��� null�Z  �Y  

 �W�W ,0 dictionarycollection DictionaryCollection
 �V �
�V ,0 dictionarycollection DictionaryCollection
 �U
�T�S

�R
�U .ascrinit****      � ****
 k     Y

  �

  �

  �

  �

  �

  �

 �

 �

 X

 �

 �

 N

 h

 w

 

 2
 
  �
!
! �
"
" �Q�Q  �T  �S  
 �P�O�N�M�L�K�J�I�H�G�F�E�D�C�B�A�@�?�>
�P 
pimr�O 0 _buckets  �N 	0 _size  �M 
0 _count  �L 
0 _error  �K 0 	_keyindex 	_keyIndex�J 0 
countitems 
countItems�I 0 additem addItem�H 0 
removeitem 
removeItem�G  0 deleteallitems deleteAllItems�F 0 getitem getItem�E 0 containsitem containsItem�D &0 objectdescription objectDescription�C 0 
copyobject 
copyObject�B 0 adddictionary addDictionary�A $0 addkeysandvalues addKeysAndValues�@ $0 getkeysandvalues getKeysAndValues�? 0 getkeys getKeys�> 0 	getvalues 	getValues
 �=�< ��;�:�9�8�7�6
#
$
%
&
'
(
)
*
+
,
-
.
/
0
1
�= 
cobj
�< 
frmk�; �:  0 _makeemptylist _makeEmptyList�9 0 _buckets  
�8 
leng�7 	0 _size  �6 
0 _count  
# �5 ��4�3
2
3�2�5 
0 _error  �4 �1
4�1 
4  �0�/�.�-�,�0 0 handlername handlerName�/ 0 etext eText�. 0 enumber eNumber�- 0 efrom eFrom�, 
0 eto eTo�3  
2 �+�*�)�(�'�+ 0 handlername handlerName�* 0 etext eText�) 0 enumber eNumber�( 0 efrom eFrom�' 
0 eto eTo
3  � ��&�%�& �% $0 throwmethoderror throwMethodError�2 b   �ᠡ����+ 
$ �$ ��#�"
5
6�!�$ 0 	_keyindex 	_keyIndex�# � 
7�  
7  �� 0 thekey theKey�"  
5 ���� 0 thekey theKey� 0 hashnum hashNum� 0 divnum divNum
6 ����������������o��
�	����
8����
� 
kocl
� 
obj 
� .corecnte****       ****
� 
list
� 
bool
� 
reco
� 
scpt
� 
errn��\
� 
type
� 
pcls
� 
enum� 0 
asnsobject 
asNSObject� 0 typecodevalue typeCodeValue
� 
long
� 
doub�  J�
�
 
ctxt�	 ,0 asnormalizednsstring asNormalizedNSString� 0 hash  � �  
8 ��� 
� 
errn��\�   ��Y
� 
erob� �! �kv��l j
 �kv��l j�&
 �kv��l j�&
 �kv��l j�& )��lhY hO���mv��,kv b   �k+ j+ E�Y x��lv��,kv C�E�O�k#E�O�j �k�!E�Y hO�j 	�'E�Y hO�a  �a  E�Y hY b   �a &k+ j+ E�O�a  �a "E�Y hO�b  #kW X  )�a a �a a 
% �������
9
:���� 0 
countitems 
countItems��  ��  
9  
:  �� b  
& �������
;
<���� 0 additem addItem�� ��
=�� 
=  ������ 0 thekey theKey�� 0 thevalue theValue��  
; 	�������������������� 0 thekey theKey�� 0 thevalue theValue�� 0 keyindex keyIndex�� 0 	founditem 	foundItem�� 0 oldvalue oldValue�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
< ��������������������
>M������ 0 	_keyindex 	_keyIndex�� 0 _buckets  
�� 
cobj
�� 
msng�� 0 k  �� 0 v  �� 0 nextitem nextItem�� �� 0 etext eText
> ����
?
�� 
errn�� 0 enumber eNumber
? ����
@
�� 
erob�� 0 efrom eFrom
@ ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� � �*�k+  E�O�EQ�O)�,�/E�O��  %�����)�,�/FOb  kEc  OhY hO�� i ehZ��,�  %��,E�O��lvE[�k/��,FZ[�l/��,FZOhY hO��,�  "�������,FOb  kEc  OhY hO��,E�[OY��VW X 
 *쥦���+ 
' ��[����
A
B���� 0 
removeitem 
removeItem�� ��
C�� 
C  ���� 0 thekey theKey��  
A 
���������������������� 0 thekey theKey�� 0 keyindex keyIndex�� 0 	founditem 	foundItem�� 0 previtem prevItem�� 0 foundkey foundKey�� 0 thevalue theValue�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
B ������tu�������������������
D������� 0 	_keyindex 	_keyIndex�� 0 _buckets  
�� 
cobj
�� 
msng�� 0 k  �� 0 v  �� 0 nextitem nextItem
�� 
errn���@
�� 
erob�� �� 0 etext eText
D ����
E
�� 
errn�� 0 enumber eNumber
E ����
F
�� 
erob�� 0 efrom eFrom
F ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� � �*�k+  E�O)�,�/E�O�� _�E�O Wh����,E�O��  6��,E�O��  ��,)�,�/FY 	��,��,FOb  kEc  O�Y hO�E�O��,E�[OY��VO)�����W X  *a ����a + 
( �������
G
H����  0 deleteallitems deleteAllItems��  ��  
G  
H ���������� ��  0 _makeemptylist _makeEmptyList�� 0 _buckets  
�� 
leng�� "*�k+ )�,FO)�,�,Ec  OjEc  Oh
) �������
I
J���� 0 getitem getItem�� ��
K�� 
K  ���� 0 thekey theKey��  
I �������������� 0 thekey theKey�� 0 	founditem 	foundItem�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
J 	
����������������������4��
LC������ 0 _buckets  
�� 
cobj�� 0 	_keyindex 	_keyIndex
�� 
msng�� 0 k  �� 0 v  �� 0 nextitem nextItem
�� 
errn���@
�� 
erob�� �� 0 etext eText
L ����
M
�� 
errn�� 0 enumber eNumber
M ����
N
�� 
erob�� 0 efrom eFrom
N ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� [ F�� 5)�,�*�k+ /E�O #h����,�  
��,EY hO��,E�[OY��VO)�����W X  *a ����a + 
* ��Q����
O
P���� 0 containsitem containsItem�� ��
Q�� 
Q  ���� 0 thekey theKey��  
O ���� 0 thekey theKey
P ����
R�� 0 getitem getItem��  
R ������
�� 
errn���@��  ��  *�k+  OeW 	X  f
+ �k�~�}
S
T�|� &0 objectdescription objectDescription�~  �}  
S  
T qs�| �b  %�%
, �{z�z�y
U
V�x�{ 0 
copyobject 
copyObject�z  �y  
U 	�w�v�u�t�s�r�q�p�o�w 0 	newobject 	newObject�v 0 i  �u 0 	oldbucket 	oldBucket�t 0 	newbucket 	newBucket�s 0 tmp  �r 0 etext eText�q 0 enumber eNumber�p 0 efrom eFrom�o 
0 eto eTo
V �n�m�l��k�j�i�h�g�f�e
W�d�c
�n .Obj:Dictnull��� ��� null�m 0 _buckets  
�l 
leng
�k 
cobj
�j 
msng�i 0 k  �h 0 v  �g 0 nextitem nextItem�f �e 0 etext eText
W �b�a
X
�b 
errn�a 0 enumber eNumber
X �`�_
Y
�` 
erob�_ 0 efrom eFrom
Y �^�]�\
�^ 
errt�] 
0 eto eTo�\  �d �c 
0 _error  �x � �*j  E�Ob  j �)�,�,��,�, 	)j�Y hO kk)�,�,Ekh )�,�/E�O�� J��,��,���E�O���,�/FO ,h��,���,E�O��,��,���E�O���,FO�E�[OY��Y h[OY��Y hO�W X 
 *쥦���+ 
- �[�Z�Y
Z
[�X�[ 0 adddictionary addDictionary�Z �W
\�W 
\  �V�V $0 dictionaryobject dictionaryObject�Y  
Z 	�U�T�S�R�Q�P�O�N�M�U $0 dictionaryobject dictionaryObject�T 0 i  �S 0 otherbucket otherBucket�R 0 mybucket myBucket�Q 0 tmp  �P 0 etext eText�O 0 enumber eNumber�N 0 efrom eFrom�M 
0 eto eTo
[ �L�K�J7<=�I�H�G�F�E�D�C
]#�B�A�L 0 
countitems 
countItems�K 0 _buckets  
�J 
leng
�I 
cobj
�H 
msng�G 0 k  �F 0 v  �E 0 nextitem nextItem�D �C 0 etext eText
] �@�?
^
�@ 
errn�? 0 enumber eNumber
^ �>�=
_
�> 
erob�= 0 efrom eFrom
_ �<�;�:
�< 
errt�; 
0 eto eTo�:  �B �A 
0 _error  �XYH�j+  j7)�,�,��,�, 	)j�Y hO��k��,�,Ekh ��,�/E�O�� �)�,�/E�O��  f��,��,���E�Ob  kEc  O�)�,�/FO :h��,���,E�O��,��,���E�Ob  kEc  O���,FO�E�[OY��Y } zh���E�O chZ��,��,   �[�,\[�,\Zlv�[�,\[�,\ZlvFOY .��,�  %��,��,�����,FOb  kEc  OY hO��,E�[OY��O��,E�[OY��Y h[OY��VY hOhW X  *���+ 
. �95�8�7
`
a�6�9 $0 addkeysandvalues addKeysAndValues�8 �5
b�5 
b  �4�4 0 keyvaluelist keyValueList�7  
` 	�3�2�1�0�/�.�-�,�+�3 0 keyvaluelist keyValueList�2 0 
listobject 
listObject�1 0 aref aRef�0 0 keyvalue keyValue�/ 0 n  �. 0 etext eText�- 0 enumber eNumber�, 0 efrom eFrom�+ 
0 eto eTo
a �*�)�(�'�&�%�$M�#T
c�"�!� ����
d��
e���
�* 
kocl
�) 
list
�( .corecnte****       ****
�' 
errn�&�\
�% 
erob�$ �# 0 
listobject 
listObject
c �
f��
g
h�
� .ascrinit****      � ****
f k     
i
i T��  �  �  
g �� 
0 _list_  
h �� 
0 _list_  � b   ��" 
0 _list_  
�! 
cobj
�  
pcnt
� 
leng
� 
bool� 0 additem addItem�  
d ���
� 
errn� 0 n  �  � 0 etext eText
e ��
j
� 
errn� 0 enumber eNumber
j ��
k
� 
erob� 0 efrom eFrom
k �
�	�
�
 
errt�	 
0 eto eTo�  � � 
0 _error  �6 � ��kv��l j  )�����Y hO��K 
S�O a��,[��l kh ��,E�O 5�kv��l j 
 	��,l�& )��lhY hO*��k/��l/l+ W X  )���a [OY��OhW X  *a ����a + 
/ ����
l
m�� $0 getkeysandvalues getKeysAndValues�  �  
l ���� 0 
listobject 
listObject� 0 	bucketref 	bucketRef� 0 mybucket myBucket
m � �
n���������������������  0 
listobject 
listObject
n ��
o����
p
q��
�� .ascrinit****      � ****
o k     
r
r �����  ��  ��  
p ���� 
0 _list_  
q ���� 
0 _list_  �� jv��� 0 _buckets  
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pcnt
�� 
msng�� 0 k  �� 0 v  �� 
0 _list_  �� 0 nextitem nextItem� L��K S�O <)�,[��l kh ��,E�O h����,��,lv��,6FO��,E�[OY��[OY��O��,E
0 �������
s
t���� 0 getkeys getKeys��  ��  
s �������� 0 
listobject 
listObject�� 0 	bucketref 	bucketRef�� 0 mybucket myBucket
t ���
u�������������������� 0 
listobject 
listObject
u ��
v����
w
x��
�� .ascrinit****      � ****
v k     
y
y �����  ��  ��  
w ���� 
0 _list_  
x ���� 
0 _list_  �� jv��� 0 _buckets  
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pcnt
�� 
msng�� 0 k  �� 
0 _list_  �� 0 nextitem nextItem�� G��K S�O 7)�,[��l kh ��,E�O h����,��,6FO��,E�[OY��[OY��O��,E
1 ������
z
{���� 0 	getvalues 	getValues��  ��  
z �������� 0 
listobject 
listObject�� 0 	bucketref 	bucketRef�� 0 mybucket myBucket
{ ��
|�������������������� 0 
listobject 
listObject
| ��
}����
~
��
�� .ascrinit****      � ****
} k     
�
� ����  ��  ��  
~ ���� 
0 _list_  
 ���� 
0 _list_  �� jv��� 0 _buckets  
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pcnt
�� 
msng�� 0 v  �� 
0 _list_  �� 0 nextitem nextItem�� G��K S�O 7)�,[��l kh ��,E�O h����,��,6FO��,E�[OY��[OY��O��,E�R Z�*��/lkv�*�k+ �O)�,�,E�Oj�OL 	OL 
OL OL OL OL OL OL OL OL OL OL OL OL OL �X ��K S�
  ��P����
�
���
�� .Obj:Stacnull��� ��� null��  ��  
� ���� "0 stackcollection StackCollection
� ��T
��� "0 stackcollection StackCollection
� ��
�����
�
���
�� .ascrinit****      � ****
� k     %
�
� X
�
� [
�
� `
�
� �
�
� �
�
� �
�
� �
�
� �
�
� (
�
� 7����  ��  ��  
� 
���������������������� 	0 _head  �� 
0 _count  �� 
0 _error  �� 0 
countitems 
countItems�� 0 additem addItem�� 0 
removeitem 
removeItem��  0 deleteallitems deleteAllItems�� 0 getitem getItem�� &0 objectdescription objectDescription�� 0 
copyobject 
copyObject
� ������
�
�
�
�
�
�
�
�
�� 
msng�� 	0 _head  �� 
0 _count  
� ��c����
�
����� 
0 _error  �� ��
��� 
�  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  
� ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
� sw������ �� $0 throwmethoderror throwMethodError�� b   �ᠡ����+ 
� �������
�
����� 0 
countitems 
countItems��  ��  
�  
�  �� b  
� �������
�
����� 0 additem addItem�� ��
��� 
�  ���� 0 thevalue theValue��  
� ���� 0 thevalue theValue
� �������� 0 v  �� 0 nextitem nextItem�� �� "��b   �Ec   Ob  kEc  Oh
� �������
�
����� 0 
removeitem 
removeItem��  ��  
� ����������� 0 thevalue theValue�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom� 
0 eto eTo
� �~�}�|��{�z�y
���x�w
�~ 
msng
�} 
errn�|�@�{ 0 v  �z 0 nextitem nextItem�y 0 etext eText
� �v�u
�
�v 
errn�u 0 enumber eNumber
� �t�s
�
�t 
erob�s 0 efrom eFrom
� �r�q�p
�r 
errt�q 
0 eto eTo�p  �x �w 
0 _error  �� S Bb   �  )��l�Y hOb   �,E�Ob   �,Ec   Ob  kEc  O�W X  *衢���+ 

� �o��n�m
�
��l�o  0 deleteallitems deleteAllItems�n  �m  
�  
� �k
�k 
msng�l �Ec   OjEc  Oh
� �j��i�h
�
��g�j 0 getitem getItem�i  �h  
� �f�e�d�c�f 0 etext eText�e 0 enumber eNumber�d 0 efrom eFrom�c 
0 eto eTo
� 
�b�a�`�_�^
��]�\
�b 
msng
�a 
errn�`�@�_ 0 v  �^ 0 etext eText
� �[�Z
�
�[ 
errn�Z 0 enumber eNumber
� �Y�X
�
�Y 
erob�X 0 efrom eFrom
� �W�V�U
�W 
errt�V 
0 eto eTo�U  �] �\ 
0 _error  �g 4 #b   �  )��l�Y hOb   �,EW X  *砡���+ 	
� �T+�S�R
�
��Q�T &0 objectdescription objectDescription�S  �R  
�  
� 13�Q �b  %�%
� �P:�O�N
�
��M�P 0 
copyobject 
copyObject�O  �N  
� �L�K�J�I�L 0 	newobject 	newObject�K 0 newhead newHead�J 0 oldhead oldHead�I 0 tmp  
� �H�G�F�E�D�C�B
�H .Obj:Stacnull��� ��� null�G 
0 _count  �F 0 v  �E 0 nextitem nextItem
�D 
msng�C �B 	0 _head  �M j*j  E�Ob  j Ub  ��,FO�b   �,���E�O���,FOb   �,E�O &h����,���E�O���,FO�E�O��,E�[OY��Y hO��� &�Oj�OL OL OL OL OL OL OL 	OL 
�� ��K S�
 �A��@�?
�
��>
�A .Obj:Queunull��� ��� null�@  �?  
� �=�= "0 queuecollection QueueCollection
� �<�
��< "0 queuecollection QueueCollection
� �;
��:�9
�
��8
�; .ascrinit****      � ****
� k     (
�
� �
�
� �
�
� �
�
� �
�
� �
�
� �
�
� �
�
� F
�
� Z
�
� �
�
� ��7�7  �:  �9  
� �6�5�4�3�2�1�0�/�.�-�,�6 	0 _back  �5 
0 _front  �4 
0 _count  �3 
0 _error  �2 0 
countitems 
countItems�1 0 additem addItem�0 0 
removeitem 
removeItem�/  0 deleteallitems deleteAllItems�. 0 getitem getItem�- &0 objectdescription objectDescription�, 0 
copyobject 
copyObject
� �+�*�)�(
�
�
�
�
�
�
�
�
�+ 
msng�* 	0 _back  �) 
0 _front  �( 
0 _count  
� �'��&�%
�
��$�' 
0 _error  �& �#
��# 
�  �"�!� ���" 0 handlername handlerName�! 0 etext eText�  0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo�%  
� ������ 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo
� ����� � $0 throwmethoderror throwMethodError�$ b   �ᠡ����+ 
� ����
�
��� 0 
countitems 
countItems�  �  
�  
�  � b  
� ����
�
��� 0 additem addItem� �
�� 
�  �� 0 thevalue theValue�  
� ��� 0 thevalue theValue� 0 nextitem nextItem
� �
�	���
 0 v  �	 0 nextitem nextItem
� 
msng� � T����E�Ob   � �b   �,FY hO�Ec   Ob  �  b   Ec  Y hOb  kEc  Oh
� ���
�
��� 0 
removeitem 
removeItem�  �  
� ��� ����� 0 thevalue theValue� 0 etext eText�  0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
� ������������
�:����
�� 
msng
�� 
errn���@�� 0 v  �� 0 nextitem nextItem�� 0 etext eText
� ����
�
�� 
errn�� 0 enumber eNumber
� ����
�
�� 
erob�� 0 efrom eFrom
� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  � i Xb  �  )��l�Y hOb  �,E�Ob  �,Ec  Ob  �  �Ec   Y hOb  kEc  O�W X  *衢���+ 

� ��I����
�
�����  0 deleteallitems deleteAllItems��  ��  
�  
� ��
�� 
msng�� �Ec   O�Ec  OjEc  Oh
� ��]����
�
����� 0 getitem getItem��  ��  
� ���������� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo
� 
������m����
�~����
�� 
msng
�� 
errn���@�� 0 v  �� 0 etext eText
� ����
�
�� 
errn�� 0 enumber eNumber
� ����
�
�� 
erob�� 0 efrom eFrom
� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� 4 #b  �  )��l�Y hOb  �,EW X  *砡���+ 	
� �������
�
����� &0 objectdescription objectDescription��  ��  
�  
� ���� �b  %�%
� �������
�
����� 0 
copyobject 
copyObject��  ��  
� ���������� 0 	newobject 	newObject�� 0 newfront newFront�� 0 oldfront oldFront�� 0 tmp  
� ����������������
�� .Obj:Queunull��� ��� null�� 
0 _count  �� 0 v  �� 0 nextitem nextItem
�� 
msng�� �� 
0 _front  �� 	0 _back  �� p*j  E�Ob  j [b  ��,FO�b  �,���E�O���,FOb  �,E�O &h����,���E�O���,FO�E�O��,E�[OY��O���,FY hO��8 )�O�Oj�OL OL OL OL OL OL 	OL 
OL �> ��K S�
 ��	����
�
���
�� .Obj:Timenull��� ��� null��  �� ��
���
�� 
Name
� {����		�� 0 nametext nameText��  ��  
� ������ 0 nametext nameText�� 0 timerobject TimerObject
� 	����	
��� "0 astextparameter asTextParameter�� 0 timerobject TimerObject
� ��
�����
�
���
�� .ascrinit****      � ****
� k     /
�
� 	
�
� 	%
�
� 	*
�
� 	.
�
� 	3
�
� 	:
�
� 	U
�
� 	y
�
� 	�
�
� 	�
�
� 	�����  ��  ��  
� ����������������������
�� 
pimr�� 0 
_starttime 
_startTime�� 0 _totalseconds _totalSeconds�� 0 
_isrunning 
_isRunning�� 0 	timername 	timerName�� 0 
starttimer 
startTimer�� 0 	stoptimer 	stopTimer�� 0 elapsedtime elapsedTime�� 0 	totaltime 	totalTime�� &0 objectdescription objectDescription�� 0 
copyobject 
copyObject
� ����	!����	-����
�
�
�
�
�
�
�
�� 
cobj
�� 
frmk
�� 
msng�� 0 
_starttime 
_startTime�� 0 _totalseconds _totalSeconds�� 0 
_isrunning 
_isRunning
� ��	6����
�
����� 0 	timername 	timerName��  ��  
�  
�  �� b   
� ��	=����
�
����� 0 
starttimer 
startTimer��  ��  
�  
� ������
�� misccura�� 0 nsdate NSDate�� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�� (b   hY hOeEc  O��,j+ Ec  O)
� ��	X����
� ���� 0 	stoptimer 	stopTimer��  ��  
� ���� 0 elapsedtime elapsedTime  ������
�� misccura�� 0 nsdate NSDate�� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�� 9b   jY hO��,j+ b  E�Ob  �Ec  OfEc  O�
� ��	|�������� 0 elapsedtime elapsedTime��  ��   ���� 0 nsdate NSDate ���� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�� b   �j+  b  Y j
� ��	��������� 0 	totaltime 	totalTime��  ��     ���� 0 elapsedtime elapsedTime�� b   b  *j+  Y b  
� �	��~�}�|� &0 objectdescription objectDescription�~  �}   �{�{ 0 infotext infoText 	��z	�	��y	��x	�	�	�	��z 0 elapsedtime elapsedTime�y 0 	totaltime 	totalTime
�x 
leng�| Gb   �*j+ %�%E�Y �*j+ %�%E�Ob   �,j �b   %�%�%E�Y hO�%�%
� �w	��v�u�t�w 0 
copyobject 
copyObject�v  �u   �s�s 0 	newobject 	newObject �r�q�p�o�n
�r 
Name
�q .Obj:Timenull��� ��� null�p 0 
_starttime 
_startTime�o 0 _totalseconds _totalSeconds�n 0 
_isrunning 
_isRunning�t /*�b   l E�Ob  ��,FOb  ��,FOb  ��,FO��� 0�*��/lkv��O�Of�OL OL 	OL 
OL OL OL OL �� b   ��l+ E�O��K S�ascr  ��ޭ