FasdUAS 1.101.10   ��   ��    k             l      ��  ��   
�
� List -- manipulate AppleScript lists 

Notes:

- To split and join lists [of text], use the Text library's `split text` and `join text` commands.


TO DO:

- decide on naming convention for comparator object constructors


- text comparator should implement exactly the same predefined considering/ignoring options as Text's `search text`, etc. (currently they are inconsistent on whether to consider or ignore diacriticals)


- would it be worth implementing an ArrayCollection object that encapsulates list lookup kludges, and just encouraging users to use that for manipulating lists (in which case some/most of the below handlers might be as well made into methods on that)


- any practical way to provide a readymade comparator for list-of-record sorting? or is it simplest just to document the technique for users to implement themselves (e.g. a wrapper around `list comparator` could override its makeKeys method to first extract the required record properties into a list of items which list comparator can then consume)



- What other commands are needed?

- `remove duplicates from list LIST` (note: this can be implemented as FilterDuplicatesObject for use in `filter list`; a naive implementation would just build new list and compare against that, giving worst-case O(n^2) performance; however, a smarter implementation could put comparable items into a SetObject, allowing O(n * log n) when filtering lists of numbers, text, dates), caveat considering/ignoring  (Q. what are common use cases for this command? would they be better dealt with using Set objects?)

- `slice list LIST from I to J` -- c.f. `slice text`

- add optional `from [before/after/] item` and `to [before/after/] item` parameters to `insert into list` and `delete from list` to insert/delete ranges; `insert into list` should also be able to replace existing ranges of items with new items (of same or different length)

- stable sorting? what about 3-way quicksort (better on lists where most items are equal)?

- might consider using NSMutableArray when sorting simple uniform lists of text or number without a user-supplied comparator (would need to compare costs of ASOC bridging vs native sorting to see which performs better); not sure about dates given that they're mutable (ASOC will perform deep copy of list, so resulting list will contain copies of the original date objects, whereas native sort preserves the original date objects); complex values (e.g. list of records) will still be sorted natively, of course (though even there it might be possible to use NSArray to sort an array of [key,valueIndex] and then iterate the result to reposition values in output list, making the [slow] AS part of the code O(2n))


     � 	 	8   L i s t   - -   m a n i p u l a t e   A p p l e S c r i p t   l i s t s   
 
 N o t e s : 
 
 -   T o   s p l i t   a n d   j o i n   l i s t s   [ o f   t e x t ] ,   u s e   t h e   T e x t   l i b r a r y ' s   ` s p l i t   t e x t `   a n d   ` j o i n   t e x t `   c o m m a n d s . 
 
 
 T O   D O : 
 
 -   d e c i d e   o n   n a m i n g   c o n v e n t i o n   f o r   c o m p a r a t o r   o b j e c t   c o n s t r u c t o r s 
 
 
 -   t e x t   c o m p a r a t o r   s h o u l d   i m p l e m e n t   e x a c t l y   t h e   s a m e   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   a s   T e x t ' s   ` s e a r c h   t e x t ` ,   e t c .   ( c u r r e n t l y   t h e y   a r e   i n c o n s i s t e n t   o n   w h e t h e r   t o   c o n s i d e r   o r   i g n o r e   d i a c r i t i c a l s ) 
 
 
 -   w o u l d   i t   b e   w o r t h   i m p l e m e n t i n g   a n   A r r a y C o l l e c t i o n   o b j e c t   t h a t   e n c a p s u l a t e s   l i s t   l o o k u p   k l u d g e s ,   a n d   j u s t   e n c o u r a g i n g   u s e r s   t o   u s e   t h a t   f o r   m a n i p u l a t i n g   l i s t s   ( i n   w h i c h   c a s e   s o m e / m o s t   o f   t h e   b e l o w   h a n d l e r s   m i g h t   b e   a s   w e l l   m a d e   i n t o   m e t h o d s   o n   t h a t ) 
 
 
 -   a n y   p r a c t i c a l   w a y   t o   p r o v i d e   a   r e a d y m a d e   c o m p a r a t o r   f o r   l i s t - o f - r e c o r d   s o r t i n g ?   o r   i s   i t   s i m p l e s t   j u s t   t o   d o c u m e n t   t h e   t e c h n i q u e   f o r   u s e r s   t o   i m p l e m e n t   t h e m s e l v e s   ( e . g .   a   w r a p p e r   a r o u n d   ` l i s t   c o m p a r a t o r `   c o u l d   o v e r r i d e   i t s   m a k e K e y s   m e t h o d   t o   f i r s t   e x t r a c t   t h e   r e q u i r e d   r e c o r d   p r o p e r t i e s   i n t o   a   l i s t   o f   i t e m s   w h i c h   l i s t   c o m p a r a t o r   c a n   t h e n   c o n s u m e ) 
 
 
 
 -   W h a t   o t h e r   c o m m a n d s   a r e   n e e d e d ? 
 
 -   ` r e m o v e   d u p l i c a t e s   f r o m   l i s t   L I S T `   ( n o t e :   t h i s   c a n   b e   i m p l e m e n t e d   a s   F i l t e r D u p l i c a t e s O b j e c t   f o r   u s e   i n   ` f i l t e r   l i s t ` ;   a   n a i v e   i m p l e m e n t a t i o n   w o u l d   j u s t   b u i l d   n e w   l i s t   a n d   c o m p a r e   a g a i n s t   t h a t ,   g i v i n g   w o r s t - c a s e   O ( n ^ 2 )   p e r f o r m a n c e ;   h o w e v e r ,   a   s m a r t e r   i m p l e m e n t a t i o n   c o u l d   p u t   c o m p a r a b l e   i t e m s   i n t o   a   S e t O b j e c t ,   a l l o w i n g   O ( n   *   l o g   n )   w h e n   f i l t e r i n g   l i s t s   o f   n u m b e r s ,   t e x t ,   d a t e s ) ,   c a v e a t   c o n s i d e r i n g / i g n o r i n g     ( Q .   w h a t   a r e   c o m m o n   u s e   c a s e s   f o r   t h i s   c o m m a n d ?   w o u l d   t h e y   b e   b e t t e r   d e a l t   w i t h   u s i n g   S e t   o b j e c t s ? ) 
 
 -   ` s l i c e   l i s t   L I S T   f r o m   I   t o   J `   - -   c . f .   ` s l i c e   t e x t ` 
 
 -   a d d   o p t i o n a l   ` f r o m   [ b e f o r e / a f t e r / ]   i t e m `   a n d   ` t o   [ b e f o r e / a f t e r / ]   i t e m `   p a r a m e t e r s   t o   ` i n s e r t   i n t o   l i s t `   a n d   ` d e l e t e   f r o m   l i s t `   t o   i n s e r t / d e l e t e   r a n g e s ;   ` i n s e r t   i n t o   l i s t `   s h o u l d   a l s o   b e   a b l e   t o   r e p l a c e   e x i s t i n g   r a n g e s   o f   i t e m s   w i t h   n e w   i t e m s   ( o f   s a m e   o r   d i f f e r e n t   l e n g t h ) 
 
 -   s t a b l e   s o r t i n g ?   w h a t   a b o u t   3 - w a y   q u i c k s o r t   ( b e t t e r   o n   l i s t s   w h e r e   m o s t   i t e m s   a r e   e q u a l ) ? 
 
 -   m i g h t   c o n s i d e r   u s i n g   N S M u t a b l e A r r a y   w h e n   s o r t i n g   s i m p l e   u n i f o r m   l i s t s   o f   t e x t   o r   n u m b e r   w i t h o u t   a   u s e r - s u p p l i e d   c o m p a r a t o r   ( w o u l d   n e e d   t o   c o m p a r e   c o s t s   o f   A S O C   b r i d g i n g   v s   n a t i v e   s o r t i n g   t o   s e e   w h i c h   p e r f o r m s   b e t t e r ) ;   n o t   s u r e   a b o u t   d a t e s   g i v e n   t h a t   t h e y ' r e   m u t a b l e   ( A S O C   w i l l   p e r f o r m   d e e p   c o p y   o f   l i s t ,   s o   r e s u l t i n g   l i s t   w i l l   c o n t a i n   c o p i e s   o f   t h e   o r i g i n a l   d a t e   o b j e c t s ,   w h e r e a s   n a t i v e   s o r t   p r e s e r v e s   t h e   o r i g i n a l   d a t e   o b j e c t s ) ;   c o m p l e x   v a l u e s   ( e . g .   l i s t   o f   r e c o r d s )   w i l l   s t i l l   b e   s o r t e d   n a t i v e l y ,   o f   c o u r s e   ( t h o u g h   e v e n   t h e r e   i t   m i g h t   b e   p o s s i b l e   t o   u s e   N S A r r a y   t o   s o r t   a n   a r r a y   o f   [ k e y , v a l u e I n d e x ]   a n d   t h e n   i t e r a t e   t h e   r e s u l t   t o   r e p o s i t i o n   v a l u e s   i n   o u t p u t   l i s t ,   m a k i n g   t h e   [ s l o w ]   A S   p a r t   o f   t h e   c o d e   O ( 2 n ) ) 
 
 
   
  
 l     ��������  ��  ��        x     
�� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      support     �      s u p p o r t      l     ��������  ��  ��        l         !  j   
 �� "�� 0 _support   " N   
  # # 4   
 �� $
�� 
scpt $ m     % % � & &  T y p e S u p p o r t   "  used for parameter checking    ! � ' ' 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g   ( ) ( l     ��������  ��  ��   )  * + * i    , - , I      �� .���� 
0 _error   .  / 0 / o      ���� 0 handlername handlerName 0  1 2 1 o      ���� 0 etext eText 2  3 4 3 o      ���� 0 enumber eNumber 4  5 6 5 o      ���� 0 efrom eFrom 6  7�� 7 o      ���� 
0 eto eTo��  ��   - I     �� 8���� 20 _errorwithpartialresult _errorWithPartialResult 8  9 : 9 o    ���� 0 handlername handlerName :  ; < ; o    ���� 0 etext eText <  = > = o    ���� 0 enumber eNumber >  ? @ ? o    ���� 0 efrom eFrom @  A B A o    ���� 
0 eto eTo B  C�� C m    ��
�� 
msng��  ��   +  D E D l     ��������  ��  ��   E  F G F i    H I H I      �� J���� 20 _errorwithpartialresult _errorWithPartialResult J  K L K o      ���� 0 handlername handlerName L  M N M o      ���� 0 etext eText N  O P O o      ���� 0 enumber eNumber P  Q R Q o      ���� 0 efrom eFrom R  S T S o      ���� 
0 eto eTo T  U�� U o      ���� 0 epartial ePartial��  ��   I n     V W V I    �� X���� 0 rethrowerror rethrowError X  Y Z Y m     [ [ � \ \  L i s t Z  ] ^ ] o    ���� 0 handlername handlerName ^  _ ` _ o    ���� 0 etext eText `  a b a o    	���� 0 enumber eNumber b  c d c o   	 
���� 0 efrom eFrom d  e f e o   
 ���� 
0 eto eTo f  g h g m    ��
�� 
msng h  i�� i o    ���� 0 epartial ePartial��  ��   W o     ���� 0 _support   G  j k j l     ��������  ��  ��   k  l m l l     ��������  ��  ��   m  n o n l     �� p q��   p  -----    q � r r 
 - - - - - o  s t s l     ��������  ��  ��   t  u v u i    w x w I      �� y���� "0 _makelistobject _makeListObject y  z { z o      ���� 0 len   {  |�� | o      ���� 0 padvalue padValue��  ��   x l    _ } ~  } k     _ � �  � � � h     �� ��� 0 
listobject 
listObject � j     �� ��� 
0 _list_   � J     ����   �  � � � Z    Y � ����� � ?     � � � o    	���� 0 len   � m   	 
����   � k    U � �  � � � r     � � � J     � �  � � � o    ���� 0 padvalue padValue �  � � � o    ���� 0 padvalue padValue �  � � � o    ���� 0 padvalue padValue �  ��� � o    ���� 0 padvalue padValue��   � n      � � � o    ���� 
0 _list_   � o    ���� 0 
listobject 
listObject �  � � � V    5 � � � r   % 0 � � � b   % , � � � n  % ( � � � o   & (���� 
0 _list_   � o   % &���� 0 
listobject 
listObject � n  ( + � � � o   ) +���� 
0 _list_   � o   ( )���� 0 
listobject 
listObject � n      � � � o   - /���� 
0 _list_   � o   , -���� 0 
listobject 
listObject � A    $ � � � n   " � � � 1     "��
�� 
leng � n     � � � o     ���� 
0 _list_   � o    ���� 0 
listobject 
listObject � o   " #���� 0 len   �  ��� � Z  6 U � ����� � ?   6 = � � � n  6 ; � � � 1   9 ;��
�� 
leng � n  6 9 � � � o   7 9���� 
0 _list_   � o   6 7���� 0 
listobject 
listObject � o   ; <���� 0 len   � r   @ Q � � � n   @ M � � � 7  C M�� � �
�� 
cobj � m   G I����  � o   J L���� 0 len   � n  @ C � � � o   A C���� 
0 _list_   � o   @ A���� 0 
listobject 
listObject � n      � � � o   N P���� 
0 _list_   � o   M N���� 0 
listobject 
listObject��  ��  ��  ��  ��   �  ��� � L   Z _ � � n  Z ^ � � � o   [ ]���� 
0 _list_   � o   Z [���� 0 
listobject 
listObject��   ~ � � make a new list of specified length using the supplied value as padding; caution: padValue will not be copied, so should be an immutable type (e.g. number, string, constant; not date/list/record/script/reference)     � � ��   m a k e   a   n e w   l i s t   o f   s p e c i f i e d   l e n g t h   u s i n g   t h e   s u p p l i e d   v a l u e   a s   p a d d i n g ;   c a u t i o n :   p a d V a l u e   w i l l   n o t   b e   c o p i e d ,   s o   s h o u l d   b e   a n   i m m u t a b l e   t y p e   ( e . g .   n u m b e r ,   s t r i n g ,   c o n s t a n t ;   n o t   d a t e / l i s t / r e c o r d / s c r i p t / r e f e r e n c e ) v  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � J D--------------------------------------------------------------------    � � � � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - �  � � � l     �� � ���   �   basic operations    � � � � "   b a s i c   o p e r a t i o n s �  � � � l     ��������  ��  ��   �  � � � i     � � � I     � � �
� .Lst:Instnull���     **** � o      �~�~ 0 thelist theList � �} � �
�} 
Valu � o      �|�| 0 thevalue theValue � �{ � �
�{ 
Befo � |�z�y ��x ��z  �y   � o      �w�w 0 beforeindex beforeIndex�x   � m      �v
�v 
msng � �u ��t
�u 
Afte � |�s�r ��q ��s  �r   � o      �p�p 0 
afterindex 
afterIndex�q   � m      �o
�o 
msng�t   � k    I � �  � � � l     �n � ��n   �.( In addition to inserting before/after the list's actual indexes, this also recognizes three 'virtual' indexes: the `after item` parameter uses index 0 and index `-length - 1` to indicate the start of the list; the `before item` parameter uses index `length + 1` to indicate the end of the list.     � � � �P   I n   a d d i t i o n   t o   i n s e r t i n g   b e f o r e / a f t e r   t h e   l i s t ' s   a c t u a l   i n d e x e s ,   t h i s   a l s o   r e c o g n i z e s   t h r e e   ' v i r t u a l '   i n d e x e s :   t h e   ` a f t e r   i t e m `   p a r a m e t e r   u s e s   i n d e x   0   a n d   i n d e x   ` - l e n g t h   -   1 `   t o   i n d i c a t e   t h e   s t a r t   o f   t h e   l i s t ;   t h e   ` b e f o r e   i t e m `   p a r a m e t e r   u s e s   i n d e x   ` l e n g t h   +   1 `   t o   i n d i c a t e   t h e   e n d   o f   t h e   l i s t .   �  � � � l     �m � ��m   �~x Note that the `before item` parameter cannot indicate the end of a list using a negative index. (Problem: the next 'virtual' index after -1 would be 0, but index 0 is already used by the `after item` parameter to represent the *start* of a list, and it's easier to disallow `before item 0` than explain to user how 'index 0' can be at both the start *and* the end of a list.)    � � � ��   N o t e   t h a t   t h e   ` b e f o r e   i t e m `   p a r a m e t e r   c a n n o t   i n d i c a t e   t h e   e n d   o f   a   l i s t   u s i n g   a   n e g a t i v e   i n d e x .   ( P r o b l e m :   t h e   n e x t   ' v i r t u a l '   i n d e x   a f t e r   - 1   w o u l d   b e   0 ,   b u t   i n d e x   0   i s   a l r e a d y   u s e d   b y   t h e   ` a f t e r   i t e m `   p a r a m e t e r   t o   r e p r e s e n t   t h e   * s t a r t *   o f   a   l i s t ,   a n d   i t ' s   e a s i e r   t o   d i s a l l o w   ` b e f o r e   i t e m   0 `   t h a n   e x p l a i n   t o   u s e r   h o w   ' i n d e x   0 '   c a n   b e   a t   b o t h   t h e   s t a r t   * a n d *   t h e   e n d   o f   a   l i s t . ) �  ��l � Q    I � � � � k   3 � �  � � � h    
�k ��k 0 
listobject 
listObject � j     �j ��j 
0 _list_   � n     � � � I    �i ��h�i "0 aslistparameter asListParameter �  � � � o    
�g�g 0 thelist theList �  ��f � m   
  � � �    �f  �h   � o     �e�e 0 _support   �  Z    � >    o    �d�d 0 
afterindex 
afterIndex m    �c
�c 
msng k    g		 

 Z   !�b�a >    o    �`�` 0 beforeindex beforeIndex m    �_
�_ 
msng R    �^
�^ .ascrerr ****      � **** m     � ( T o o   m a n y   p a r a m e t e r s . �]�\
�] 
errn m    �[�[�Y�\  �b  �a    r   " / n  " - I   ' -�Z�Y�Z (0 asintegerparameter asIntegerParameter  o   ' (�X�X 0 
afterindex 
afterIndex �W m   ( ) �    a f t e r   i t e m�W  �Y   o   " '�V�V 0 _support   o      �U�U 0 
afterindex 
afterIndex !"! Z  0 E#$�T�S# A   0 3%&% o   0 1�R�R 0 
afterindex 
afterIndex& m   1 2�Q�Q  $ r   6 A'(' [   6 ?)*) [   6 =+,+ l  6 ;-�P�O- n  6 ;./. 1   9 ;�N
�N 
leng/ n  6 9010 o   7 9�M�M 
0 _list_  1 o   6 7�L�L 0 
listobject 
listObject�P  �O  , o   ; <�K�K 0 
afterindex 
afterIndex* m   = >�J�J ( o      �I�I 0 
afterindex 
afterIndex�T  �S  " 2�H2 Z   F g34�G�F3 ?   F M565 o   F G�E�E 0 
afterindex 
afterIndex6 l  G L7�D�C7 n  G L898 1   J L�B
�B 
leng9 n  G J:;: o   H J�A�A 
0 _list_  ; o   G H�@�@ 0 
listobject 
listObject�D  �C  4 R   P c�?<=
�? .ascrerr ****      � ****< m   _ b>> �?? , I n d e x   i s   o u t   o f   r a n g e .= �>@A
�> 
errn@ m   R S�=�=�@A �<B�;
�< 
erobB l  T ^C�:�9C N   T ^DD n   T ]EFE 9   [ ]�8
�8 
inslF n   T [GHG 4   X [�7I
�7 
cobjI o   Y Z�6�6 0 
afterindex 
afterIndexH l  T XJ�5�4J e   T XKK n  T XLML o   U W�3�3 
0 _list_  M o   T U�2�2 0 
listobject 
listObject�5  �4  �:  �9  �;  �G  �F  �H   NON >  j mPQP o   j k�1�1 0 beforeindex beforeIndexQ m   k l�0
�0 
msngO R�/R k   p �SS TUT r   p VWV n  p }XYX I   u }�.Z�-�. (0 asintegerparameter asIntegerParameterZ [\[ o   u v�,�, 0 beforeindex beforeIndex\ ]�+] m   v y^^ �__  b e f o r e   i t e m�+  �-  Y o   p u�*�* 0 _support  W o      �)�) 0 beforeindex beforeIndexU `a` Z   � �bcdeb ?   � �fgf o   � ��(�( 0 beforeindex beforeIndexg m   � ��'�'  c r   � �hih \   � �jkj o   � ��&�& 0 beforeindex beforeIndexk m   � ��%�% i o      �$�$ 0 
afterindex 
afterIndexd lml A   � �non o   � ��#�# 0 beforeindex beforeIndexo m   � ��"�"  m p�!p r   � �qrq [   � �sts l  � �u� �u n  � �vwv 1   � ��
� 
lengw n  � �xyx o   � ��� 
0 _list_  y o   � ��� 0 
listobject 
listObject�   �  t o   � ��� 0 beforeindex beforeIndexr o      �� 0 
afterindex 
afterIndex�!  e l  � �z{|z R   � ��}~
� .ascrerr ****      � ****} m   � � ���  I n v a l i d   i n d e x .~ ���
� 
errn� m   � ����@� ���
� 
erob� l  � ����� N   � ��� n   � ���� 8   � ��
� 
insl� n   � ���� 4   � ���
� 
cobj� o   � ��� 0 beforeindex beforeIndex� l  � ����� e   � ��� n  � ���� o   � ��� 
0 _list_  � o   � ��� 0 
listobject 
listObject�  �  �  �  �  { � � the `before item` parameter cannot identify the end of a list by negative index, so throw 'invalid index' error if `before item 0` is used   | ���   t h e   ` b e f o r e   i t e m `   p a r a m e t e r   c a n n o t   i d e n t i f y   t h e   e n d   o f   a   l i s t   b y   n e g a t i v e   i n d e x ,   s o   t h r o w   ' i n v a l i d   i n d e x '   e r r o r   i f   ` b e f o r e   i t e m   0 `   i s   u s e da ��� Z   � ����
�	� G   � ���� ?   � ���� o   � ��� 0 
afterindex 
afterIndex� l  � ����� n  � ���� 1   � ��
� 
leng� n  � ���� o   � ��� 
0 _list_  � o   � ��� 0 
listobject 
listObject�  �  � A   � ���� o   � ��� 0 
afterindex 
afterIndex� m   � ���  � R   � �� ��
�  .ascrerr ****      � ****� m   � ��� ��� , I n d e x   i s   o u t   o f   r a n g e .� ����
�� 
errn� m   � ������@� �����
�� 
erob� l  � ������� N   � ��� n   � ���� 8   � ���
�� 
insl� n   � ���� 4   � ����
�� 
cobj� o   � ����� 0 beforeindex beforeIndex� l  � ������� e   � ��� n  � ���� o   � ����� 
0 _list_  � o   � ����� 0 
listobject 
listObject��  ��  ��  ��  ��  �
  �	  �  �/   R   � �����
�� .ascrerr ****      � ****� m   � ��� ��� $ M i s s i n g   p a r a m e t e r .� �����
�� 
errn� m   � ������Y��   ���� Z   �3����� =   � ���� o   � ����� 0 
afterindex 
afterIndex� m   � �����  � L   � ��� b   � ���� J   � ��� ���� o   � ����� 0 thevalue theValue��  � n  � ���� o   � ����� 
0 _list_  � o   � ����� 0 
listobject 
listObject� ��� =   ���� o   � ����� 0 
afterindex 
afterIndex� n  ���� 1   ��
�� 
leng� n  � ��� o   � ���� 
0 _list_  � o   � ����� 0 
listobject 
listObject� ���� L  �� b  ��� n 	��� o  	���� 
0 _list_  � o  ���� 0 
listobject 
listObject� J  	�� ���� o  	
���� 0 thevalue theValue��  ��  � L  3�� b  2��� b  "��� l ������ n  ��� 7 ����
�� 
cobj� m  ���� � o  ���� 0 
afterindex 
afterIndex� n ��� o  ���� 
0 _list_  � o  ���� 0 
listobject 
listObject��  ��  � J  !�� ���� o  ���� 0 thevalue theValue��  � l "1������ n  "1��� 7 %1����
�� 
cobj� l )-������ [  )-��� o  *+���� 0 
afterindex 
afterIndex� m  +,���� ��  ��  � m  .0������� n "%��� o  #%���� 
0 _list_  � o  "#���� 0 
listobject 
listObject��  ��  ��   � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��   � I  ;I������� 
0 _error  � ��� m  <?�� ���   i n s e r t   i n t o   l i s t� ��� o  ?@���� 0 etext eText� ��� o  @A���� 0 enumber eNumber� ��� o  AB���� 0 efrom eFrom� ���� o  BC���� 
0 eto eTo��  ��  �l   � ��� l     ��������  ��  ��  �    l     ��������  ��  ��    i  ! $ I     ��
�� .Lst:Delenull���     **** o      ���� 0 thelist theList ����
�� 
Inde |����	��
��  ��  	 o      ���� 0 theindex theIndex��  
 d       m      ���� ��   Q     � k    �  h    
���� 0 
listobject 
listObject j     ���� 
0 _list_   n     I    ������ "0 aslistparameter asListParameter  o    
���� 0 thelist theList �� m   
  �  ��  ��   o     ���� 0 _support    r     n    !  I    ��"���� (0 asintegerparameter asIntegerParameter" #$# o    ���� 0 theindex theIndex$ %��% m    && �''  i t e m��  ��  ! o    ���� 0 _support   o      ���� 0 theindex theIndex ()( Z    �*+,��* F    (-.- ?     /0/ n   121 1    ��
�� 
leng2 n   343 o    ���� 
0 _list_  4 o    ���� 0 
listobject 
listObject0 m    ���� . >   # &565 o   # $���� 0 theindex theIndex6 m   $ %����  + Z   + �789��7 E  + 7:;: J   + 3<< =>= m   + ,������> ?��? n  , 1@A@ 1   / 1��
�� 
lengA n  , /BCB o   - /���� 
0 _list_  C o   , -���� 0 
listobject 
listObject��  ; J   3 6DD E��E o   3 4���� 0 theindex theIndex��  8 L   : IFF n   : HGHG 7  = G��IJ
�� 
cobjI m   A C���� J m   D F������H n  : =KLK o   ; =���� 
0 _list_  L o   : ;���� 0 
listobject 
listObject9 MNM E  L YOPO J   L UQQ RSR m   L M���� S T��T d   M SUU l  M RV����V n  M RWXW 1   P R��
�� 
lengX n  M PYZY o   N P���� 
0 _list_  Z o   M N���� 0 
listobject 
listObject��  ��  ��  P J   U X[[ \��\ o   U V���� 0 theindex theIndex��  N ]^] L   \ c__ n   \ b`a` 1   _ a��
�� 
resta n  \ _bcb o   ] _���� 
0 _list_  c o   \ ]���� 0 
listobject 
listObject^ ded G   f �fgf F   f uhih ?   f ijkj o   f g�� 0 theindex theIndexk m   g h�~�~  i A   l slml o   l m�}�} 0 theindex theIndexm n  m rnon 1   p r�|
�| 
lengo n  m ppqp o   n p�{�{ 
0 _list_  q o   m n�z�z 0 
listobject 
listObjectg F   x �rsr A   x {tut o   x y�y�y 0 theindex theIndexu m   y z�x�x  s ?   ~ �vwv o   ~ �w�w 0 theindex theIndexw d    �xx l   �y�v�uy n   �z{z 1   � ��t
�t 
leng{ n   �|}| o   � ��s�s 
0 _list_  } o    ��r�r 0 
listobject 
listObject�v  �u  e ~�q~ L   � � b   � ���� l  � ���p�o� n   � ���� 7  � ��n��
�n 
cobj� m   � ��m�m � l  � ���l�k� \   � ���� o   � ��j�j 0 theindex theIndex� m   � ��i�i �l  �k  � n  � ���� o   � ��h�h 
0 _list_  � o   � ��g�g 0 
listobject 
listObject�p  �o  � l  � ���f�e� n   � ���� 7  � ��d��
�d 
cobj� l  � ���c�b� [   � ���� o   � ��a�a 0 theindex theIndex� m   � ��`�` �c  �b  � m   � ��_�_��� n  � ���� o   � ��^�^ 
0 _list_  � o   � ��]�] 0 
listobject 
listObject�f  �e  �q  ��  , ��� =   � ���� n  � ���� 1   � ��\
�\ 
leng� n  � ���� o   � ��[�[ 
0 _list_  � o   � ��Z�Z 0 
listobject 
listObject� m   � ��Y�Y � ��X� Z  � ����W�V� E  � ���� J   � ��� ��� m   � ��U�U��� ��T� m   � ��S�S �T  � J   � ��� ��R� o   � ��Q�Q 0 theindex theIndex�R  � L   � ��� J   � ��P�P  �W  �V  �X  ��  ) ��O� R   � ��N��
�N .ascrerr ****      � ****� m   � ��� ��� : I n v a l i d   i n d e x   ( o u t   o f   r a n g e ) .� �M��
�M 
errn� m   � ��L�L�@� �K��J
�K 
erob� l  � ���I�H� N   � ��� n   � ���� 4   � ��G�
�G 
cobj� o   � ��F�F 0 theindex theIndex� l  � ���E�D� e   � ��� n  � ���� o   � ��C�C 
0 _list_  � o   � ��B�B 0 
listobject 
listObject�E  �D  �I  �H  �J  �O   R      �A��
�A .ascrerr ****      � ****� o      �@�@ 0 etext eText� �?��
�? 
errn� o      �>�> 0 enumber eNumber� �=��
�= 
erob� o      �<�< 0 efrom eFrom� �;��:
�; 
errt� o      �9�9 
0 eto eTo�:   I   � ��8��7�8 
0 _error  � ��� m   � ��� ���   d e l e t e   f r o m   l i s t� ��� o   � ��6�6 0 etext eText� ��� o   � ��5�5 0 enumber eNumber� ��� o   � ��4�4 0 efrom eFrom� ��3� o   � ��2�2 
0 eto eTo�3  �7   ��� l     �1�0�/�1  �0  �/  � ��� l     �.�-�,�.  �-  �,  � ��� i  % (��� I     �+��
�+ .Lst:Findnull���     ****� o      �*�* 0 thelist theList� �)��
�) 
Valu� o      �(�( 0 theitem theItem� �'��&
�' 
Retu� |�%�$��#��%  �$  � o      �"�" (0 findingoccurrences findingOccurrences�#  � l     ��!� � m      �
� LFWhLFWA�!  �   �&  � Q     ����� k    ��� ��� h    
��� 0 
listobject 
listObject� k      �� ��� j     ��� 
0 _list_  � n    ��� I    ���� "0 aslistparameter asListParameter� ��� o    
�� 0 thelist theList� ��� m   
 �� ���  �  �  � o     �� 0 _support  � ��� j    ��� 0 _result_  � J    ��  �  � ��� Z    ������ =   ��� o    �� (0 findingoccurrences findingOccurrences� m    �
� LFWhLFWA� Y    :������ Z     5����� =    (   n     & 4   # &�
� 
cobj o   $ %�� 0 i   n    # o   ! #�� 
0 _list_   o     !�� 0 
listobject 
listObject o   & '�
�
 0 theitem theItem� r   + 1 o   + ,�	�	 0 i   n      	
	  ;   / 0
 n  , / o   - /�� 0 _result_   o   , -�� 0 
listobject 
listObject�  �  � 0 i  � m    �� � n     1    �
� 
leng n    o    �� 
0 _list_   o    �� 0 
listobject 
listObject�  �  =  = @ o   = >�� (0 findingoccurrences findingOccurrences m   > ?�
� LFWhLFWF  Y   C n� �� Z   R i���� =  R Z n   R X 4   U X�� 
�� 
cobj  o   V W���� 0 i   n  R U!"! o   S U���� 
0 _list_  " o   R S���� 0 
listobject 
listObject o   X Y���� 0 theitem theItem k   ] e## $%$ r   ] c&'& o   ] ^���� 0 i  ' n      ()(  ;   a b) n  ^ a*+* o   _ a���� 0 _result_  + o   ^ _���� 0 
listobject 
listObject% ,��,  S   d e��  ��  ��  �  0 i   m   F G����  n   G M-.- 1   J L��
�� 
leng. n  G J/0/ o   H J���� 
0 _list_  0 o   G H���� 0 
listobject 
listObject��   121 =  q t343 o   q r���� (0 findingoccurrences findingOccurrences4 m   r s��
�� LFWhLFWL2 5��5 Y   w �6��7896 Z   � �:;����: =  � �<=< n   � �>?> 4   � ���@
�� 
cobj@ o   � ����� 0 i  ? n  � �ABA o   � ����� 
0 _list_  B o   � ����� 0 
listobject 
listObject= o   � ����� 0 theitem theItem; k   � �CC DED r   � �FGF o   � ����� 0 i  G n      HIH  ;   � �I n  � �JKJ o   � ����� 0 _result_  K o   � ����� 0 
listobject 
listObjectE L��L  S   � ���  ��  ��  �� 0 i  7 n   z �MNM 1   } ��
�� 
lengN n  z }OPO o   { }���� 
0 _list_  P o   z {���� 0 
listobject 
listObject8 m   � ����� 9 m   � ���������  � R   � ���QR
�� .ascrerr ****      � ****Q m   � �SS �TT p I n v a l i d    r e t u r n i n g    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .R ��UV
�� 
errnU m   � ������YV ��WX
�� 
erobW o   � ����� (0 findingoccurrences findingOccurrencesX ��Y��
�� 
errtY m   � ���
�� 
enum��  � Z��Z L   � �[[ n  � �\]\ o   � ����� 0 _result_  ] o   � ����� 0 
listobject 
listObject��  � R      ��^_
�� .ascrerr ****      � ****^ o      ���� 0 etext eText_ ��`a
�� 
errn` o      ���� 0 enumber eNumbera ��bc
�� 
erobb o      ���� 0 efrom eFromc ��d��
�� 
errtd o      ���� 
0 eto eTo��  � I   � ���e���� 
0 _error  e fgf m   � �hh �ii  f i n d   i n   l i s tg jkj o   � ����� 0 etext eTextk lml o   � ����� 0 enumber eNumberm non o   � ����� 0 efrom eFromo p��p o   � ����� 
0 eto eTo��  ��  � qrq l     ��������  ��  ��  r sts l     ��������  ��  ��  t uvu i  ) ,wxw I     ��yz
�� .Lst:Trannull���     ****y o      ���� 0 thelist theListz ��{|
�� 
Whil{ |����}��~��  ��  } o      ���� 0 unevenoption unevenOption��  ~ l     ���� m      ��
�� LTrhLTrR��  ��  | �����
�� 
PadI� |����������  ��  � o      ���� 0 padvalue padValue��  � l     ������ m      ��
�� 
msng��  ��  ��  x Q    ����� k   ��� ��� Z   ������� =   ��� o    ���� 0 thelist theList� J    ����  � L   
 �� J   
 ����  ��  ��  � ��� Z   >������� G    /��� =    ��� l   ������ I   ����
�� .corecnte****       ****� J    �� ���� o    ���� 0 thelist theList��  � �����
�� 
kocl� m    ��
�� 
list��  ��  ��  � m    ����  � >     -��� l    '������ I    '����
�� .corecnte****       ****� o     !���� 0 thelist theList� �����
�� 
kocl� m   " #��
�� 
list��  ��  ��  � l  ' ,������ I  ' ,�����
�� .corecnte****       ****� o   ' (���� 0 thelist theList��  ��  ��  � R   2 :����
�� .ascrerr ****      � ****� m   8 9�� ��� ( N o t   a   l i s t   o f   l i s t s .� ����
�� 
errn� m   4 5�����Y� �����
�� 
erob� o   6 7���� 0 thelist theList��  ��  ��  � ��� h   ? F����� 0 
listobject 
listObject� j     ����� 
0 _list_  � o     ���� 0 thelist theList� ��� r   G Q��� n   G O��� 1   M O��
�� 
leng� n  G M��� 4   J M���
�� 
cobj� m   K L���� � n  G J��� o   H J�� 
0 _list_  � o   G H�~�~ 0 
listobject 
listObject� o      �}�} $0 resultlistlength resultListLength� ��� l  R R�|���|  � K E find the longest/shortest sublist; this will be length of resultList   � ��� �   f i n d   t h e   l o n g e s t / s h o r t e s t   s u b l i s t ;   t h i s   w i l l   b e   l e n g t h   o f   r e s u l t L i s t� ��� Z   R����� =  R U��� o   R S�{�{ 0 unevenoption unevenOption� m   S T�z
�z LTrhLTrR� X   X ���y�� Z  j ����x�w� >   j o��� n  j m��� 1   k m�v
�v 
leng� o   j k�u�u 0 aref aRef� o   m n�t�t $0 resultlistlength resultListLength� R   r ~�s��
�s .ascrerr ****      � ****� m   z }�� ��� x I n v a l i d   d i r e c t   p a r a m e t e r   ( s u b l i s t s   a r e   n o t   a l l   s a m e   l e n g t h ) .� �r��
�r 
errn� m   t u�q�q�Y� �p��o
�p 
erob� l  v y��n�m� n  v y��� o   w y�l�l 
0 _list_  � o   v w�k�k 0 
listobject 
listObject�n  �m  �o  �x  �w  �y 0 aref aRef� n  [ ^��� o   \ ^�j�j 
0 _list_  � o   [ \�i�i 0 
listobject 
listObject� ��� =  � ���� o   � ��h�h 0 unevenoption unevenOption� m   � ��g
�g LTrhLTrP� ��� X   � ���f�� Z  � ����e�d� ?   � ���� n  � ���� 1   � ��c
�c 
leng� o   � ��b�b 0 aref aRef� o   � ��a�a $0 resultlistlength resultListLength� r   � ���� n  � ���� 1   � ��`
�` 
leng� o   � ��_�_ 0 aref aRef� o      �^�^ $0 resultlistlength resultListLength�e  �d  �f 0 aref aRef� n  � ���� o   � ��]�] 
0 _list_  � o   � ��\�\ 0 
listobject 
listObject� ��� =  � ���� o   � ��[�[ 0 unevenoption unevenOption� m   � ��Z
�Z LTrhLTrT� ��Y� X   � ���X�� Z  � ����W�V� A   � ���� n  � ���� 1   � ��U
�U 
leng� o   � ��T�T 0 aref aRef� o   � ��S�S $0 resultlistlength resultListLength� r   � ���� n  � �� � 1   � ��R
�R 
leng  o   � ��Q�Q 0 aref aRef� o      �P�P $0 resultlistlength resultListLength�W  �V  �X 0 aref aRef� n  � � o   � ��O�O 
0 _list_   o   � ��N�N 0 
listobject 
listObject�Y  � R   ��M
�M .ascrerr ****      � **** m   � � h I n v a l i d    w h i l e    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) . �L
�L 
errn m   � ��K�K�Y �J	

�J 
erob	 o   � ��I�I 0 unevenoption unevenOption
 �H�G
�H 
errt m   � ��F
�F 
enum�G  �  l �E�E   � � build empty matrix (due to inefficiencies of AS's list implementation, when populating large lists, it's probably quicker to create a padded list then set its items rather than start with an empty list and append items)    ��   b u i l d   e m p t y   m a t r i x   ( d u e   t o   i n e f f i c i e n c i e s   o f   A S ' s   l i s t   i m p l e m e n t a t i o n ,   w h e n   p o p u l a t i n g   l a r g e   l i s t s ,   i t ' s   p r o b a b l y   q u i c k e r   t o   c r e a t e   a   p a d d e d   l i s t   t h e n   s e t   i t s   i t e m s   r a t h e r   t h a n   s t a r t   w i t h   a n   e m p t y   l i s t   a n d   a p p e n d   i t e m s )  r   I  �D�C�D "0 _makelistobject _makeListObject  n 	 1  	�B
�B 
leng n  o  �A�A 
0 _list_   o  �@�@ 0 
listobject 
listObject �? o  	
�>�> 0 padvalue padValue�?  �C   o      �=�= (0 emptyresultsublist emptyResultSubList  h  �<�< $0 resultlistobject resultListObject j     �; �; 
0 _list_    J     �:�:   !"! Y  7#�9$%�8# l )2&'(& r  )2)*) l )-+�7�6+ e  )-,, n )--.- 2 *,�5
�5 
cobj. o  )*�4�4 (0 emptyresultsublist emptyResultSubList�7  �6  * n      /0/  ;  010 n -0121 o  .0�3�3 
0 _list_  2 o  -.�2�2 $0 resultlistobject resultListObject'   shallow copy   ( �33    s h a l l o w   c o p y�9 0 i  $ m   !�1�1 % l !$4�0�/4 \  !$565 o  !"�.�. $0 resultlistlength resultListLength6 m  "#�-�- �0  �/  �8  " 787 r  8>9:9 o  89�,�, (0 emptyresultsublist emptyResultSubList: n      ;<;  ;  <=< n 9<=>= o  :<�+�+ 
0 _list_  > o  9:�*�* $0 resultlistobject resultListObject8 ?@? l ??�)AB�)  A   populate matrix   B �CC     p o p u l a t e   m a t r i x@ DED Y  ?}F�(GH�'F Y  NxI�&JK�%I r  `sLML n  `iNON 4  fi�$P
�$ 
cobjP o  gh�#�# 0 j  O n  `fQRQ 4  cf�"S
�" 
cobjS o  de�!�! 0 i  R n `cTUT o  ac� �  
0 _list_  U o  `a�� 0 
listobject 
listObjectM n      VWV 4  or�X
� 
cobjX o  pq�� 0 i  W n  ioYZY 4  lo�[
� 
cobj[ o  mn�� 0 j  Z n il\]\ o  jl�� 
0 _list_  ] o  ij�� $0 resultlistobject resultListObject�& 0 j  J m  QR�� K n  R[^_^ 1  XZ�
� 
leng_ n RX`a` 4  UX�b
� 
cobjb o  VW�� 0 i  a n RUcdc o  SU�� 
0 _list_  d o  RS�� 0 
listobject 
listObject�%  �( 0 i  G m  BC�� H n CIefe 1  FH�
� 
lengf n CFghg o  DF�� 
0 _list_  h o  CD�� 0 
listobject 
listObject�'  E i�i L  ~�jj n ~�klk o  ��� 
0 _list_  l o  ~�� $0 resultlistobject resultListObject�  � R      �mn
� .ascrerr ****      � ****m o      �
�
 0 etext eTextn �	op
�	 
errno o      �� 0 enumber eNumberp �qr
� 
erobq o      �� 0 efrom eFromr �s�
� 
errts o      �� 
0 eto eTo�  � I  ���t�� 
0 _error  t uvu m  ��ww �xx  t r a n s p o s e   l i s tv yzy o  ��� �  0 etext eTextz {|{ o  ������ 0 enumber eNumber| }~} o  ������ 0 efrom eFrom~ �� o  ������ 
0 eto eTo��  �  v ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �ZT map, filter, reduce (these operations are relatively trivial to perform in AS without the need for callbacks; however, these handlers are more flexible when the convert/check/combine operations are parameterized and also provide more advanced users with idiomatic examples of how to parameterize a general-purpose handler's exact behavior)   � ����   m a p ,   f i l t e r ,   r e d u c e   ( t h e s e   o p e r a t i o n s   a r e   r e l a t i v e l y   t r i v i a l   t o   p e r f o r m   i n   A S   w i t h o u t   t h e   n e e d   f o r   c a l l b a c k s ;   h o w e v e r ,   t h e s e   h a n d l e r s   a r e   m o r e   f l e x i b l e   w h e n   t h e   c o n v e r t / c h e c k / c o m b i n e   o p e r a t i o n s   a r e   p a r a m e t e r i z e d   a n d   a l s o   p r o v i d e   m o r e   a d v a n c e d   u s e r s   w i t h   i d i o m a t i c   e x a m p l e s   o f   h o w   t o   p a r a m e t e r i z e   a   g e n e r a l - p u r p o s e   h a n d l e r ' s   e x a c t   b e h a v i o r )� ��� l     ��������  ��  ��  � ��� l     ������  � � � note: while these handlers prevent the script object from modifying the input list directly, it cannot stop them modifying mutable (date/list/record/script/reference) items within the input list (doing so would be very bad practice, however)   � ����   n o t e :   w h i l e   t h e s e   h a n d l e r s   p r e v e n t   t h e   s c r i p t   o b j e c t   f r o m   m o d i f y i n g   t h e   i n p u t   l i s t   d i r e c t l y ,   i t   c a n n o t   s t o p   t h e m   m o d i f y i n g   m u t a b l e   ( d a t e / l i s t / r e c o r d / s c r i p t / r e f e r e n c e )   i t e m s   w i t h i n   t h e   i n p u t   l i s t   ( d o i n g   s o   w o u l d   b e   v e r y   b a d   p r a c t i c e ,   h o w e v e r )� ��� l     ��������  ��  ��  � ��� i  - 0��� I     ����
�� .Lst:Map_null���     ****� o      ���� 0 thelist theList� �����
�� 
Usin� o      ���� 0 	thescript 	theScript��  � Q     ����� k    ��� ��� h    
����� $0 resultlistobject resultListObject� j     ����� 
0 _list_  � n     ��� 2   ��
�� 
cobj� n    ��� I    ������� "0 aslistparameter asListParameter� ��� o    
���� 0 thelist theList� ���� m   
 �� ���  ��  ��  � o     ���� 0 _support  � ��� r    ��� n   ��� I    ������� &0 asscriptparameter asScriptParameter� ��� o    ���� 0 	thescript 	theScript� ���� m    �� ��� 
 u s i n g��  ��  � o    ���� 0 _support  � o      ���� 0 	thescript 	theScript� ��� Q    ����� Y    B�������� l  + =���� r   + =��� n  + 6��� I   , 6������� 0 convertitem convertItem� ���� n   , 2��� 4   / 2���
�� 
cobj� o   0 1���� 0 i  � n  , /��� o   - /���� 
0 _list_  � o   , -���� $0 resultlistobject resultListObject��  ��  � o   + ,���� 0 	thescript 	theScript� n      ��� 4   9 <���
�� 
cobj� o   : ;���� 0 i  � n  6 9��� o   7 9���� 
0 _list_  � o   6 7���� $0 resultlistobject resultListObject� � ~ use counting loop rather than `repeat with aRef in theList` as the item's index is also used when constructing error messages   � ��� �   u s e   c o u n t i n g   l o o p   r a t h e r   t h a n   ` r e p e a t   w i t h   a R e f   i n   t h e L i s t `   a s   t h e   i t e m ' s   i n d e x   i s   a l s o   u s e d   w h e n   c o n s t r u c t i n g   e r r o r   m e s s a g e s�� 0 i  � m     ���� � n     &��� 1   # %��
�� 
leng� n    #��� o   ! #���� 
0 _list_  � o     !���� $0 resultlistobject resultListObject��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� �����
�� 
errt� o      ���� 
0 eto eTo��  � k   J ��� ��� Z   J h������ ?   J M��� o   J K���� 0 i  � m   K L���� � r   P a��� n   P _��� 7  S _����
�� 
cobj� m   W Y���� � l  Z ^������ \   Z ^��� o   [ \���� 0 i  � m   \ ]���� ��  ��  � n  P S��� o   Q S���� 
0 _list_  � o   P Q���� $0 resultlistobject resultListObject� o      ���� 0 epartial ePartial��  � r   d h��� J   d f����  � o      ���� 0 epartial ePartial� ���� R   i �����
�� .ascrerr ****      � ****� b   z ���� b   z ���� b   z ��� m   z }�� �   , C o u l d n ' t   c o n v e r t   i t e m  � o   } ~���� 0 i  � m    � �  :  � o   � ����� 0 etext eText� ��
�� 
errn o   k l���� 0 enumber eNumber ��
�� 
erob l  m u���� N   m u n   m t	
	 4   q t��
�� 
cobj o   r s���� 0 i  
 l  m q���� e   m q n  m q o   n p���� 
0 _list_   o   m n���� 0 
listobject 
listObject��  ��  ��  ��   ��
�� 
errt o   v w���� 
0 eto eTo ����
�� 
ptlr o   x y���� 0 epartial ePartial��  ��  � �� L   � � n  � � o   � ����� 
0 _list_   o   � ����� $0 resultlistobject resultListObject��  � R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ��
�� 
erob o      ���� 0 efrom eFrom ��
�� 
errt o      ���� 
0 eto eTo ����
�� 
ptlr o      ���� 0 epartial ePartial��  � I   � ��� ���� 20 _errorwithpartialresult _errorWithPartialResult  !"! m   � �## �$$  m a p   l i s t" %&% o   � ����� 0 etext eText& '(' o   � ����� 0 enumber eNumber( )*) o   � ����� 0 efrom eFrom* +,+ o   � ����� 
0 eto eTo, -��- o   � ����� 0 epartial ePartial��  ��  � ./. l     ��������  ��  ��  / 010 l     ��������  ��  ��  1 232 i  1 4454 I     ��67
�� .Lst:Filtnull���     ****6 o      ���� 0 thelist theList7 ��8�
�� 
Usin8 o      �~�~ 0 	thescript 	theScript�  5 Q     �9:;9 k    �<< =>= h    
�}?�} $0 resultlistobject resultListObject? j     �|@�| 
0 _list_  @ n     ABA 2   �{
�{ 
cobjB n    CDC I    �zE�y�z "0 aslistparameter asListParameterE FGF o    
�x�x 0 thelist theListG H�wH m   
 II �JJ  �w  �y  D o     �v�v 0 _support  > KLK r    MNM n   OPO I    �uQ�t�u &0 asscriptparameter asScriptParameterQ RSR o    �s�s 0 	thescript 	theScriptS T�rT m    UU �VV 
 u s i n g�r  �t  P o    �q�q 0 _support  N o      �p�p 0 	thescript 	theScriptL WXW r    YZY m    �o�o  Z o      �n�n 0 	lastindex 	lastIndexX [\[ Q    �]^_] Y     X`�mab�l` k   / Scc ded r   / 7fgf n   / 5hih 4   2 5�kj
�k 
cobjj o   3 4�j�j 0 i  i n  / 2klk o   0 2�i�i 
0 _list_  l o   / 0�h�h $0 resultlistobject resultListObjectg o      �g�g 0 theitem theIteme m�fm Z   8 Sno�e�dn n  8 >pqp I   9 >�cr�b�c 0 	checkitem 	checkItemr s�as o   9 :�`�` 0 theitem theItem�a  �b  q o   8 9�_�_ 0 	thescript 	theScripto k   A Ott uvu r   A Fwxw [   A Dyzy o   A B�^�^ 0 	lastindex 	lastIndexz m   B C�]�] x o      �\�\ 0 	lastindex 	lastIndexv {�[{ r   G O|}| o   G H�Z�Z 0 theitem theItem} n      ~~ 4   K N�Y�
�Y 
cobj� o   L M�X�X 0 	lastindex 	lastIndex n  H K��� o   I K�W�W 
0 _list_  � o   H I�V�V $0 resultlistobject resultListObject�[  �e  �d  �f  �m 0 i  a m   # $�U�U b n   $ *��� 1   ' )�T
�T 
leng� n  $ '��� o   % '�S�S 
0 _list_  � o   $ %�R�R $0 resultlistobject resultListObject�l  ^ R      �Q��
�Q .ascrerr ****      � ****� o      �P�P 0 etext eText� �O��
�O 
errn� o      �N�N 0 enumber eNumber� �M��L
�M 
errt� o      �K�K 
0 eto eTo�L  _ k   ` ��� ��� Z   ` ~���J�� ?   ` c��� o   ` a�I�I 0 	lastindex 	lastIndex� m   a b�H�H � r   f w��� n   f u��� 7  i u�G��
�G 
cobj� m   m o�F�F � l  p t��E�D� \   p t��� o   q r�C�C 0 	lastindex 	lastIndex� m   r s�B�B �E  �D  � n  f i��� o   g i�A�A 
0 _list_  � o   f g�@�@ $0 resultlistobject resultListObject� o      �?�? 0 epartial ePartial�J  � r   z ~��� J   z |�>�>  � o      �=�= 0 epartial ePartial� ��<� R    ��;��
�; .ascrerr ****      � ****� b   � ���� b   � ���� b   � ���� m   � ��� ��� * C o u l d n ' t   f i l t e r   i t e m  � o   � ��:�: 0 i  � m   � ��� ���  :  � o   � ��9�9 0 etext eText� �8��
�8 
errn� o   � ��7�7 0 enumber eNumber� �6��
�6 
erob� l  � ���5�4� N   � ��� n   � ���� 4   � ��3�
�3 
cobj� o   � ��2�2 0 i  � l  � ���1�0� e   � ��� n  � ���� o   � ��/�/ 
0 _list_  � o   � ��.�. 0 
listobject 
listObject�1  �0  �5  �4  � �-��
�- 
errt� o   � ��,�, 
0 eto eTo� �+��*
�+ 
ptlr� o   � ��)�) 0 epartial ePartial�*  �<  \ ��� Z  � ����(�'� =   � ���� o   � ��&�& 0 	lastindex 	lastIndex� m   � ��%�%  � L   � ��� J   � ��$�$  �(  �'  � ��#� L   � ��� n  � ���� 7  � ��"��
�" 
cobj� m   � ��!�! � o   � �� �  0 	lastindex 	lastIndex� n  � ���� o   � ��� 
0 _list_  � o   � ��� $0 resultlistobject resultListObject�#  : R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo� ���
� 
ptlr� o      �� 0 epartial ePartial�  ; I   � ����� 20 _errorwithpartialresult _errorWithPartialResult� ��� m   � ��� ���  f i l t e r   l i s t� ��� o   � ��� 0 etext eText� ��� o   � ��� 0 enumber eNumber� ��� o   � ��� 0 efrom eFrom� ��� o   � ��� 
0 eto eTo� ��� o   � ��� 0 epartial ePartial�  �  3 ��� l     �
�	��
  �	  �  � ��� l     ����  �  �  � ��� i  5 8��� I     ���
� .Lst:Redunull���     ****� o      �� 0 thelist theList� ���
� 
Usin� o      � �  0 	thescript 	theScript�  � k     ��� ��� r     ��� o     ���� 0 missingvalue missingValue� o      ���� 0 	theresult 	theResult� ���� Q    ����� k    ��� ��� h    ����� 0 
listobject 
listObject� j     ����� 
0 _list_  � n    ��� I    ������� "0 aslistparameter asListParameter�    o    
���� 0 thelist theList �� m   
  �  ��  ��  � o     ���� 0 _support  �  Z   &���� =    	
	 n     1    ��
�� 
leng n    o    ���� 
0 _list_   o    ���� 0 
listobject 
listObject
 m    ����   R    "��
�� .ascrerr ****      � **** m     ! �  L i s t   i s   e m p t y . ��
�� 
errn m    �����Y ����
�� 
erob J    ����  ��  ��  ��    r   ' 4 n  ' 2 I   , 2������ &0 asscriptparameter asScriptParameter  o   , -���� 0 	thescript 	theScript �� m   - .   �!! 
 u s i n g��  ��   o   ' ,���� 0 _support   o      ���� 0 	thescript 	theScript "#" r   5 =$%$ n   5 ;&'& 4   8 ;��(
�� 
cobj( m   9 :���� ' n  5 8)*) o   6 8���� 
0 _list_  * o   5 6���� 0 
listobject 
listObject% o      ���� 0 	theresult 	theResult# +,+ Q   > �-./- Y   A c0��12��0 r   P ^343 n  P \565 I   Q \��7���� 0 combineitems combineItems7 898 o   Q R���� 0 	theresult 	theResult9 :��: n   R X;<; 4   U X��=
�� 
cobj= o   V W���� 0 i  < n  R U>?> o   S U���� 
0 _list_  ? o   R S���� 0 
listobject 
listObject��  ��  6 o   P Q���� 0 	thescript 	theScript4 o      ���� 0 	theresult 	theResult�� 0 i  1 m   D E���� 2 n   E K@A@ 1   H J��
�� 
lengA n  E HBCB o   F H���� 
0 _list_  C o   E F���� 0 
listobject 
listObject��  . R      ��DE
�� .ascrerr ****      � ****D o      ���� 0 etext eTextE ��FG
�� 
errnF o      ���� 0 enumber eNumberG ��H��
�� 
errtH o      ���� 
0 eto eTo��  / R   k ���IJ
�� .ascrerr ****      � ****I b   ~ �KLK b   ~ �MNM b   ~ �OPO m   ~ �QQ �RR * C o u l d n ' t   r e d u c e   i t e m  P o   � ����� 0 i  N m   � �SS �TT  :  L o   � ����� 0 etext eTextJ ��UV
�� 
errnU o   m n���� 0 enumber eNumberV ��WX
�� 
erobW l  o wY����Y N   o wZZ n   o v[\[ 4   s v��]
�� 
cobj] o   t u���� 0 i  \ l  o s^����^ e   o s__ n  o s`a` o   p r���� 
0 _list_  a o   o p���� 0 
listobject 
listObject��  ��  ��  ��  X ��b��
�� 
errtb o   z {���� 
0 eto eTo��  , c��c L   � �dd o   � ����� 0 	theresult 	theResult��  � R      ��ef
�� .ascrerr ****      � ****e o      ���� 0 etext eTextf ��gh
�� 
errng o      ���� 0 enumber eNumberh ��ij
�� 
erobi o      ���� 0 efrom eFromj ��k��
�� 
errtk o      ���� 
0 eto eTo��  � I   � ���l���� 20 _errorwithpartialresult _errorWithPartialResultl mnm m   � �oo �pp  r e d u c e   l i s tn qrq o   � ����� 0 etext eTextr sts o   � ����� 0 enumber eNumbert uvu o   � ����� 0 efrom eFromv wxw o   � ����� 
0 eto eTox y��y o   � ����� 0 	theresult 	theResult��  ��  ��  � z{z l     ��������  ��  ��  { |}| l     ��������  ��  ��  } ~~ l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ��� l     ������  �   sort   � ��� 
   s o r t� ��� l     ��������  ��  ��  � ��� l      ������  ��� Notes: 

- Quicksort provides between [best case] O(n * log n) and [worst case] O(n * n) efficiency, typically leaning towards the former in all but the most pathological cases.

- One limitation of quicksort is that it isn't stable, i.e. items that compare as equal can appear in any order in the resulting list; their original order isn't preserved. An alternate algorithm such as Heapsort would avoid this, but would likely be significantly slower on average (while heapsort is guaranteed to be O(n * log n), it has much higher constant overhead than quicksort which tends to be fast in all but the most degenerate cases).

- This implementation trades some speed for greater robustness and flexibility, sorting a 10,000-number list in ~1sec, whereas a bare-bones quicksort might be 2x faster. OTOH, if you want fast code then AppleScript's the absolute last language you want to be using anyway, (e.g. Python's `sorted` function is 100x faster). For sorting simple lists of number/text/date values it's probably much quicker to send the AS list across the ASOC bridge and use -[NSArray sortedArray...], but that doesn't generalize to other use cases so isn't used here.

- TO DO: What, if anything, could be done to get better performance out of this code?

   � ���	�   N o t e s :   
 
 -   Q u i c k s o r t   p r o v i d e s   b e t w e e n   [ b e s t   c a s e ]   O ( n   *   l o g   n )   a n d   [ w o r s t   c a s e ]   O ( n   *   n )   e f f i c i e n c y ,   t y p i c a l l y   l e a n i n g   t o w a r d s   t h e   f o r m e r   i n   a l l   b u t   t h e   m o s t   p a t h o l o g i c a l   c a s e s . 
 
 -   O n e   l i m i t a t i o n   o f   q u i c k s o r t   i s   t h a t   i t   i s n ' t   s t a b l e ,   i . e .   i t e m s   t h a t   c o m p a r e   a s   e q u a l   c a n   a p p e a r   i n   a n y   o r d e r   i n   t h e   r e s u l t i n g   l i s t ;   t h e i r   o r i g i n a l   o r d e r   i s n ' t   p r e s e r v e d .   A n   a l t e r n a t e   a l g o r i t h m   s u c h   a s   H e a p s o r t   w o u l d   a v o i d   t h i s ,   b u t   w o u l d   l i k e l y   b e   s i g n i f i c a n t l y   s l o w e r   o n   a v e r a g e   ( w h i l e   h e a p s o r t   i s   g u a r a n t e e d   t o   b e   O ( n   *   l o g   n ) ,   i t   h a s   m u c h   h i g h e r   c o n s t a n t   o v e r h e a d   t h a n   q u i c k s o r t   w h i c h   t e n d s   t o   b e   f a s t   i n   a l l   b u t   t h e   m o s t   d e g e n e r a t e   c a s e s ) . 
 
 -   T h i s   i m p l e m e n t a t i o n   t r a d e s   s o m e   s p e e d   f o r   g r e a t e r   r o b u s t n e s s   a n d   f l e x i b i l i t y ,   s o r t i n g   a   1 0 , 0 0 0 - n u m b e r   l i s t   i n   ~ 1 s e c ,   w h e r e a s   a   b a r e - b o n e s   q u i c k s o r t   m i g h t   b e   2 x   f a s t e r .   O T O H ,   i f   y o u   w a n t   f a s t   c o d e   t h e n   A p p l e S c r i p t ' s   t h e   a b s o l u t e   l a s t   l a n g u a g e   y o u   w a n t   t o   b e   u s i n g   a n y w a y ,   ( e . g .   P y t h o n ' s   ` s o r t e d `   f u n c t i o n   i s   1 0 0 x   f a s t e r ) .   F o r   s o r t i n g   s i m p l e   l i s t s   o f   n u m b e r / t e x t / d a t e   v a l u e s   i t ' s   p r o b a b l y   m u c h   q u i c k e r   t o   s e n d   t h e   A S   l i s t   a c r o s s   t h e   A S O C   b r i d g e   a n d   u s e   - [ N S A r r a y   s o r t e d A r r a y . . . ] ,   b u t   t h a t   d o e s n ' t   g e n e r a l i z e   t o   o t h e r   u s e   c a s e s   s o   i s n ' t   u s e d   h e r e . 
 
 -   T O   D O :   W h a t ,   i f   a n y t h i n g ,   c o u l d   b e   d o n e   t o   g e t   b e t t e r   p e r f o r m a n c e   o u t   o f   t h i s   c o d e ? 
 
� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� j   9 ;����� *0 _quicksortthreshold _quicksortThreshold� m   9 :���� � ��� l     ��������  ��  ��  � ��� i  < ?��� I      ������� 	0 _sort  � ��� o      ���� $0 resultlistobject resultListObject� ��� o      ���� 0 	fromindex 	fromIndex� ��� o      ���� 0 toindex toIndex� ��� o      ����  0 sortcomparator sortComparator� ���� o      ���� 0 usequicksort useQuickSort��  ��  � l   ���� k    �� ��� Z    t������� o     ���� 0 usequicksort useQuickSort� l  p���� k   p�� ��� Z   ������� A    	��� \    ��� o    �� 0 toindex toIndex� o    �~�~ 0 	fromindex 	fromIndex� m    �}�} � L    �|�|  ��  ��  � ��� r    &��� J    �� ��� o    �{�{ 0 	fromindex 	fromIndex� ��z� o    �y�y 0 toindex toIndex�z  � J      �� ��� o      �x�x 0 	leftindex 	leftIndex� ��w� o      �v�v 0 
rightindex 
rightIndex�w  � ��� l  ' 8���� r   ' 8��� n   ' 6��� 3   4 6�u
�u 
cobj� n   ' 4��� 7  * 4�t��
�t 
cobj� o   . 0�s�s 0 	fromindex 	fromIndex� o   1 3�r�r 0 toindex toIndex� n  ' *��� o   ( *�q�q 
0 _keys_  � o   ' (�p�p $0 resultlistobject resultListObject� o      �o�o 0 
pivotvalue 
pivotValue� � � TO DO: if resultListObject's _list_'s length>someLargeThreshold then use median of 3 items? (TBH, picking a good midrange pivot is probably least of its problems performancewise)   � ���f   T O   D O :   i f   r e s u l t L i s t O b j e c t ' s   _ l i s t _ ' s   l e n g t h > s o m e L a r g e T h r e s h o l d   t h e n   u s e   m e d i a n   o f   3   i t e m s ?   ( T B H ,   p i c k i n g   a   g o o d   m i d r a n g e   p i v o t   i s   p r o b a b l y   l e a s t   o f   i t s   p r o b l e m s   p e r f o r m a n c e w i s e )� ��� V   9;��� k   A6�� ��� Q   A ����� V   D d��� l  Z _���� r   Z _��� [   Z ]��� o   Z [�n�n 0 	leftindex 	leftIndex� m   [ \�m�m � o      �l�l 0 	leftindex 	leftIndex� � z while cmp returns -1; note that if compareKeys() returns a non-numeric value/no result, this will throw -1700/-2763 error   � ��� �   w h i l e   c m p   r e t u r n s   - 1 ;   n o t e   t h a t   i f   c o m p a r e K e y s ( )   r e t u r n s   a   n o n - n u m e r i c   v a l u e / n o   r e s u l t ,   t h i s   w i l l   t h r o w   - 1 7 0 0 / - 2 7 6 3   e r r o r� A   H Y��� c   H W��� n  H U��� I   I U�k��j�k 0 comparekeys compareKeys� ��� e   I P�� n   I P��� 4   L O�i�
�i 
cobj� o   M N�h�h 0 	leftindex 	leftIndex� n  I L��� o   J L�g�g 
0 _keys_  � o   I J�f�f $0 resultlistobject resultListObject� ��e� o   P Q�d�d 0 
pivotvalue 
pivotValue�e  �j  � o   H I�c�c  0 sortcomparator sortComparator� m   U V�b
�b 
nmbr� m   W X�a�a  � R      �`��
�` .ascrerr ****      � ****� o      �_�_ 0 etext eText� �^��
�^ 
errn� o      �]�] 0 enum eNum� �\��
�\ 
erob� o      �[�[ 0 efrom eFrom� �Z �Y
�Z 
errt  o      �X�X 
0 eto eTo�Y  � R   l ��W
�W .ascrerr ****      � **** b   |  m   | } � < C o u l d n ' t   c o m p a r e   o b j e c t   k e y s :   o   } ~�V�V 0 etext eText �U
�U 
errn o   n o�T�T 0 enum eNum �S	

�S 
erob	 J   p y  n   p v 4   s v�R
�R 
cobj o   t u�Q�Q 0 	leftindex 	leftIndex n  p s o   q s�P�P 
0 _keys_   o   p q�O�O $0 resultlistobject resultListObject �N o   v w�M�M 0 
pivotvalue 
pivotValue�N  
 �L�K
�L 
errt o   z {�J�J 
0 eto eTo�K  �  Q   � � V   � � l  � � r   � �  \   � �!"! o   � ��I�I 0 
rightindex 
rightIndex" m   � ��H�H   o      �G�G 0 
rightindex 
rightIndex   while cmp returns 1;     �## ,   w h i l e   c m p   r e t u r n s   1 ;   ?   � �$%$ c   � �&'& n  � �()( I   � ��F*�E�F 0 comparekeys compareKeys* +,+ n   � �-.- 4   � ��D/
�D 
cobj/ o   � ��C�C 0 
rightindex 
rightIndex. n  � �010 o   � ��B�B 
0 _keys_  1 o   � ��A�A $0 resultlistobject resultListObject, 2�@2 o   � ��?�? 0 
pivotvalue 
pivotValue�@  �E  ) o   � ��>�>  0 sortcomparator sortComparator' m   � ��=
�= 
nmbr% m   � ��<�<   R      �;34
�; .ascrerr ****      � ****3 o      �:�: 0 etext eText4 �956
�9 
errn5 o      �8�8 0 enum eNum6 �778
�7 
erob7 o      �6�6 0 efrom eFrom8 �59�4
�5 
errt9 o      �3�3 
0 eto eTo�4   R   � ��2:;
�2 .ascrerr ****      � ****: b   � �<=< m   � �>> �?? < C o u l d n ' t   c o m p a r e   o b j e c t   k e y s :  = o   � ��1�1 0 etext eText; �0@A
�0 
errn@ o   � ��/�/ 0 enum eNumA �.BC
�. 
erobB J   � �DD EFE n   � �GHG 4   � ��-I
�- 
cobjI o   � ��,�, 0 
rightindex 
rightIndexH n  � �JKJ o   � ��+�+ 
0 _keys_  K o   � ��*�* $0 resultlistobject resultListObjectF L�)L o   � ��(�( 0 
pivotvalue 
pivotValue�)  C �'M�&
�' 
errtM o   � ��%�% 
0 eto eTo�&   N�$N Z   �6OP�#�"O l  � �Q�!� Q H   � �RR ?   � �STS o   � ��� 0 	leftindex 	leftIndexT o   � ��� 0 
rightindex 
rightIndex�!  �   P k   �2UU VWV r   � �XYX J   � �ZZ [\[ e   � �]] n   � �^_^ 4   � ��`
� 
cobj` o   � ��� 0 
rightindex 
rightIndex_ n  � �aba o   � ��� 
0 _keys_  b o   � ��� $0 resultlistobject resultListObject\ c�c e   � �dd n   � �efe 4   � ��g
� 
cobjg o   � ��� 0 	leftindex 	leftIndexf n  � �hih o   � ��� 
0 _keys_  i o   � ��� $0 resultlistobject resultListObject�  Y J      jj klk n      mnm 4   � ��o
� 
cobjo o   � ��� 0 	leftindex 	leftIndexn n  � �pqp o   � ��� 
0 _keys_  q o   � ��� $0 resultlistobject resultListObjectl r�r n      sts 4   � ��u
� 
cobju o   � ��� 0 
rightindex 
rightIndext n  � �vwv o   � ��� 
0 _keys_  w o   � ��� $0 resultlistobject resultListObject�  W xyx r   �z{z J   �|| }~} e   � � n   � ���� 4   � ���
� 
cobj� o   � ��
�
 0 
rightindex 
rightIndex� n  � ���� o   � ��	�	 
0 _list_  � o   � ��� $0 resultlistobject resultListObject~ ��� e   � ��� n   � ���� 4   � ���
� 
cobj� o   � ��� 0 	leftindex 	leftIndex� n  � ���� o   � ��� 
0 _list_  � o   � ��� $0 resultlistobject resultListObject�  { J      �� ��� n      ��� 4  	��
� 
cobj� o  
�� 0 	leftindex 	leftIndex� n 	��� o  	� �  
0 _list_  � o  ���� $0 resultlistobject resultListObject� ���� n      ��� 4  ���
�� 
cobj� o  ���� 0 
rightindex 
rightIndex� n ��� o  ���� 
0 _list_  � o  ���� $0 resultlistobject resultListObject��  y ���� r  2��� J  #�� ��� [  ��� o  ���� 0 	leftindex 	leftIndex� m  ���� � ���� \  !��� o  ���� 0 
rightindex 
rightIndex� m   ���� ��  � J      �� ��� o      ���� 0 	leftindex 	leftIndex� ���� o      ���� 0 
rightindex 
rightIndex��  ��  �#  �"  �$  � B   = @��� o   = >���� 0 	leftindex 	leftIndex� o   > ?���� 0 
rightindex 
rightIndex� ���� Q  <p���� k  ?g�� ��� I  ?Q������� 	0 _sort  � ��� o  @A���� $0 resultlistobject resultListObject� ��� o  AB���� 0 	fromindex 	fromIndex� ��� o  BC���� 0 
rightindex 
rightIndex� ��� o  CD����  0 sortcomparator sortComparator� ���� ?  DM��� \  DG��� o  DE���� 0 
rightindex 
rightIndex� o  EF���� 0 	fromindex 	fromIndex� o  GL���� *0 _quicksortthreshold _quicksortThreshold��  ��  � ��� I  Rd������� 	0 _sort  � ��� o  ST���� $0 resultlistobject resultListObject� ��� o  TU���� 0 	leftindex 	leftIndex� ��� o  UV���� 0 toindex toIndex� ��� o  VW����  0 sortcomparator sortComparator� ���� ?  W`��� \  WZ��� o  WX���� 0 toindex toIndex� o  XY���� 0 	leftindex 	leftIndex� o  Z_���� *0 _quicksortthreshold _quicksortThreshold��  ��  � ���� L  eg����  ��  � R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      ����
���  � l oo������  � � � stack overflow, so fall-through to use non-recursive insertion sort -- TO DO: if this is a concern, switch to non-recursive implementation that stores unsorted ranges in its own stack structure   � ����   s t a c k   o v e r f l o w ,   s o   f a l l - t h r o u g h   t o   u s e   n o n - r e c u r s i v e   i n s e r t i o n   s o r t   - -   T O   D O :   i f   t h i s   i s   a   c o n c e r n ,   s w i t c h   t o   n o n - r e c u r s i v e   i m p l e m e n t a t i o n   t h a t   s t o r e s   u n s o r t e d   r a n g e s   i n   i t s   o w n   s t a c k   s t r u c t u r e��  � � � sort mostly uses quicksort, but falls through to insertionsort when sorting small number of items (<8), or when sorting a mostly-sorted list, or when quicksort recursion exceeds AS's stack depth   � ����   s o r t   m o s t l y   u s e s   q u i c k s o r t ,   b u t   f a l l s   t h r o u g h   t o   i n s e r t i o n s o r t   w h e n   s o r t i n g   s m a l l   n u m b e r   o f   i t e m s   ( < 8 ) ,   o r   w h e n   s o r t i n g   a   m o s t l y - s o r t e d   l i s t ,   o r   w h e n   q u i c k s o r t   r e c u r s i o n   e x c e e d s   A S ' s   s t a c k   d e p t h��  ��  � ��� l uu������  � � � fall-through to use loop-based insertion sort when sorting a small number of items (for which it is faster than quicksort), or when quicksort recursion overflows AppleScript's call stack   � ���v   f a l l - t h r o u g h   t o   u s e   l o o p - b a s e d   i n s e r t i o n   s o r t   w h e n   s o r t i n g   a   s m a l l   n u m b e r   o f   i t e m s   ( f o r   w h i c h   i t   i s   f a s t e r   t h a n   q u i c k s o r t ) ,   o r   w h e n   q u i c k s o r t   r e c u r s i o n   o v e r f l o w s   A p p l e S c r i p t ' s   c a l l   s t a c k� ��� r  uz��� [  ux��� o  uv���� 0 	fromindex 	fromIndex� m  vw���� � o      ���� 0 	fromindex 	fromIndex� ���� Y  {�������� Y  �������� k  ��� ��� r  ����� J  ���� ��� e  ���� n  ����� 4  �����
�� 
cobj� l �������� \  ����� o  ������ 0 j  � m  ������ ��  ��  � n ����� o  ������ 
0 _keys_  � o  ������ $0 resultlistobject resultListObject� ���� e  ���� n  ����� 4  ���� 
�� 
cobj  o  ������ 0 j  � n �� o  ������ 
0 _keys_   o  ������ $0 resultlistobject resultListObject��  � J        o      ���� 0 leftkey leftKey �� o      ���� 0 rightkey rightKey��  �  l ��	
	 Z ������ A  �� n �� I  �������� 0 comparekeys compareKeys  o  ������ 0 leftkey leftKey �� o  ������ 0 rightkey rightKey��  ��   o  ������  0 sortcomparator sortComparator m  ������   S  ����  ��  
 !  stop when leftKey�rightKey    � 6   s t o p   w h e n   l e f t K e y"d r i g h t K e y  r  �� J  ��  o  ������ 0 rightkey rightKey �� o  ������ 0 leftkey leftKey��   J        !  n      "#" 4  ����$
�� 
cobj$ l ��%����% \  ��&'& o  ������ 0 j  ' m  ������ ��  ��  # n ��()( o  ������ 
0 _keys_  ) o  ������ $0 resultlistobject resultListObject! *��* n      +,+ 4  ����-
�� 
cobj- o  ������ 0 j  , n ��./. o  ������ 
0 _keys_  / o  ������ $0 resultlistobject resultListObject��   0��0 r  �121 J  ��33 454 e  ��66 n  ��787 4  ����9
�� 
cobj9 o  ������ 0 j  8 n ��:;: o  ������ 
0 _list_  ; o  ������ $0 resultlistobject resultListObject5 <��< e  ��== n  ��>?> 4  ����@
�� 
cobj@ l ��A����A \  ��BCB o  ������ 0 j  C m  ������ ��  ��  ? n ��DED o  ������ 
0 _list_  E o  ������ $0 resultlistobject resultListObject��  2 J      FF GHG n      IJI 4  ���K
�� 
cobjK l �L����L \  �MNM o  ������ 0 j  N m  � ���� ��  ��  J n ��OPO o  ������ 
0 _list_  P o  ������ $0 resultlistobject resultListObjectH Q��Q n      RSR 4  ��T
�� 
cobjT o  ���� 0 j  S n UVU o  	���� 
0 _list_  V o  	���� $0 resultlistobject resultListObject��  ��  �� 0 j  � o  ������ 0 i  � o  ������ 0 	fromindex 	fromIndex� m  ���������� 0 i  � o  ~���� 0 	fromindex 	fromIndex� o  ����� 0 toindex toIndex��  ��  � 1 + performs in-place quicksort/insertionsort	   � �WW V   p e r f o r m s   i n - p l a c e   q u i c k s o r t / i n s e r t i o n s o r t 	� XYX l     ��������  ��  ��  Y Z[Z l     �������  ��  �  [ \]\ l     �~�}�|�~  �}  �|  ] ^_^ i  @ C`a` I     �{bc
�{ .Lst:Sortnull���     ****b o      �z�z 0 thelist theListc �yd�x
�y 
Compd |�w�ve�uf�w  �v  e o      �t�t $0 comparatorobject comparatorObject�u  f m      �s
�s 
msng�x  a k    �gg hih l     �rjk�r  j.( note that `sort list` currently doesn't implement a `reversed order` parameter as its quicksort algorithm isn't stable (i.e. items that compare as equal will appear in any order, not the order in which they were supplied), so such an option would be useless in practice and rather misleading too. (To get a list in descending order, just get the returned list's `reverse` property or else pass a comparator containing a suitable compareKeys handler.) This parameter can always be added in future if/when a stable sorting algorithm is ever implemented.   k �llP   n o t e   t h a t   ` s o r t   l i s t `   c u r r e n t l y   d o e s n ' t   i m p l e m e n t   a   ` r e v e r s e d   o r d e r `   p a r a m e t e r   a s   i t s   q u i c k s o r t   a l g o r i t h m   i s n ' t   s t a b l e   ( i . e .   i t e m s   t h a t   c o m p a r e   a s   e q u a l   w i l l   a p p e a r   i n   a n y   o r d e r ,   n o t   t h e   o r d e r   i n   w h i c h   t h e y   w e r e   s u p p l i e d ) ,   s o   s u c h   a n   o p t i o n   w o u l d   b e   u s e l e s s   i n   p r a c t i c e   a n d   r a t h e r   m i s l e a d i n g   t o o .   ( T o   g e t   a   l i s t   i n   d e s c e n d i n g   o r d e r ,   j u s t   g e t   t h e   r e t u r n e d   l i s t ' s   ` r e v e r s e `   p r o p e r t y   o r   e l s e   p a s s   a   c o m p a r a t o r   c o n t a i n i n g   a   s u i t a b l e   c o m p a r e K e y s   h a n d l e r . )   T h i s   p a r a m e t e r   c a n   a l w a y s   b e   a d d e d   i n   f u t u r e   i f / w h e n   a   s t a b l e   s o r t i n g   a l g o r i t h m   i s   e v e r   i m p l e m e n t e d .i m�qm Q    �nopn k   �qq rsr r    tut n   vwv I    �px�o�p "0 aslistparameter asListParameterx yzy o    	�n�n 0 thelist theListz {�m{ m   	 
|| �}}  �m  �o  w o    �l�l 0 _support  u o      �k�k 0 thelist theLists ~~ h    �j��j $0 resultlistobject resultListObject� k      �� ��� j     	�i��i 
0 _keys_  � n     ��� 2   �h
�h 
cobj� o     �g�g 0 thelist theList� ��f� j   
 �e��e 
0 _list_  � n   
 ��� 2   �d
�d 
cobj� o   
 �c�c 0 thelist theList�f   ��� Z   ,���b�a� A     ��� n   ��� 1    �`
�` 
leng� n   ��� o    �_�_ 
0 _list_  � o    �^�^ $0 resultlistobject resultListObject� m    �]�] � L   # (�� n  # '��� o   $ &�\�\ 
0 _list_  � o   # $�[�[ $0 resultlistobject resultListObject�b  �a  � ��� Z   - J���Z�� =  - 0��� o   - .�Y�Y $0 comparatorobject comparatorObject� m   . /�X
�X 
msng� r   3 :��� I  3 8�W�V�U
�W .Lst:DeSonull��� ��� null�V  �U  � o      �T�T  0 sortcomparator sortComparator�Z  � r   = J��� n  = H��� I   B H�S��R�S &0 asscriptparameter asScriptParameter� ��� o   B C�Q�Q $0 comparatorobject comparatorObject� ��P� m   C D�� ��� 
 u s i n g�P  �R  � o   = B�O�O 0 _support  � o      �N�N  0 sortcomparator sortComparator� ��� l  K K�M���M  ��� note: the quickest way to check types is (count {resultListObject's _list_} each number/text/date) = length of resultListObject's _list_; could also accept number/text/date in `using` and create default comparator according to that; OTOH, a benefit of this extra O(n) pass is that we can check if list is already sorted or almost sorted and return immediately or use insertionsort instead of quicksort if it is   � ���6   n o t e :   t h e   q u i c k e s t   w a y   t o   c h e c k   t y p e s   i s   ( c o u n t   { r e s u l t L i s t O b j e c t ' s   _ l i s t _ }   e a c h   n u m b e r / t e x t / d a t e )   =   l e n g t h   o f   r e s u l t L i s t O b j e c t ' s   _ l i s t _ ;   c o u l d   a l s o   a c c e p t   n u m b e r / t e x t / d a t e   i n   ` u s i n g `   a n d   c r e a t e   d e f a u l t   c o m p a r a t o r   a c c o r d i n g   t o   t h a t ;   O T O H ,   a   b e n e f i t   o f   t h i s   e x t r a   O ( n )   p a s s   i s   t h a t   w e   c a n   c h e c k   i f   l i s t   i s   a l r e a d y   s o r t e d   o r   a l m o s t   s o r t e d   a n d   r e t u r n   i m m e d i a t e l y   o r   u s e   i n s e r t i o n s o r t   i n s t e a d   o f   q u i c k s o r t   i f   i t   i s� ��� l  K K�L���L  � TO DO: if makeKey not specified, throw error if all items are not same type (number/text/date); this'll prevent unpredictable results due to mixed types (e.g. {11,"2"} vs {"11", 2}), forcing users to pass an appropriate comparator if they want to sort mixed lists   � ���   T O   D O :   i f   m a k e K e y   n o t   s p e c i f i e d ,   t h r o w   e r r o r   i f   a l l   i t e m s   a r e   n o t   s a m e   t y p e   ( n u m b e r / t e x t / d a t e ) ;   t h i s ' l l   p r e v e n t   u n p r e d i c t a b l e   r e s u l t s   d u e   t o   m i x e d   t y p e s   ( e . g .   { 1 1 , " 2 " }   v s   { " 1 1 " ,   2 } ) ,   f o r c i n g   u s e r s   t o   p a s s   a n   a p p r o p r i a t e   c o m p a r a t o r   i f   t h e y   w a n t   t o   s o r t   m i x e d   l i s t s� ��� Z   K p���K�� F   K `��� >  K N��� o   K L�J�J $0 comparatorobject comparatorObject� m   L M�I
�I 
msng� n  Q ^��� I   V ^�H��G�H 0 
hashandler 
hasHandler� ��F� N   V Z�� n   V Y��� o   W Y�E�E 0 makekey makeKey� o   V W�D�D  0 sortcomparator sortComparator�F  �G  � o   Q V�C�C 0 _support  � l  c f���� r   c f��� o   c d�B�B  0 sortcomparator sortComparator� o      �A�A 0 keymaker keyMaker� M G call comparator's makeKey method to generate each sortable key in turn   � ��� �   c a l l   c o m p a r a t o r ' s   m a k e K e y   m e t h o d   t o   g e n e r a t e   e a c h   s o r t a b l e   k e y   i n   t u r n�K  � r   i p��� I  i n�@�?�>
�@ .Lst:DeSonull��� ��� null�?  �>  � o      �=�= 0 keymaker keyMaker� ��� l  q ����� r   q ���� J   q u�� ��� m   q r�<�<  � ��;� m   r s�:�:  �;  � J      �� ��� o      �9�9  0 ascendingcount ascendingCount� ��8� o      �7�7 "0 descendingcount descendingCount�8  � � � while generating keys also check if list is already almost/fully sorted (either ascending or descending) and if it is use insertionsort/return as-is   � ���*   w h i l e   g e n e r a t i n g   k e y s   a l s o   c h e c k   i f   l i s t   i s   a l r e a d y   a l m o s t / f u l l y   s o r t e d   ( e i t h e r   a s c e n d i n g   o r   d e s c e n d i n g )   a n d   i f   i t   i s   u s e   i n s e r t i o n s o r t / r e t u r n   a s - i s� ��� Q   �b���� k   �H�� ��� Q   � ����� r   � ���� n  � ���� I   � ��6��5�6 0 makekey makeKey� ��4� e   � ��� n   � ���� 4   � ��3�
�3 
cobj� m   � ��2�2 � n  � ���� o   � ��1�1 
0 _keys_  � o   � ��0�0 $0 resultlistobject resultListObject�4  �5  � o   � ��/�/  0 sortcomparator sortComparator� o      �.�. 0 previouskey previousKey� R      �-��
�- .ascrerr ****      � ****� o      �,�, 0 etext eText� �+��
�+ 
errn� o      �*�* 0 enum eNum� �)��(
�) 
errt� o      �'�' 
0 eto eTo�(  � R   � ��&��
�& .ascrerr ****      � ****� b   � ���� m   � ��� ��� : C o u l d n ' t   m a k e K e y   f o r   i t e m   1 :  � o   � ��%�% 0 etext eText� �$�	 
�$ 
errn� o   � ��#�# 0 enum eNum	  �"		
�" 
erob	 l  � �	�!� 	 N   � �		 n   � �			 4   � ��	
� 
cobj	 m   � ��� 	 l  � �	��	 e   � �				 n  � �	
		
 o   � ��� 
0 _list_  	 o   � ��� $0 resultlistobject resultListObject�  �  �!  �   	 �	�
� 
errt	 o   � ��� 
0 eto eTo�  � 			 r   � �			 o   � ��� 0 previouskey previousKey	 n      			 4   � ��	
� 
cobj	 m   � ��� 	 n  � �			 o   � ��� 
0 _keys_  	 o   � ��� $0 resultlistobject resultListObject	 	�	 Y   �H	�		�	 l  �C				 k   �C		 			 Q   �	 	!	"	  r   � �	#	$	# n  � �	%	&	% I   � ��	'�� 0 makekey makeKey	' 	(�	( n   � �	)	*	) 4   � ��	+
� 
cobj	+ o   � ��
�
 0 i  	* n  � �	,	-	, o   � ��	�	 
0 _keys_  	- o   � ��� $0 resultlistobject resultListObject�  �  	& o   � ���  0 sortcomparator sortComparator	$ o      �� 0 
currentkey 
currentKey	! R      �	.	/
� .ascrerr ****      � ****	. o      �� 0 etext eText	/ �	0	1
� 
errn	0 o      �� 0 enum eNum	1 �	2� 
� 
errt	2 o      ���� 
0 eto eTo�   	" R   ���	3	4
�� .ascrerr ****      � ****	3 b  	5	6	5 b  	7	8	7 b  	9	:	9 m  		;	; �	<	< 4 C o u l d n ' t   m a k e K e y   f o r   i t e m  	: o  	
���� 0 i  	8 m  	=	= �	>	>  :  	6 o  ���� 0 etext eText	4 ��	?	@
�� 
errn	? o   � ����� 0 enum eNum	@ ��	A	B
�� 
erob	A l  � �	C����	C N   � �	D	D n   � �	E	F	E 4   � ���	G
�� 
cobj	G o   � ����� 0 i  	F l  � �	H����	H e   � �	I	I n  � �	J	K	J o   � ����� 
0 _list_  	K o   � ����� $0 resultlistobject resultListObject��  ��  ��  ��  	B ��	L��
�� 
errt	L o  ���� 
0 eto eTo��  	 	M	N	M r  	O	P	O o  ���� 0 
currentkey 
currentKey	P n      	Q	R	Q 4  ��	S
�� 
cobj	S o  ���� 0 i  	R n 	T	U	T o  ���� 
0 _keys_  	U o  ���� $0 resultlistobject resultListObject	N 	V	W	V r  %	X	Y	X n #	Z	[	Z I  #��	\���� 0 comparekeys compareKeys	\ 	]	^	] o  ���� 0 previouskey previousKey	^ 	_��	_ o  ���� 0 
currentkey 
currentKey��  ��  	[ o  ����  0 sortcomparator sortComparator	Y o      ���� 0 keycomparison keyComparison	W 	`��	` Z  &C	a	b	c��	a A  &)	d	e	d o  &'���� 0 keycomparison keyComparison	e m  '(����  	b l ,1	f	g	h	f r  ,1	i	j	i [  ,/	k	l	k o  ,-����  0 ascendingcount ascendingCount	l m  -.���� 	j o      ����  0 ascendingcount ascendingCount	g   current key is larger   	h �	m	m ,   c u r r e n t   k e y   i s   l a r g e r	c 	n	o	n ?  47	p	q	p o  45���� 0 keycomparison keyComparison	q m  56����  	o 	r��	r l :?	s	t	u	s r  :?	v	w	v [  :=	x	y	x o  :;���� "0 descendingcount descendingCount	y m  ;<���� 	w o      ���� "0 descendingcount descendingCount	t   previous key is larger   	u �	z	z .   p r e v i o u s   k e y   i s   l a r g e r��  ��  ��  	 @ : TO DO: once again, need to know index for error reporting   	 �	{	{ t   T O   D O :   o n c e   a g a i n ,   n e e d   t o   k n o w   i n d e x   f o r   e r r o r   r e p o r t i n g� 0 i  	 m   � ����� 	 n  � �	|	}	| 1   � ���
�� 
leng	} n  � �	~		~ o   � ����� 
0 _keys_  	 o   � ����� $0 resultlistobject resultListObject�  �  � R      ��	�	�
�� .ascrerr ****      � ****	� o      ���� 0 etext eText	� ��	�	�
�� 
errn	� o      ���� 0 enum eNum	� ��	�	�
�� 
erob	� o      ���� 0 efrom eFrom	� ��	���
�� 
errt	� o      ���� 
0 eto eTo��  � R  Pb��	�	�
�� .ascrerr ****      � ****	� o  `a���� 0 etext eText	� ��	�	�
�� 
errn	� o  TU���� 0 enum eNum	� ��	�	�
�� 
erob	� o  XY���� 0 efrom eFrom	� ��	���
�� 
errt	� o  \]���� 
0 eto eTo��  � 	�	�	� l cc��	�	���  	� � �	log "   ORDEREDNESS=" & (ascendingCount * 100 div (resultListObject's _list_'s length)) & " " & (descendingCount * 100 div (resultListObject's _list_'s length))   	� �	�	�B 	 l o g   "       O R D E R E D N E S S = "   &   ( a s c e n d i n g C o u n t   *   1 0 0   d i v   ( r e s u l t L i s t O b j e c t ' s   _ l i s t _ ' s   l e n g t h ) )   &   "   "   &   ( d e s c e n d i n g C o u n t   *   1 0 0   d i v   ( r e s u l t L i s t O b j e c t ' s   _ l i s t _ ' s   l e n g t h ) )	� 	�	�	� l cc��	�	���  	� � � TO DO: if list is almost or fully ordered then tell _sort() to use insertionsort or return as-is (remembering to reverse order as necessary), as that will be quicker than quicksorting the whole thing   	� �	�	��   T O   D O :   i f   l i s t   i s   a l m o s t   o r   f u l l y   o r d e r e d   t h e n   t e l l   _ s o r t ( )   t o   u s e   i n s e r t i o n s o r t   o r   r e t u r n   a s - i s   ( r e m e m b e r i n g   t o   r e v e r s e   o r d e r   a s   n e c e s s a r y ) ,   a s   t h a t   w i l l   b e   q u i c k e r   t h a n   q u i c k s o r t i n g   t h e   w h o l e   t h i n g	� 	�	�	� l cc��	�	���  	� TO DO: what about lists containing lots of duplicates, e.g. when sorting a large list containing only numbers from 0 to 10, or only true/false (basic quicksort gets pathological on those cases, so a three-way quicksort or a mergesort would work much better there)   	� �	�	�   T O   D O :   w h a t   a b o u t   l i s t s   c o n t a i n i n g   l o t s   o f   d u p l i c a t e s ,   e . g .   w h e n   s o r t i n g   a   l a r g e   l i s t   c o n t a i n i n g   o n l y   n u m b e r s   f r o m   0   t o   1 0 ,   o r   o n l y   t r u e / f a l s e   ( b a s i c   q u i c k s o r t   g e t s   p a t h o l o g i c a l   o n   t h o s e   c a s e s ,   s o   a   t h r e e - w a y   q u i c k s o r t   o r   a   m e r g e s o r t   w o u l d   w o r k   m u c h   b e t t e r   t h e r e )	� 	�	�	� l cp	�	�	�	� r  cp	�	�	� l cn	�����	� ?  cn	�	�	� n ch	�	�	� 1  fh��
�� 
leng	� n cf	�	�	� o  df���� 
0 _list_  	� o  cd���� $0 resultlistobject resultListObject	� o  hm���� *0 _quicksortthreshold _quicksortThreshold��  ��  	� o      ���� 0 usequicksort useQuickSort	� "  TO DO: or is nearly ordered   	� �	�	� 8   T O   D O :   o r   i s   n e a r l y   o r d e r e d	� 	�	�	� I  q���	����� 	0 _sort  	� 	�	�	� o  rs���� $0 resultlistobject resultListObject	� 	�	�	� m  st���� 	� 	�	�	� n ty	�	�	� 1  wy��
�� 
leng	� n tw	�	�	� o  uw���� 
0 _list_  	� o  tu���� $0 resultlistobject resultListObject	� 	�	�	� o  yz����  0 sortcomparator sortComparator	� 	���	� o  z{���� 0 usequicksort useQuickSort��  ��  	� 	���	� L  ��	�	� n ��	�	�	� o  ������ 
0 _list_  	� o  ������ $0 resultlistobject resultListObject��  o R      ��	�	�
�� .ascrerr ****      � ****	� o      ���� 0 etext eText	� ��	�	�
�� 
errn	� o      ���� 0 enumber eNumber	� ��	�	�
�� 
erob	� o      ���� 0 efrom eFrom	� ��	���
�� 
errt	� o      ���� 
0 eto eTo��  p I  ����	����� 
0 _error  	� 	�	�	� m  ��	�	� �	�	�  s o r t   l i s t	� 	�	�	� o  ������ 0 etext eText	� 	�	�	� o  ������ 0 enumber eNumber	� 	�	�	� o  ������ 0 efrom eFrom	� 	���	� o  ������ 
0 eto eTo��  ��  �q  _ 	�	�	� l     ��������  ��  ��  	� 	�	�	� l     ��������  ��  ��  	� 	�	�	� i  D G	�	�	� I     ������
�� .Lst:DeSonull��� ��� null��  ��  	� h     ��	��� &0 defaultcomparator DefaultComparator	� k      	�	� 	�	�	� j     ��	��� "0 _supportedtypes _supportedTypes	� J     	�	� 	�	�	� m     ��
�� 
nmbr	� 	�	�	� m    ��
�� 
ctxt	� 	���	� m    ��
�� 
ldt ��  	� 	�	�	� j    	��	��� 	0 _type  	� m    ��
�� 
msng	� 	�	�	� i   
 	�	�	� I      ��	����� 0 makekey makeKey	� 	���	� o      ���� 0 anobject anObject��  ��  	� k     }	�	� 	�	�	� Z     z	�	�	���	� =    	�	�	� o     ���� 	0 _type  	� m    ��
�� 
msng	� k   
 K	�	� 	�	�	� X   
 B	��	�	� Z    =	�	��~�}	� ?    *	�	�	� l   (
 �|�{
  I   (�z


�z .corecnte****       ****
 J    

 
�y
 o    �x�x 0 anobject anObject�y  
 �w
�v
�w 
kocl
 l    $
�u�t
 e     $

 n    $

	
 1   ! #�s
�s 
pcnt
	 o     !�r�r 0 aref aRef�u  �t  �v  �|  �{  	� m   ( )�q�q  	� k   - 9



 


 r   - 6


 n  - 0


 1   . 0�p
�p 
pcnt
 o   - .�o�o 0 aref aRef
 o      �n�n 	0 _type  
 
�m
 L   7 9

 o   7 8�l�l 0 anobject anObject�m  �~  �}  � 0 aref aRef	� n   


 o    �k�k "0 _supportedtypes _supportedTypes
  f    	� 
�j
 R   C K�i


�i .ascrerr ****      � ****
 m   I J

 �

 � I n v a l i d   i t e m   t y p e   ( d e f a u l t   c o m p a r a t o r   c a n   o n l y   c o m p a r e   i n t e g e r / r e a l ,   t e x t ,   o r   d a t e   t y p e s ) .
 �h


�h 
errn
 m   E F�g�g�\
 �f
�e
�f 
erob
 o   G H�d�d 0 anobject anObject�e  �j  	� 


 =   N ]

 
 l  N [
!�c�b
! I  N [�a
"
#
�a .corecnte****       ****
" J   N Q
$
$ 
%�`
% o   N O�_�_ 0 anobject anObject�`  
# �^
&�]
�^ 
kocl
& o   R W�\�\ 	0 _type  �]  �c  �b  
  m   [ \�[�[  
 
'�Z
' R   ` v�Y
(
)
�Y .ascrerr ****      � ****
( b   f u
*
+
* b   f s
,
-
, b   f o
.
/
. b   f m
0
1
0 m   f g
2
2 �
3
3 ^ I n v a l i d   i t e m   t y p e   ( d e f a u l t   c o m p a r a t o r   e x p e c t e d  
1 o   g l�X�X 	0 _type  
/ m   m n
4
4 �
5
5    b u t   r e c e i v e d  
- l  o r
6�W�V
6 n   o r
7
8
7 m   p r�U
�U 
pcls
8 o   o p�T�T 0 anobject anObject�W  �V  
+ m   s t
9
9 �
:
:  ) .
) �S
;
<
�S 
errn
; m   b c�R�R�\
< �Q
=�P
�Q 
erob
= o   d e�O�O 0 anobject anObject�P  �Z  ��  	� 
>�N
> L   { }
?
? o   { |�M�M 0 anobject anObject�N  	� 
@�L
@ i   
A
B
A I      �K
C�J�K 0 comparekeys compareKeys
C 
D
E
D o      �I�I 0 
leftobject 
leftObject
E 
F�H
F o      �G�G 0 rightobject rightObject�H  �J  
B Z     
G
H
I
J
G A     
K
L
K o     �F�F 0 
leftobject 
leftObject
L o    �E�E 0 rightobject rightObject
H L    
M
M m    �D�D��
I 
N
O
N ?    
P
Q
P o    �C�C 0 
leftobject 
leftObject
Q o    �B�B 0 rightobject rightObject
O 
R�A
R L    
S
S m    �@�@ �A  
J L    
T
T m    �?�?  �L  	� 
U
V
U l     �>�=�<�>  �=  �<  
V 
W
X
W l     �;�:�9�;  �:  �9  
X 
Y
Z
Y i  H K
[
\
[ I     �8�7�6
�8 .Lst:NuSonull��� ��� null�7  �6  
\ h     �5
]�5 &0 numericcomparator NumericComparator
] k      
^
^ 
_
`
_ i    
a
b
a I      �4
c�3�4 0 makekey makeKey
c 
d�2
d o      �1�1 0 anobject anObject�2  �3  
b L     
e
e c     
f
g
f o     �0�0 0 anobject anObject
g m    �/
�/ 
nmbr
` 
h�.
h i   
i
j
i I      �-
k�,�- 0 comparekeys compareKeys
k 
l
m
l o      �+�+ 0 
leftobject 
leftObject
m 
n�*
n o      �)�) 0 rightobject rightObject�*  �,  
j l    
o
p
q
o L     
r
r \     
s
t
s o     �(�( 0 
leftobject 
leftObject
t o    �'�' 0 rightobject rightObject
p�� note: since compareKeys' return value can be any -ve/0/+ve number, a single subtraction operation is sufficient for numbers and dates. (Caveat: this doesn't take into account minor differences due to real imprecision. Currently this doesn't matter as quicksort isn't stable anyway so makes no guarantees about the order of [imprecisely] equal items; however, if quicksort ever gets replaced with a stable sorting algorithm then this method will need revised to use Number library's `cmp` instead.)   
q �
u
u�   n o t e :   s i n c e   c o m p a r e K e y s '   r e t u r n   v a l u e   c a n   b e   a n y   - v e / 0 / + v e   n u m b e r ,   a   s i n g l e   s u b t r a c t i o n   o p e r a t i o n   i s   s u f f i c i e n t   f o r   n u m b e r s   a n d   d a t e s .   ( C a v e a t :   t h i s   d o e s n ' t   t a k e   i n t o   a c c o u n t   m i n o r   d i f f e r e n c e s   d u e   t o   r e a l   i m p r e c i s i o n .   C u r r e n t l y   t h i s   d o e s n ' t   m a t t e r   a s   q u i c k s o r t   i s n ' t   s t a b l e   a n y w a y   s o   m a k e s   n o   g u a r a n t e e s   a b o u t   t h e   o r d e r   o f   [ i m p r e c i s e l y ]   e q u a l   i t e m s ;   h o w e v e r ,   i f   q u i c k s o r t   e v e r   g e t s   r e p l a c e d   w i t h   a   s t a b l e   s o r t i n g   a l g o r i t h m   t h e n   t h i s   m e t h o d   w i l l   n e e d   r e v i s e d   t o   u s e   N u m b e r   l i b r a r y ' s   ` c m p `   i n s t e a d . )�.  
Z 
v
w
v l     �&�%�$�&  �%  �$  
w 
x
y
x l     �#�"�!�#  �"  �!  
y 
z
{
z i  L O
|
}
| I     � ��
�  .Lst:DaSonull��� ��� null�  �  
} h     �
~�  0 datecomparator DateComparator
~ k      

 
�
�
� i    
�
�
� I      �
��� 0 makekey makeKey
� 
��
� o      �� 0 anobject anObject�  �  
� l    
�
�
�
� L     
�
� c     
�
�
� o     �� 0 anobject anObject
� m    �
� 
ldt 
��� TO DO: if coercion fails, try `date anObject` on offchance it's a text value? Am inclined not to, as that's locale dependent so will produce different results on different machines for same input (while text-to-number coercions are also a bit locale-sensitive, those coercions will simply fail whereas `date "05-05-05"` could produce multiple different values or errors). Safest approach is for user to supply her own comparator implementation that implements her exact requirements, rather than trying to second-guess what those requirements are (which has a tendency to create fresh problems faster than it solves them, as AppleScript frequently demonstrates).   
� �
�
�.   T O   D O :   i f   c o e r c i o n   f a i l s ,   t r y   ` d a t e   a n O b j e c t `   o n   o f f c h a n c e   i t ' s   a   t e x t   v a l u e ?   A m   i n c l i n e d   n o t   t o ,   a s   t h a t ' s   l o c a l e   d e p e n d e n t   s o   w i l l   p r o d u c e   d i f f e r e n t   r e s u l t s   o n   d i f f e r e n t   m a c h i n e s   f o r   s a m e   i n p u t   ( w h i l e   t e x t - t o - n u m b e r   c o e r c i o n s   a r e   a l s o   a   b i t   l o c a l e - s e n s i t i v e ,   t h o s e   c o e r c i o n s   w i l l   s i m p l y   f a i l   w h e r e a s   ` d a t e   " 0 5 - 0 5 - 0 5 " `   c o u l d   p r o d u c e   m u l t i p l e   d i f f e r e n t   v a l u e s   o r   e r r o r s ) .   S a f e s t   a p p r o a c h   i s   f o r   u s e r   t o   s u p p l y   h e r   o w n   c o m p a r a t o r   i m p l e m e n t a t i o n   t h a t   i m p l e m e n t s   h e r   e x a c t   r e q u i r e m e n t s ,   r a t h e r   t h a n   t r y i n g   t o   s e c o n d - g u e s s   w h a t   t h o s e   r e q u i r e m e n t s   a r e   ( w h i c h   h a s   a   t e n d e n c y   t o   c r e a t e   f r e s h   p r o b l e m s   f a s t e r   t h a n   i t   s o l v e s   t h e m ,   a s   A p p l e S c r i p t   f r e q u e n t l y   d e m o n s t r a t e s ) .
� 
��
� i   
�
�
� I      �
��� 0 comparekeys compareKeys
� 
�
�
� o      �� 0 
leftobject 
leftObject
� 
��
� o      �� 0 rightobject rightObject�  �  
� l    
�
�
�
� L     
�
� \     
�
�
� o     �� 0 
leftobject 
leftObject
� o    �� 0 rightobject rightObject
� Y S as in NumericComparator, a simple subtraction operation produces a suitable result   
� �
�
� �   a s   i n   N u m e r i c C o m p a r a t o r ,   a   s i m p l e   s u b t r a c t i o n   o p e r a t i o n   p r o d u c e s   a   s u i t a b l e   r e s u l t�  
{ 
�
�
� l     ����  �  �  
� 
�
�
� l     ��
�	�  �
  �	  
� 
�
�
� i  P S
�
�
� I     ��
�
� .Lst:TeSonull��� ��� null�  
� �
��
� 
Cons
� |��
��
��  �  
� o      ��  0 orderingoption orderingOption�  
� m      � 
�  SrtECmpI�  
� l    b
�
�
�
� Q     b
�
�
�
� k    L
�
� 
�
�
� h    
��
��� B0 currentconsiderationscomparator CurrentConsiderationsComparator
� k      
�
� 
�
�
� i    
�
�
� I      ��
����� 0 makekey makeKey
� 
���
� o      ���� 0 anobject anObject��  ��  
� l    
�
�
�
� L     
�
� c     
�
�
� o     ���� 0 anobject anObject
� m    ��
�� 
ctxt
� _ Y TO DO: what if item is a list [of text]? currently it coerces to text using current TIDs   
� �
�
� �   T O   D O :   w h a t   i f   i t e m   i s   a   l i s t   [ o f   t e x t ] ?   c u r r e n t l y   i t   c o e r c e s   t o   t e x t   u s i n g   c u r r e n t   T I D s
� 
���
� i   
�
�
� I      ��
����� 0 comparekeys compareKeys
� 
�
�
� o      ���� 0 
leftobject 
leftObject
� 
���
� o      ���� 0 rightobject rightObject��  ��  
� Z     
�
�
�
�
� A     
�
�
� o     ���� 0 
leftobject 
leftObject
� o    ���� 0 rightobject rightObject
� L    
�
� m    ������
� 
�
�
� ?    
�
�
� o    ���� 0 
leftobject 
leftObject
� o    ���� 0 rightobject rightObject
� 
���
� L    
�
� m    ���� ��  
� L    
�
� m    ����  ��  
� 
���
� Z    L
�
�
�
�
� =   
�
�
� o    ����  0 orderingoption orderingOption
� m    ��
�� SrtECmpI
� k    
�
� 
�
�
� h    ��
��� >0 caseinsensitivetextcomparator CaseInsensitiveTextComparator
� k      
�
� 
�
�
� j     ��
�
�� 
pare
� o     ���� B0 currentconsiderationscomparator CurrentConsiderationsComparator
� 
���
� i  	 
�
�
� I      ��
����� 0 comparekeys compareKeys
� 
�
�
� o      ���� 0 
leftobject 
leftObject
� 
���
� o      ���� 0 rightobject rightObject��  ��  
� P     
�
�
�
� L    
�
� M    
�
� I      ��
����� 0 comparekeys compareKeys
� 
�
�
� o    ���� 0 
leftobject 
leftObject
� 
���
� o    ���� 0 rightobject rightObject��  ��  
� ��
�
�� conshyph
� ��
�
�� conspunc
� ��
�
�� conswhit
� ����
�� consnume��  
� ��
�
�� conscase
� ����
�� consdiac��  ��  
� 
���
� L    
�
� o    ���� >0 caseinsensitivetextcomparator CaseInsensitiveTextComparator��  
� 
�
�
� =   !
�
�
� o    ����  0 orderingoption orderingOption
� m     ��
�� SrtECmpC
� 
�
�
� k   $ .
�
�    h   $ +���� :0 casesensitivetextcomparator CaseSensitiveTextComparator k        j     ��
�� 
pare o     ���� B0 currentconsiderationscomparator CurrentConsiderationsComparator �� i  	 	 I      ��
���� 0 comparekeys compareKeys
  o      ���� 0 
leftobject 
leftObject �� o      ���� 0 rightobject rightObject��  ��  	 P      L     M     I      ������ 0 comparekeys compareKeys  o    ���� 0 
leftobject 
leftObject �� o    ���� 0 rightobject rightObject��  ��   ��
�� conscase ��
�� conshyph ��
�� conspunc ��
�� conswhit ����
�� consnume��   ����
�� consdiac��  ��   �� L   , . o   , -���� :0 casesensitivetextcomparator CaseSensitiveTextComparator��  
�  =  1 4  o   1 2����  0 orderingoption orderingOption  m   2 3��
�� SrtECmpD !��! L   7 9"" o   7 8���� B0 currentconsiderationscomparator CurrentConsiderationsComparator��  
� R   < L��#$
�� .ascrerr ****      � ****# m   H K%% �&& d I n v a l i d    f o r    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .$ ��'(
�� 
errn' m   > ?�����Y( ��)*
�� 
erob) o   @ A����  0 orderingoption orderingOption* ��+��
�� 
errt+ m   B E��
�� 
enum��  ��  
� R      ��,-
�� .ascrerr ****      � ****, o      ���� 0 etext eText- ��./
�� 
errn. o      ���� 0 enumber eNumber/ ��01
�� 
erob0 o      ���� 0 efrom eFrom1 ��2��
�� 
errt2 o      ���� 
0 eto eTo��  
� I   T b��3���� 
0 _error  3 454 m   U X66 �77  t e x t   c o m p a r a t o r5 898 o   X Y���� 0 etext eText9 :;: o   Y Z���� 0 enumber eNumber; <=< o   Z [���� 0 efrom eFrom= >��> o   [ \���� 
0 eto eTo��  ��  
� � � TO DO: also provide `exact match` option that considers case, diacriticals, hyphens, punctuation and white space but ignores numeric strings?   
� �??   T O   D O :   a l s o   p r o v i d e   ` e x a c t   m a t c h `   o p t i o n   t h a t   c o n s i d e r s   c a s e ,   d i a c r i t i c a l s ,   h y p h e n s ,   p u n c t u a t i o n   a n d   w h i t e   s p a c e   b u t   i g n o r e s   n u m e r i c   s t r i n g s ?
� @A@ l     ��������  ��  ��  A BCB l     ��������  ��  ��  C DED i  T WFGF I     ����H
�� .Lst:LiSonull��� ��� null��  H ��I��
�� 
CompI |����J��K��  ��  J o      ���� "0 itemcomparators itemComparators��  K l     L����L m      ��
�� 
msng��  ��  ��  G Z     DMN��OM =     PQP l    	R����R I    	��ST
�� .corecnte****       ****S J     UU V��V o     ���� "0 itemcomparators itemComparators��  T ��W��
�� 
koclW m    ��
�� 
list��  ��  ��  Q m   	 
��  N k    :XX YZY Z   2[\�~�}[ G    $]^] =   _`_ o    �|�| "0 itemcomparators itemComparators` m    �{
�{ 
msng^ H    "aa n   !bcb I    !�zd�y�z 0 
hashandler 
hasHandlerd e�xe N    ff n    ghg o    �w�w 0 makekey makeKeyh o    �v�v  0 sortcomparator sortComparator�x  �y  c o    �u�u 0 _support  \ r   ' .iji I  ' ,�t�s�r
�t .Lst:DeSonull��� ��� null�s  �r  j o      �q�q "0 itemcomparators itemComparators�~  �}  Z k�pk h   3 :�ol�o .0 uniformlistcomparator UniformListComparatorl k      mm non i    pqp I      �nr�m�n 0 makekey makeKeyr s�ls o      �k�k 0 sublist subList�l  �m  q l    tuvt h     �jw�j ,0 uniformkeycomparator UniformKeyComparatorw k      xx yzy j     �i{�i 0 _cachedkeys _cachedKeys{ J     �h�h  z |}| i    ~~ I      �g��f�g 0 getitem getItem� ��e� o      �d�d 0 atindex atIndex�e  �f   k     M�� ��� l     �c���c  � K E returns key for the specified sublist item, creating it as necessary   � ��� �   r e t u r n s   k e y   f o r   t h e   s p e c i f i e d   s u b l i s t   i t e m ,   c r e a t i n g   i t   a s   n e c e s s a r y� ��� l    ���� Z    ���b�a� ?     	��� o     �`�` 0 atindex atIndex� n   ��� 1    �_
�_ 
leng� o    �^�^ 0 sublist subList� L    �� m    �]
�] 
msng�b  �a  � a [ indicates no more items (i.e. shorter list comes before longer list, all else being equal)   � ��� �   i n d i c a t e s   n o   m o r e   i t e m s   ( i . e .   s h o r t e r   l i s t   c o m e s   b e f o r e   l o n g e r   l i s t ,   a l l   e l s e   b e i n g   e q u a l )� ��� Y    B��\���[� r   % =��� n  % 6��� I   * 6�Z��Y�Z 0 makekey makeKey� ��X� n  * 2��� 4   / 2�W�
�W 
cobj� o   0 1�V�V 0 i  � o   * /�U�U 0 sublist subList�X  �Y  � o   % *�T�T "0 itemcomparators itemComparators� n      ���  ;   ; <� o   6 ;�S�S 0 _cachedkeys _cachedKeys�\ 0 i  � [    ��� l   ��R�Q� n   ��� 1    �P
�P 
leng� o    �O�O 0 _cachedkeys _cachedKeys�R  �Q  � m    �N�N � o     �M�M 0 atindex atIndex�[  � ��L� L   C M�� n   C L��� 4   H K�K�
�K 
cobj� o   I J�J�J 0 atindex atIndex� o   C H�I�I 0 _cachedkeys _cachedKeys�L  } ��H� i   ��� I      �G��F�G 00 comparetokeycomparator compareToKeyComparator� ��E� o      �D�D (0 rightkeycomparator rightKeyComparator�E  �F  � k     r�� ��� l     �C���C  � k e iterates two sublists, comparing corresponding item keys until one is less or greater than the other   � ��� �   i t e r a t e s   t w o   s u b l i s t s ,   c o m p a r i n g   c o r r e s p o n d i n g   i t e m   k e y s   u n t i l   o n e   i s   l e s s   o r   g r e a t e r   t h a n   t h e   o t h e r� ��� Y     [��B���A� k    V�� ��� r    .��� J    �� ��� n   ��� I    �@��?�@ 0 getitem getItem� ��>� o    �=�= 0 i  �>  �?  �  f    � ��<� n   ��� I    �;��:�; 0 getitem getItem� ��9� o    �8�8 0 i  �9  �:  � o    �7�7 (0 rightkeycomparator rightKeyComparator�<  � J      �� ��� o      �6�6 0 
leftobject 
leftObject� ��5� o      �4�4 0 rightobject rightObject�5  � ��� l  / ;���� Z  / ;���3�2� =  / 2��� o   / 0�1�1 0 rightobject rightObject� m   0 1�0
�0 
msng� L   5 7�� m   5 6�/�/ �3  �2  � / ) right sublist is shorter, so comes first   � ��� R   r i g h t   s u b l i s t   i s   s h o r t e r ,   s o   c o m e s   f i r s t� ��� r   < I��� n  < G��� I   A G�.��-�. 0 comparekeys compareKeys� ��� o   A B�,�, 0 
leftobject 
leftObject� ��+� o   B C�*�* 0 rightobject rightObject�+  �-  � o   < A�)�) "0 itemcomparators itemComparators� o      �(�( $0 comparisonresult comparisonResult� ��'� Z  J V���&�%� >   J M��� o   J K�$�$ $0 comparisonresult comparisonResult� m   K L�#�#  � L   P R�� o   P Q�"�" $0 comparisonresult comparisonResult�&  �%  �'  �B 0 i  � m    �!�! � n   ��� 1   	 � 
�  
leng� o    	�� 0 sublist subList�A  � ��� l  \ o���� Z  \ o����� =  \ f��� n  \ d��� I   ] d���� 0 getitem getItem� ��� [   ] `��� o   ] ^�� 0 i  � m   ^ _�� �  �  � o   \ ]�� (0 rightkeycomparator rightKeyComparator� m   d e�
� 
msng� L   i k   m   i j��  �  �  �   both lists are identical   � � 2   b o t h   l i s t s   a r e   i d e n t i c a l� � l  p r L   p r m   p q���� A ; left sublist is shorter than right sublist, so comes first    � v   l e f t   s u b l i s t   i s   s h o r t e r   t h a n   r i g h t   s u b l i s t ,   s o   c o m e s   f i r s t�  �H  u C = returns an object that converts sublist items to keys lazily   v � z   r e t u r n s   a n   o b j e c t   t h a t   c o n v e r t s   s u b l i s t   i t e m s   t o   k e y s   l a z i l yo 	�	 i   

 I      ��� 0 comparekeys compareKeys  o      �� &0 leftkeycomparator leftKeyComparator � o      �� (0 rightkeycomparator rightKeyComparator�  �   L      n     I    ��� 00 comparetokeycomparator compareToKeyComparator �
 o    �	�	 (0 rightkeycomparator rightKeyComparator�
  �   o     �� &0 leftkeycomparator leftKeyComparator�  �p  ��  O h   = D�� *0 mixedlistcomparator MixedListComparator k        i     I      ��� 0 makekey makeKey � o      �� 0 sublist subList�  �   h     �� ,0 uniformkeycomparator UniformKeyComparator k         j     �!� 0 _cachedkeys _cachedKeys! J     � �     "#" i    $%$ I      ��&���� 0 getitem getItem& '��' o      ���� 0 atindex atIndex��  ��  % k     Y(( )*) l    +,-+ Z    ./����. ?     	010 o     ���� 0 atindex atIndex1 n   232 1    ��
�� 
leng3 o    ���� "0 itemcomparators itemComparators/ L    44 m    ��
�� 
msng��  ��  , a [ indicates no more items (i.e. shorter list comes before longer list, all else being equal)   - �55 �   i n d i c a t e s   n o   m o r e   i t e m s   ( i . e .   s h o r t e r   l i s t   c o m e s   b e f o r e   l o n g e r   l i s t ,   a l l   e l s e   b e i n g   e q u a l )* 676 Y    N8��9:��8 k   % I;; <=< r   % />?> n  % -@A@ 4   * -��B
�� 
cobjB o   + ,���� 0 i  A o   % *���� "0 itemcomparators itemComparators? o      ���� (0 listitemcomparator listItemComparator= C��C r   0 IDED n  0 BFGF I   3 B��H���� 0 makekey makeKeyH I��I n  3 >JKJ 4   8 >��L
�� 
cobjL l  9 =M����M n  9 =NON o   : <���� 0 	itemindex 	itemIndexO o   9 :���� (0 listitemcomparator listItemComparator��  ��  K o   3 8���� 0 sublist subList��  ��  G l  0 3P����P n  0 3QRQ o   1 3����  0 itemcomparator itemComparatorR o   0 1���� (0 listitemcomparator listItemComparator��  ��  E n      STS  ;   G HT o   B G���� 0 _cachedkeys _cachedKeys��  �� 0 i  9 [    UVU l   W����W n   XYX 1    ��
�� 
lengY o    ���� 0 _cachedkeys _cachedKeys��  ��  V m    ���� : o     ���� 0 atindex atIndex��  7 Z��Z L   O Y[[ n   O X\]\ 4   T W��^
�� 
cobj^ o   U V���� 0 atindex atIndex] o   O T���� 0 _cachedkeys _cachedKeys��  # _��_ i   `a` I      ��b���� 00 comparetokeycomparator compareToKeyComparatorb c��c o      ���� (0 rightkeycomparator rightKeyComparator��  ��  a k     wdd efe Y     `g��hi��g k    [jj klk r    .mnm J    oo pqp n   rsr I    ��t���� 0 getitem getItemt u��u o    ���� 0 i  ��  ��  s  f    q v��v n   wxw I    ��y���� 0 getitem getItemy z��z o    ���� 0 i  ��  ��  x o    ���� (0 rightkeycomparator rightKeyComparator��  n J      {{ |}| o      ���� 0 
leftobject 
leftObject} ~��~ o      ���� 0 rightobject rightObject��  l � l  / ;���� Z  / ;������� =  / 2��� o   / 0���� 0 rightobject rightObject� m   0 1��
�� 
msng� L   5 7�� m   5 6���� ��  ��  � / ) right sublist is shorter, so comes first   � ��� R   r i g h t   s u b l i s t   i s   s h o r t e r ,   s o   c o m e s   f i r s t� ��� r   < N��� n  < L��� I   F L������� 0 comparekeys compareKeys� ��� o   F G���� 0 
leftobject 
leftObject� ���� o   G H���� 0 rightobject rightObject��  ��  � l  < F������ n  < F��� o   D F����  0 itemcomparator itemComparator� n  < D��� 4   A D���
�� 
cobj� o   B C���� 0 i  � o   < A���� "0 itemcomparators itemComparators��  ��  � o      ���� $0 comparisonresult comparisonResult� ���� Z  O [������� >   O R��� o   O P���� $0 comparisonresult comparisonResult� m   P Q����  � L   U W�� o   U V���� $0 comparisonresult comparisonResult��  ��  ��  �� 0 i  h m    ���� i n   ��� 1   	 ��
�� 
leng� o    	���� "0 itemcomparators itemComparators��  f ��� l  a t���� Z  a t������� =  a k��� n  a i��� I   b i������� 0 getitem getItem� ���� [   b e��� o   b c���� 0 i  � m   c d���� ��  ��  � o   a b���� (0 rightkeycomparator rightKeyComparator� m   i j��
�� 
msng� L   n p�� m   n o����  ��  ��  �   both lists are identical   � ��� 2   b o t h   l i s t s   a r e   i d e n t i c a l� ���� l  u w���� L   u w�� m   u v������� A ; left sublist is shorter than right sublist, so comes first   � ��� v   l e f t   s u b l i s t   i s   s h o r t e r   t h a n   r i g h t   s u b l i s t ,   s o   c o m e s   f i r s t��  ��   ���� i   ��� I      ������� 0 comparekeys compareKeys� ��� o      ���� &0 leftkeycomparator leftKeyComparator� ���� o      ���� (0 rightkeycomparator rightKeyComparator��  ��  � L     �� n    ��� I    ������� 00 comparetokeycomparator compareToKeyComparator� ���� o    ���� (0 rightkeycomparator rightKeyComparator��  ��  � o     ���� &0 leftkeycomparator leftKeyComparator��  E ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  X [��� I     �����
�� .Lst:LiUSnull���     ****� o      ���� 0 thelist theList��  � Q     t���� k    b�� ��� h    
����� $0 resultlistobject resultListObject� j     ����� 
0 _list_  � n     ��� 2   ��
�� 
cobj� n    ��� I    ������� "0 aslistparameter asListParameter� ��� o    
���� 0 thelist theList� ��� m   
 �� ���  �  ��  � o     �~�~ 0 _support  � ��� r    ��� n    ��� 1    �}
�} 
leng� n   ��� o    �|�| 
0 _list_  � o    �{�{ $0 resultlistobject resultListObject� o      �z�z 0 len  � ��� Y    \��y���x� k    W�� ��� r    -��� I   +��w�� z�v�u
�v .sysorandnmbr    ��� nmbr
�u misccura�w  � �t��
�t 
from� m   # $�s�s � �r��q
�r 
to  � o   % &�p�p 0 len  �q  � o      �o�o 0 idx2  � ��n� r   . W��� J   . >�� ��� e   . 5�� n  . 5   4   1 4�m
�m 
cobj o   2 3�l�l 0 idx2   n  . 1 o   / 1�k�k 
0 _list_   o   . /�j�j $0 resultlistobject resultListObject� �i e   5 < n  5 < 4   8 ;�h	
�h 
cobj	 o   9 :�g�g 0 idx1   n  5 8

 o   6 8�f�f 
0 _list_   o   5 6�e�e $0 resultlistobject resultListObject�i  � J        n      4   F I�d
�d 
cobj o   G H�c�c 0 idx1   n  C F o   D F�b�b 
0 _list_   o   C D�a�a $0 resultlistobject resultListObject �` n      4   R U�_
�_ 
cobj o   S T�^�^ 0 idx2   n  O R o   P R�]�] 
0 _list_   o   O P�\�\ $0 resultlistobject resultListObject�`  �n  �y 0 idx1  � m    �[�[ � o    �Z�Z 0 len  �x  � �Y L   ] b n  ] a o   ^ `�X�X 
0 _list_   o   ] ^�W�W $0 resultlistobject resultListObject�Y  � R      �V
�V .ascrerr ****      � **** o      �U�U 0 etext eText �T !
�T 
errn  o      �S�S 0 enumber eNumber! �R"#
�R 
erob" o      �Q�Q 0 efrom eFrom# �P$�O
�P 
errt$ o      �N�N 
0 eto eTo�O  � I   j t�M%�L�M 
0 _error  % &'& m   k l(( �))  u n s o r t   l i s t' *+* o   l m�K�K 0 etext eText+ ,-, o   m n�J�J 0 enumber eNumber- ./. o   n o�I�I 0 efrom eFrom/ 0�H0 o   o p�G�G 
0 eto eTo�H  �L  � 121 l     �F�E�D�F  �E  �D  2 3�C3 l     �B�A�@�B  �A  �@  �C       �?456789:;<=>?@�>ABCDEFGH�?  4 �=�<�;�:�9�8�7�6�5�4�3�2�1�0�/�.�-�,�+�*�)
�= 
pimr�< 0 _support  �; 
0 _error  �: 20 _errorwithpartialresult _errorWithPartialResult�9 "0 _makelistobject _makeListObject
�8 .Lst:Instnull���     ****
�7 .Lst:Delenull���     ****
�6 .Lst:Findnull���     ****
�5 .Lst:Trannull���     ****
�4 .Lst:Map_null���     ****
�3 .Lst:Filtnull���     ****
�2 .Lst:Redunull���     ****�1 *0 _quicksortthreshold _quicksortThreshold�0 	0 _sort  
�/ .Lst:Sortnull���     ****
�. .Lst:DeSonull��� ��� null
�- .Lst:NuSonull��� ��� null
�, .Lst:DaSonull��� ��� null
�+ .Lst:TeSonull��� ��� null
�* .Lst:LiSonull��� ��� null
�) .Lst:LiUSnull���     ****5 �(I�( I  JJ �'K�&
�' 
cobjK LL   �%
�% 
osax�&  6 MM   �$ %
�$ 
scpt7 �# -�"�!NO� �# 
0 _error  �" �P� P  ������ 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo�!  N ������ 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToO ���
� 
msng� � 20 _errorwithpartialresult _errorWithPartialResult�  *�������+ 8 � I��QR�� 20 _errorwithpartialresult _errorWithPartialResult� �S� S  ���
�	��� 0 handlername handlerName� 0 etext eText�
 0 enumber eNumber�	 0 efrom eFrom� 
0 eto eTo� 0 epartial ePartial�  Q ������� 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 0 epartial ePartialR  [� ����
�  
msng�� �� 0 rethrowerror rethrowError� b  ࠡ�����+ 9 �� x����TU���� "0 _makelistobject _makeListObject�� ��V�� V  ������ 0 len  �� 0 padvalue padValue��  T �������� 0 len  �� 0 padvalue padValue�� 0 
listobject 
listObjectU �� �W���������� 0 
listobject 
listObjectW ��X����YZ��
�� .ascrinit****      � ****X k     [[  �����  ��  ��  Y ���� 
0 _list_  Z ���� 
0 _list_  �� jv��� �� 
0 _list_  
�� 
leng
�� 
cobj�� `��K S�O�j L�����v��,FO h��,�,���,��,%��,F[OY��O��,�,� ��,[�\[Zk\Z�2��,FY hY hO��,E: �� �����\]��
�� .Lst:Instnull���     ****�� 0 thelist theList�� ����^
�� 
Valu�� 0 thevalue theValue^ ��_`
�� 
Befo_ {�������� 0 beforeindex beforeIndex��  
�� 
msng` ��a��
�� 
Aftea {�������� 0 
afterindex 
afterIndex��  
�� 
msng��  \ 	�������������������� 0 thelist theList�� 0 thevalue theValue�� 0 beforeindex beforeIndex�� 0 
afterindex 
afterIndex�� 0 
listobject 
listObject�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo] �� �b����������������������>^������c������� 0 
listobject 
listObjectb ��d����ef��
�� .ascrinit****      � ****d k     gg  �����  ��  ��  e ���� 
0 _list_  f  ������� "0 aslistparameter asListParameter�� 
0 _list_  �� b  b   �l+ �
�� 
msng
�� 
errn���Y�� (0 asintegerparameter asIntegerParameter�� 
0 _list_  
�� 
leng���@
�� 
erob
�� 
cobj
�� 
insl�� 
�� 
bool�� 0 etext eTextc ����h
�� 
errn�� 0 enumber eNumberh ����i
�� 
erob�� 0 efrom eFromi ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  ��J5��K S�O�� [�� )��l�Y hOb  ��l+ E�O�j ��,�,�kE�Y hO���,�, )����,E��/�4�a Y hY ��� tb  �a l+ E�O�j 
�kE�Y '�j ��,�,�E�Y )����,E��/�3�a O���,�,
 	�ja & )����,E��/�3�a Y hY 
)��la O�j  �kv��,%Y 9���,�,  ��,�kv%Y $��,[�\[Zk\Z�2�kv%��,[�\[Z�k\Zi2%W X  *a ����a + ; ������jk��
�� .Lst:Delenull���     ****�� 0 thelist theList�� ��l��
�� 
Indel {�������� 0 theindex theIndex��  ������  j ���������������� 0 thelist theList�� 0 theindex theIndex�� 0 
listobject 
listObject�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTok ��m&�����������������������n������� 0 
listobject 
listObjectm ��o����pq��
�� .ascrinit****      � ****o k     rr ����  ��  ��  p ���� 
0 _list_  q ������ "0 aslistparameter asListParameter�� 
0 _list_  �� b  b   �l+ ��� (0 asintegerparameter asIntegerParameter�� 
0 _list_  
�� 
leng
�� 
bool
�� 
cobj
�� 
rest
�� 
errn���@
�� 
erob�� �� 0 etext eTextn ����s
�� 
errn�� 0 enumber eNumbers ����t
�� 
erob�� 0 efrom eFromt ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� � ���K S�Ob  ��l+ E�O��,�,k	 �j�& �i��,�,lv�kv ��,[�\[Zl\Zi2EY gk��,�,'lv�kv ��,�,EY M�j	 ���,�,�&
 �j	 ���,�,'�&�& %��,[�\[Zk\Z�k2��,[�\[Z�k\Zi2%Y hY "��,�,k  iklv�kv jvY hY hO)����,E�/��W X  *a ����a + < �������uv��
�� .Lst:Findnull���     ****�� 0 thelist theList�� ��~w
� 
Valu�~ 0 theitem theItemw �}x�|
�} 
Retux {�{�z�y�{ (0 findingoccurrences findingOccurrences�z  
�y LFWhLFWA�|  u 	�x�w�v�u�t�s�r�q�p�x 0 thelist theList�w 0 theitem theItem�v (0 findingoccurrences findingOccurrences�u 0 
listobject 
listObject�t 0 i  �s 0 etext eText�r 0 enumber eNumber�q 0 efrom eFrom�p 
0 eto eTov �o�y�n�m�l�k�j�i�h�g�f�e�d�c�bS�azh�`�_�o 0 
listobject 
listObjecty �^{�]�\|}�[
�^ .ascrinit****      � ****{ k     ~~ � ��Z�Z  �]  �\  | �Y�X�Y 
0 _list_  �X 0 _result_  } ��W�V�U�W "0 aslistparameter asListParameter�V 
0 _list_  �U 0 _result_  �[ b  b   �l+ �Ojv�
�n LFWhLFWA�m 
0 _list_  
�l 
leng
�k 
cobj�j 0 _result_  
�i LFWhLFWF
�h LFWhLFWL
�g 
errn�f�Y
�e 
erob
�d 
errt
�c 
enum�b �a 0 etext eTextz �T�S�
�T 
errn�S 0 enumber eNumber� �R�Q�
�R 
erob�Q 0 efrom eFrom� �P�O�N
�P 
errt�O 
0 eto eTo�N  �` �_ 
0 _error  �� � ���K S�O��  . (k��,�,Ekh ��,�/�  ���,6FY h[OY��Y v��  0 *k��,�,Ekh ��,�/�  ���,6FOY h[OY��Y B��  0 *��,�,Ekih ��,�/�  ���,6FOY h[OY��Y )������a O��,EW X  *a ����a + = �Mx�L�K���J
�M .Lst:Trannull���     ****�L 0 thelist theList�K �I��
�I 
Whil� {�H�G�F�H 0 unevenoption unevenOption�G  
�F LTrhLTrR� �E��D
�E 
PadI� {�C�B�A�C 0 padvalue padValue�B  
�A 
msng�D  � �@�?�>�=�<�;�:�9�8�7�6�5�4�3�@ 0 thelist theList�? 0 unevenoption unevenOption�> 0 padvalue padValue�= 0 
listobject 
listObject�< $0 resultlistlength resultListLength�; 0 aref aRef�: (0 emptyresultsublist emptyResultSubList�9 $0 resultlistobject resultListObject�8 0 i  �7 0 j  �6 0 etext eText�5 0 enumber eNumber�4 0 efrom eFrom�3 
0 eto eTo�  �2�1�0�/�.�-�,�+��*���)�(�'�&��%�$�#�"�!� ����w��
�2 
kocl
�1 
list
�0 .corecnte****       ****
�/ 
bool
�. 
errn�-�Y
�, 
erob�+ �* 0 
listobject 
listObject� �������
� .ascrinit****      � ****� k     �� ���  �  �  � �� 
0 _list_  � �� 
0 _list_  � b   ��) 
0 _list_  
�( 
cobj
�' 
leng
�& LTrhLTrR
�% LTrhLTrP
�$ LTrhLTrT
�# 
errt
�" 
enum�! �  "0 _makelistobject _makeListObject� $0 resultlistobject resultListObject� �������
� .ascrinit****      � ****� k     �� ��  �  �  � �� 
0 _list_  � �� 
0 _list_  � jv�� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ��
�
� 
erob�
 0 efrom eFrom� �	��
�	 
errt� 
0 eto eTo�  � � 
0 _error  �J���jv  jvY hO�kv��l j 
 ���l �j �& )�����Y hO��K S�O��,�k/�,E�O��  4 .��,[��l kh ��,� )����,�a Y h[OY��Y z�a   - '��,[��l kh ��,� 
��,E�Y h[OY��Y G�a   - '��,[��l kh ��,� 
��,E�Y h[OY��Y )���a a a a O*��,�,�l+ E�Oa a K S�O k�kkh ��-E��,6F[OY��O���,6FO =k��,�,Ekh  )k��,��/�,Ekh 	��,��/��/��,��/��/F[OY��[OY��O��,EW X  *a ����a + > �������
� .Lst:Map_null���     ****� 0 thelist theList� ��� 
� 
Usin� 0 	thescript 	theScript�   � 
���������������������� 0 thelist theList�� 0 	thescript 	theScript�� $0 resultlistobject resultListObject�� 0 i  �� 0 etext eText�� 0 enumber eNumber�� 
0 eto eTo�� 0 epartial ePartial�� 0 
listobject 
listObject�� 0 efrom eFrom� ������������������������������#������ $0 resultlistobject resultListObject� �����������
�� .ascrinit****      � ****� k     �� �����  ��  ��  � ���� 
0 _list_  � ��������� "0 aslistparameter asListParameter
�� 
cobj�� 
0 _list_  �� b  b   �l+ �-E��� &0 asscriptparameter asScriptParameter�� 
0 _list_  
�� 
leng
�� 
cobj�� 0 convertitem convertItem�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� ������
�� 
errt�� 
0 eto eTo��  
�� 
errn
�� 
erob
�� 
errt
�� 
ptlr�� � �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� �����
�� 
errt�� 
0 eto eTo� ������
�� 
ptlr�� 0 epartial ePartial��  �� �� 20 _errorwithpartialresult _errorWithPartialResult� � ���K S�Ob  ��l+ E�O + %k��,�,Ekh ���,�/k+ ��,�/F[OY��W CX 	 
�k ��,[�\[Zk\Z�k2E�Y jvE�O)���,E�/����a �%a %�%O��,EW X 	 *a �����a + ? ��5��������
�� .Lst:Filtnull���     ****�� 0 thelist theList�� ������
�� 
Usin�� 0 	thescript 	theScript��  � �������������������������� 0 thelist theList�� 0 	thescript 	theScript�� $0 resultlistobject resultListObject�� 0 	lastindex 	lastIndex�� 0 i  �� 0 theitem theItem�� 0 etext eText�� 0 enumber eNumber�� 
0 eto eTo�� 0 epartial ePartial�� 0 
listobject 
listObject�� 0 efrom eFrom� ��?�U��������������������������������� $0 resultlistobject resultListObject� �����������
�� .ascrinit****      � ****� k     �� ?����  ��  ��  � ���� 
0 _list_  � I�������� "0 aslistparameter asListParameter
�� 
cobj�� 
0 _list_  �� b  b   �l+ �-E��� &0 asscriptparameter asScriptParameter�� 
0 _list_  
�� 
leng
�� 
cobj�� 0 	checkitem 	checkItem�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� ������
�� 
errt�� 
0 eto eTo��  
�� 
errn
�� 
erob
�� 
errt
�� 
ptlr�� � �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� �����
�� 
errt�� 
0 eto eTo� ������
�� 
ptlr�� 0 epartial ePartial��  �� �� 20 _errorwithpartialresult _errorWithPartialResult�� � ���K S�Ob  ��l+ E�OjE�O = 7k��,�,Ekh ��,�/E�O��k+  �kE�O���,�/FY h[OY��W CX 	 
�k ��,[�\[Zk\Z�k2E�Y jvE�O)���,E�/����a �%a %�%O�j  jvY hO��,[�\[Zk\Z�2EW X 	 *a �����a + @ �����������
�� .Lst:Redunull���     ****�� 0 thelist theList�� ������
�� 
Usin�� 0 	thescript 	theScript��  � 
���������������������� 0 thelist theList�� 0 	thescript 	theScript�� 0 missingvalue missingValue�� 0 	theresult 	theResult�� 0 
listobject 
listObject�� 0 i  �� 0 etext eText�� 0 enumber eNumber�� 
0 eto eTo�� 0 efrom eFrom� ���������������� ����~�}��|�{QS�o�z�� 0 
listobject 
listObject� �y��x�w���v
�y .ascrinit****      � ****� k     �� ��u�u  �x  �w  � �t�t 
0 _list_  � �s�r�s "0 aslistparameter asListParameter�r 
0 _list_  �v b  b   �l+ ��� 
0 _list_  
�� 
leng
�� 
errn���Y
�� 
erob�� �� &0 asscriptparameter asScriptParameter
� 
cobj�~ 0 combineitems combineItems�} 0 etext eText� �q�p�
�q 
errn�p 0 enumber eNumber� �o�n�m
�o 
errt�n 
0 eto eTo�m  
�| 
errt�{ � �l�k�
�l 
errn�k 0 enumber eNumber� �j�i�
�j 
erob�i 0 efrom eFrom� �h�g�f
�h 
errt�g 
0 eto eTo�f  �z 20 _errorwithpartialresult _errorWithPartialResult�� ��E�O ���K S�O��,�,j  )���jv��Y hOb  ��l+ E�O��,�k/E�O ' !l��,�,Ekh ����,�/l+ E�[OY��W &X  )���,E�/a �a a �%a %�%O�W X  *a �����a + �> A �e��d�c���b�e 	0 _sort  �d �a��a �  �`�_�^�]�\�` $0 resultlistobject resultListObject�_ 0 	fromindex 	fromIndex�^ 0 toindex toIndex�]  0 sortcomparator sortComparator�\ 0 usequicksort useQuickSort�c  � �[�Z�Y�X�W�V�U�T�S�R�Q�P�O�N�M�L�[ $0 resultlistobject resultListObject�Z 0 	fromindex 	fromIndex�Y 0 toindex toIndex�X  0 sortcomparator sortComparator�W 0 usequicksort useQuickSort�V 0 	leftindex 	leftIndex�U 0 
rightindex 
rightIndex�T 0 
pivotvalue 
pivotValue�S 0 etext eText�R 0 enum eNum�Q 0 efrom eFrom�P 
0 eto eTo�O 0 i  �N 0 j  �M 0 leftkey leftKey�L 0 rightkey rightKey� �K�J�I�H�G��F�E�D�C>�B�A�@�?�
�K 
cobj�J 
0 _keys_  �I 0 comparekeys compareKeys
�H 
nmbr�G 0 etext eText� �>�=�
�> 
errn�= 0 enum eNum� �<�;�
�< 
erob�; 0 efrom eFrom� �:�9�8
�: 
errt�9 
0 eto eTo�8  
�F 
errn
�E 
erob
�D 
errt�C �B 
0 _list_  �A �@ 	0 _sort  �?  � �7�6�5
�7 
errn�6�n�5  �b�q��k hY hO��lvE[�k/E�Z[�l/E�ZO��,[�\[Z�\Z�2�.E�Oh�� % h���,�/E�l+ �&j�kE�[OY��W X  )���,�/�lv���%O $ h���,�/�l+ �&j�kE�[OY��W X  )���,�/�lv���%O�� p��,�/E��,�/ElvE[�k/��,�/FZ[�l/��,�/FZO��,�/E��,�/ElvE[�k/��,�/FZ[�l/��,�/FZO�k�klvE[�k/E�Z[�l/E�ZY h[OY�O -*������b  �+ O*������b  �+ OhW X  hY hO�kE�O ���kh  ���ih ��,�k/E��,�/ElvE[�k/E�Z[�l/E�ZO���l+ k Y hO��lvE[�k/��,�k/FZ[�l/��,�/FZO��,�/E��,�k/ElvE[�k/��,�k/FZ[�l/��,�/FZ[OY�y[OY�jB �4a�3�2���1
�4 .Lst:Sortnull���     ****�3 0 thelist theList�2 �0��/
�0 
Comp� {�.�-�,�. $0 comparatorobject comparatorObject�-  
�, 
msng�/  � �+�*�)�(�'�&�%�$�#�"�!� ������+ 0 thelist theList�* $0 comparatorobject comparatorObject�) $0 resultlistobject resultListObject�(  0 sortcomparator sortComparator�' 0 keymaker keyMaker�&  0 ascendingcount ascendingCount�% "0 descendingcount descendingCount�$ 0 previouskey previousKey�# 0 etext eText�" 0 enum eNum�! 
0 eto eTo�  0 i  � 0 
currentkey 
currentKey� 0 keycomparison keyComparison� 0 efrom eFrom� 0 usequicksort useQuickSort� 0 enumber eNumber�  |���������������������
�	;	=�	����	��� "0 aslistparameter asListParameter� $0 resultlistobject resultListObject� �������
� .ascrinit****      � ****� k     �� ��� ���  �  �  � � ���  
0 _keys_  �� 
0 _list_  � ������
�� 
cobj�� 
0 _keys_  �� 
0 _list_  � b   �-E�Ob   �-E�� 
0 _list_  
� 
leng
� 
msng
� .Lst:DeSonull��� ��� null� &0 asscriptparameter asScriptParameter� 0 makekey makeKey� 0 
hashandler 
hasHandler
� 
bool
� 
cobj� 
0 _keys_  � 0 etext eText� �����
�� 
errn�� 0 enum eNum� ������
�� 
errt�� 
0 eto eTo��  
� 
errn
� 
erob
� 
errt�
 �	 0 comparekeys compareKeys� �����
�� 
errn�� 0 enum eNum� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  � � 	0 _sort  � �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  � 
0 _error  �1��b  ��l+ E�O��K S�O��,�,l 
��,EY hO��  *j E�Y b  ��l+ 
E�O��	 b  ��,k+ �& �E�Y 	*j E�OjjlvE[�k/E�Z[�l/E�ZO � ���,�k/Ek+ E�W $X  )a �a ��,E�k/a �a a �%O���,�k/FO l��,�,Ekh  ���,�/k+ E�W *X  )a �a ��,E�/a �a a �%a %�%O���,�/FO���l+ E�O�j 
�kE�Y �j 
�kE�Y h[OY��W X  )a �a �a �a �O��,�,b  E�O*�k��,�,��a + O��,EW X  *a �] ��a + C ��	���������
�� .Lst:DeSonull��� ��� null��  ��  � ���� &0 defaultcomparator DefaultComparator� ��	���� &0 defaultcomparator DefaultComparator� �����������
�� .ascrinit****      � ****� k     �� 	��� 	��� 	��� 
@����  ��  ��  � ���������� "0 _supportedtypes _supportedTypes�� 	0 _type  �� 0 makekey makeKey�� 0 comparekeys compareKeys� ��������������
�� 
nmbr
�� 
ctxt
�� 
ldt �� "0 _supportedtypes _supportedTypes
�� 
msng�� 	0 _type  � ��	����������� 0 makekey makeKey�� ����� �  ���� 0 anobject anObject��  � ������ 0 anobject anObject�� 0 aref aRef� ��������������������

2
4��
9
�� 
msng�� "0 _supportedtypes _supportedTypes
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pcnt
�� 
errn���\
�� 
erob�� 
�� 
pcls�� ~b  �  F 7)�,[��l kh �kv��,El j ��,Ec  O�Y h[OY��O)�����Y .�kv�b  l j  )�����b  %�%��,%�%Y hO�� ��
B���������� 0 comparekeys compareKeys�� ����� �  ������ 0 
leftobject 
leftObject�� 0 rightobject rightObject��  � ������ 0 
leftobject 
leftObject�� 0 rightobject rightObject�  �� �� iY �� kY j�� ���mv�O�OL OL �� ��K S�D ��
\��������
�� .Lst:NuSonull��� ��� null��  ��  � ���� &0 numericcomparator NumericComparator� ��
]��� &0 numericcomparator NumericComparator� �����������
�� .ascrinit****      � ****� k     �� 
_�� 
h����  ��  ��  � ������ 0 makekey makeKey�� 0 comparekeys compareKeys� ��� ��
b���������� 0 makekey makeKey�� ����� �  ���� 0 anobject anObject��  � ���� 0 anobject anObject� ��
�� 
nmbr�� ��&� ��
j���������� 0 comparekeys compareKeys�� ����� �  ������ 0 
leftobject 
leftObject�� 0 rightobject rightObject��  � ������ 0 
leftobject 
leftObject�� 0 rightobject rightObject�  �� ���� L  OL �� ��K S�E ��
}��������
�� .Lst:DaSonull��� ��� null��  ��  � ����  0 datecomparator DateComparator� ��
~���  0 datecomparator DateComparator� �����������
�� .ascrinit****      � ****� k     �� 
��� 
���  ��  ��  � ��� 0 makekey makeKey� 0 comparekeys compareKeys� ��� �
������� 0 makekey makeKey� � �    �� 0 anobject anObject�  � �� 0 anobject anObject� �
� 
ldt � ��&� �
����� 0 comparekeys compareKeys� ��   ��~� 0 
leftobject 
leftObject�~ 0 rightobject rightObject�   �}�|�} 0 
leftobject 
leftObject�| 0 rightobject rightObject  � ���� L  OL �� ��K S�F �{
��z�y�x
�{ .Lst:TeSonull��� ��� null�z  �y �w�v
�w 
Cons {�u�t�s�u  0 orderingoption orderingOption�t  
�s SrtECmpI�v   �r�q�p�o�n�m�l�k�r  0 orderingoption orderingOption�q B0 currentconsiderationscomparator CurrentConsiderationsComparator�p >0 caseinsensitivetextcomparator CaseInsensitiveTextComparator�o :0 casesensitivetextcomparator CaseSensitiveTextComparator�n 0 etext eText�m 0 enumber eNumber�l 0 efrom eFrom�k 
0 eto eTo �j
��i�h
��g�f	�e�d�c�b�a�`�_%�^
6�]�\�j B0 currentconsiderationscomparator CurrentConsiderationsComparator �[�Z�Y�X
�[ .ascrinit****      � **** k      
� 
��W�W  �Z  �Y   �V�U�V 0 makekey makeKey�U 0 comparekeys compareKeys  �T
��S�R�Q�T 0 makekey makeKey�S �P�P   �O�O 0 anobject anObject�R   �N�N 0 anobject anObject �M
�M 
ctxt�Q ��& �L
��K�J�I�L 0 comparekeys compareKeys�K �H�H   �G�F�G 0 
leftobject 
leftObject�F 0 rightobject rightObject�J   �E�D�E 0 
leftobject 
leftObject�D 0 rightobject rightObject  �I �� iY �� kY j�X L  OL 
�i SrtECmpI�h >0 caseinsensitivetextcomparator CaseInsensitiveTextComparator �C�B�A�@
�C .ascrinit****      � **** k      
� 
��?�?  �B  �A   �>�=
�> 
pare�= 0 comparekeys compareKeys �<
�< 
pare �;
��:�9�8�; 0 comparekeys compareKeys�: �7 �7    �6�5�6 0 
leftobject 
leftObject�5 0 rightobject rightObject�9   �4�3�4 0 
leftobject 
leftObject�3 0 rightobject rightObject 
�
��2�2 0 comparekeys compareKeys�8 �� )��ld*J V�@ b  N  OL 
�g SrtECmpC�f :0 casesensitivetextcomparator CaseSensitiveTextComparator	 �1!�0�/"#�.
�1 .ascrinit****      � ****! k     $$ %% �-�-  �0  �/  " �,�+
�, 
pare�+ 0 comparekeys compareKeys# �*&
�* 
pare& �)	�(�''(�&�) 0 comparekeys compareKeys�( �%)�% )  �$�#�$ 0 
leftobject 
leftObject�# 0 rightobject rightObject�'  ' �"�!�" 0 
leftobject 
leftObject�! 0 rightobject rightObject( � �  0 comparekeys compareKeys�& �� )��ld*J V�. b  N  OL 
�e SrtECmpD
�d 
errn�c�Y
�b 
erob
�a 
errt
�` 
enum�_ �^ 0 etext eText
 ��*
� 
errn� 0 enumber eNumber* ��+
� 
erob� 0 efrom eFrom+ ���
� 
errt� 
0 eto eTo�  �] �\ 
0 _error  �x c N��K S�O��  ��K S�O�Y 0��  ��K 
S�O�Y ��  �Y )����a a a W X  *a ����a + G �G��,-�
� .Lst:LiSonull��� ��� null�  � �.�
� 
Comp. {���� "0 itemcomparators itemComparators�  
� 
msng�  , ����� "0 itemcomparators itemComparators�  0 sortcomparator sortComparator� .0 uniformlistcomparator UniformListComparator� *0 mixedlistcomparator MixedListComparator- ��
�	������l/�0
� 
kocl
�
 
list
�	 .corecnte****       ****
� 
msng� 0 makekey makeKey� 0 
hashandler 
hasHandler
� 
bool
� .Lst:DeSonull��� ��� null� .0 uniformlistcomparator UniformListComparator/ �1� ��23��
� .ascrinit****      � ****1 k     44 n55 	����  �   ��  2 ������ 0 makekey makeKey�� 0 comparekeys compareKeys3 676 ��q����89���� 0 makekey makeKey�� ��:�� :  ���� 0 sublist subList��  8 ������ 0 sublist subList�� ,0 uniformkeycomparator UniformKeyComparator9 ��w;�� ,0 uniformkeycomparator UniformKeyComparator; ��<����=>��
�� .ascrinit****      � ****< k     ?? y@@ |AA �����  ��  ��  = �������� 0 _cachedkeys _cachedKeys�� 0 getitem getItem�� 00 comparetokeycomparator compareToKeyComparator> ��BC�� 0 _cachedkeys _cachedKeysB ������DE���� 0 getitem getItem�� ��F�� F  ���� 0 atindex atIndex��  D ������ 0 atindex atIndex�� 0 i  E ��������
�� 
leng
�� 
msng
�� 
cobj�� 0 makekey makeKey�� N�b   �, �Y hO .b   �,k�kh b   b   �/k+ b   6F[OY��Ob   �/EC �������GH���� 00 comparetokeycomparator compareToKeyComparator�� ��I�� I  ���� (0 rightkeycomparator rightKeyComparator��  G ������������ (0 rightkeycomparator rightKeyComparator�� 0 i  �� 0 
leftobject 
leftObject�� 0 rightobject rightObject�� $0 comparisonresult comparisonResultH ����������
�� 
leng�� 0 getitem getItem
�� 
cobj
�� 
msng�� 0 comparekeys compareKeys�� s Zkb   �,Ekh )�k+ ��k+ lvE[�k/E�Z[�l/E�ZO��  kY hOb   ��l+ E�O�j �Y h[OY��O��kk+ �  jY hOi�� jv�OL OL �� ��K S�7 ������JK���� 0 comparekeys compareKeys�� ��L�� L  ������ &0 leftkeycomparator leftKeyComparator�� (0 rightkeycomparator rightKeyComparator��  J ������ &0 leftkeycomparator leftKeyComparator�� (0 rightkeycomparator rightKeyComparatorK ���� 00 comparetokeycomparator compareToKeyComparator�� ��k+  �� L  OL � *0 mixedlistcomparator MixedListComparator0 ��M����NO�
�� .ascrinit****      � ****M k     PP QQ ���  ��  ��  N ��� 0 makekey makeKey� 0 comparekeys compareKeysO RSR ���TU�� 0 makekey makeKey� �V� V  �� 0 sublist subList�  T ��� 0 sublist subList� ,0 uniformkeycomparator UniformKeyComparatorU �W� ,0 uniformkeycomparator UniformKeyComparatorW �X��YZ�
� .ascrinit****      � ****X k     [[ \\ "]] _��  �  �  Y ���� 0 _cachedkeys _cachedKeys� 0 getitem getItem� 00 comparetokeycomparator compareToKeyComparatorZ �^_� 0 _cachedkeys _cachedKeys^ �%��`a�� 0 getitem getItem� �b� b  �� 0 atindex atIndex�  ` ���� 0 atindex atIndex� 0 i  � (0 listitemcomparator listItemComparatora ������
� 
leng
� 
msng
� 
cobj�  0 itemcomparator itemComparator� 0 	itemindex 	itemIndex� 0 makekey makeKey� Z�b   �, �Y hO :b   �,k�kh b   �/E�O��,b   ��,E/k+ b   6F[OY��Ob   �/E_ �a��cd�� 00 comparetokeycomparator compareToKeyComparator� �e� e  �� (0 rightkeycomparator rightKeyComparator�  c ������ (0 rightkeycomparator rightKeyComparator� 0 i  � 0 
leftobject 
leftObject� 0 rightobject rightObject� $0 comparisonresult comparisonResultd ������
� 
leng� 0 getitem getItem
� 
cobj
� 
msng�  0 itemcomparator itemComparator� 0 comparekeys compareKeys� x _kb   �,Ekh )�k+ ��k+ lvE[�k/E�Z[�l/E�ZO��  kY hOb   �/�,��l+ E�O�j �Y h[OY��O��kk+ �  jY hOi� jv�OL OL � ��K S�S ����fg�� 0 comparekeys compareKeys� �h� h  ��� &0 leftkeycomparator leftKeyComparator� (0 rightkeycomparator rightKeyComparator�  f ��� &0 leftkeycomparator leftKeyComparator� (0 rightkeycomparator rightKeyComparatorg �� 00 comparetokeycomparator compareToKeyComparator� ��k+  � L  OL � E�kv��l j  1�� 
 b  ��,k+ �& *j E�Y hO��K 
S�Y 	��K S�H ���~�}ij�|
� .Lst:LiUSnull���     ****�~ 0 thelist theList�}  i 	�{�z�y�x�w�v�u�t�s�{ 0 thelist theList�z $0 resultlistobject resultListObject�y 0 len  �x 0 idx1  �w 0 idx2  �v 0 etext eText�u 0 enumber eNumber�t 0 efrom eFrom�s 
0 eto eToj �r�k�q�p�o�n�m�l�k�j�il(�h�g�r $0 resultlistobject resultListObjectk �fm�e�dno�c
�f .ascrinit****      � ****m k     pp ��b�b  �e  �d  n �a�a 
0 _list_  o ��`�_�^�` "0 aslistparameter asListParameter
�_ 
cobj�^ 
0 _list_  �c b  b   �l+ �-E��q 
0 _list_  
�p 
leng
�o misccura
�n 
from
�m 
to  �l 
�k .sysorandnmbr    ��� nmbr
�j 
cobj�i 0 etext eTextl �]�\q
�] 
errn�\ 0 enumber eNumberq �[�Zr
�[ 
erob�Z 0 efrom eFromr �Y�X�W
�Y 
errt�X 
0 eto eTo�W  �h �g 
0 _error  �| u d��K S�O��,�,E�O Hk�kh � *�k�� 	UE�O��,�/E��,�/ElvE[�k/��,�/FZ[�l/��,�/FZ[OY��O��,EW X  *������+ ascr  ��ޭ