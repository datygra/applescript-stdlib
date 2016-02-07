FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� Web -- commands for manipulating URLs and sending HTTP requests

TO DO:

- `normalize URL`? see NSURL's standardizedURL()

- `split URL query`, `join URL query` -- {{"foo", "xyz"}, {"bar", 123}} <-> "foo=xyz&bar=123"; note that this should work for both URL query strings and 'application/x-www-form-urlencoded' HTTP body data; e.g. see Python's [horribly named]:

	urllib.parse.parse_qsl(qs, keep_blank_values=False, strict_parsing=False, encoding='utf-8', errors='replace')
	urllib.parse.urlencode(query, doseq=False, safe='', encoding=None, errors=None)


- `escape URL`, `unescape URL` -- see:
	
	
	and in Python:

	 urllib.parse.quote(string, safe='/', encoding=None, errors=None)
	 urllib.parse.quote_plus(string, safe='', encoding=None, errors=None) -- note: `form quoting` should be a boolean option to `escape URL`, indicating whether or not spaces should be escaped as '+' (and '+' as '%NN', and use "" instead of "/" as default `safe` chars)
	 urllib.parse.unquote(string, encoding='utf-8', errors='replace') -- e.g. unquote('/El%20Ni%C3%B1o/') yields '/El Ni�o/'
	 urllib.parse.unquote_plus(string, encoding='utf-8', errors='replace') -- again, include `form quoting` boolean option



- `send HTTP request` -- urllib.request.Request(url, data=None, headers={}, origin_req_host=None, unverifiable=False, method=None) [method=GET/POST/PUT/etc]; see NSURLSession, NSURLRequest, NSURLResponse

	- Q. what API? e.g. should command simply block until completion or timeout? (an async API would probably be overkill, not to mention difficult, for most AS users; any users that do need more advanced features can always drop down into Cocoa via ASOC)

	- Q. need to give some thought to encodings in HTTP body data: simplest might be for body to be either `text` or `data`, and leave encoding/decoding to TextLib (which currently doesn't support this, but could be made to); Q. what AE type to assign to data objects: cRawData ('rdat'), or something more specific?

     � 	 	h   W e b   - -   c o m m a n d s   f o r   m a n i p u l a t i n g   U R L s   a n d   s e n d i n g   H T T P   r e q u e s t s 
 
 T O   D O : 
 
 -   ` n o r m a l i z e   U R L ` ?   s e e   N S U R L ' s   s t a n d a r d i z e d U R L ( ) 
 
 -   ` s p l i t   U R L   q u e r y ` ,   ` j o i n   U R L   q u e r y `   - -   { { " f o o " ,   " x y z " } ,   { " b a r " ,   1 2 3 } }   < - >   " f o o = x y z & b a r = 1 2 3 " ;   n o t e   t h a t   t h i s   s h o u l d   w o r k   f o r   b o t h   U R L   q u e r y   s t r i n g s   a n d   ' a p p l i c a t i o n / x - w w w - f o r m - u r l e n c o d e d '   H T T P   b o d y   d a t a ;   e . g .   s e e   P y t h o n ' s   [ h o r r i b l y   n a m e d ] : 
 
 	 u r l l i b . p a r s e . p a r s e _ q s l ( q s ,   k e e p _ b l a n k _ v a l u e s = F a l s e ,   s t r i c t _ p a r s i n g = F a l s e ,   e n c o d i n g = ' u t f - 8 ' ,   e r r o r s = ' r e p l a c e ' ) 
 	 u r l l i b . p a r s e . u r l e n c o d e ( q u e r y ,   d o s e q = F a l s e ,   s a f e = ' ' ,   e n c o d i n g = N o n e ,   e r r o r s = N o n e ) 
 
 
 -   ` e s c a p e   U R L ` ,   ` u n e s c a p e   U R L `   - -   s e e : 
 	 
 	 
 	 a n d   i n   P y t h o n : 
 
 	   u r l l i b . p a r s e . q u o t e ( s t r i n g ,   s a f e = ' / ' ,   e n c o d i n g = N o n e ,   e r r o r s = N o n e ) 
 	   u r l l i b . p a r s e . q u o t e _ p l u s ( s t r i n g ,   s a f e = ' ' ,   e n c o d i n g = N o n e ,   e r r o r s = N o n e )   - -   n o t e :   ` f o r m   q u o t i n g `   s h o u l d   b e   a   b o o l e a n   o p t i o n   t o   ` e s c a p e   U R L ` ,   i n d i c a t i n g   w h e t h e r   o r   n o t   s p a c e s   s h o u l d   b e   e s c a p e d   a s   ' + '   ( a n d   ' + '   a s   ' % N N ' ,   a n d   u s e   " "   i n s t e a d   o f   " / "   a s   d e f a u l t   ` s a f e `   c h a r s ) 
 	   u r l l i b . p a r s e . u n q u o t e ( s t r i n g ,   e n c o d i n g = ' u t f - 8 ' ,   e r r o r s = ' r e p l a c e ' )   - -   e . g .   u n q u o t e ( ' / E l % 2 0 N i % C 3 % B 1 o / ' )   y i e l d s   ' / E l   N i � o / ' 
 	   u r l l i b . p a r s e . u n q u o t e _ p l u s ( s t r i n g ,   e n c o d i n g = ' u t f - 8 ' ,   e r r o r s = ' r e p l a c e ' )   - -   a g a i n ,   i n c l u d e   ` f o r m   q u o t i n g `   b o o l e a n   o p t i o n 
 
 
 
 -   ` s e n d   H T T P   r e q u e s t `   - -   u r l l i b . r e q u e s t . R e q u e s t ( u r l ,   d a t a = N o n e ,   h e a d e r s = { } ,   o r i g i n _ r e q _ h o s t = N o n e ,   u n v e r i f i a b l e = F a l s e ,   m e t h o d = N o n e )   [ m e t h o d = G E T / P O S T / P U T / e t c ] ;   s e e   N S U R L S e s s i o n ,   N S U R L R e q u e s t ,   N S U R L R e s p o n s e 
 
 	 -   Q .   w h a t   A P I ?   e . g .   s h o u l d   c o m m a n d   s i m p l y   b l o c k   u n t i l   c o m p l e t i o n   o r   t i m e o u t ?   ( a n   a s y n c   A P I   w o u l d   p r o b a b l y   b e   o v e r k i l l ,   n o t   t o   m e n t i o n   d i f f i c u l t ,   f o r   m o s t   A S   u s e r s ;   a n y   u s e r s   t h a t   d o   n e e d   m o r e   a d v a n c e d   f e a t u r e s   c a n   a l w a y s   d r o p   d o w n   i n t o   C o c o a   v i a   A S O C ) 
 
 	 -   Q .   n e e d   t o   g i v e   s o m e   t h o u g h t   t o   e n c o d i n g s   i n   H T T P   b o d y   d a t a :   s i m p l e s t   m i g h t   b e   f o r   b o d y   t o   b e   e i t h e r   ` t e x t `   o r   ` d a t a ` ,   a n d   l e a v e   e n c o d i n g / d e c o d i n g   t o   T e x t L i b   ( w h i c h   c u r r e n t l y   d o e s n ' t   s u p p o r t   t h i s ,   b u t   c o u l d   b e   m a d e   t o ) ;   Q .   w h a t   A E   t y p e   t o   a s s i g n   t o   d a t a   o b j e c t s :   c R a w D a t a   ( ' r d a t ' ) ,   o r   s o m e t h i n g   m o r e   s p e c i f i c ? 
 
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      support     �      s u p p o r t     !   l     ��������  ��  ��   !  " # " l      $ % & $ j    �� '�� 0 _support   ' N     ( ( 4    �� )
�� 
scpt ) m     * * � + +  T y p e S u p p o r t % "  used for parameter checking    & � , , 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g #  - . - l     ��������  ��  ��   .  / 0 / l     ��������  ��  ��   0  1 2 1 i    3 4 3 I      �� 5���� 
0 _error   5  6 7 6 o      ���� 0 handlername handlerName 7  8 9 8 o      ���� 0 etext eText 9  : ; : o      ���� 0 enumber eNumber ;  < = < o      ���� 0 efrom eFrom =  >�� > o      ���� 
0 eto eTo��  ��   4 n     ? @ ? I    �� A���� &0 throwcommanderror throwCommandError A  B C B m     D D � E E  W e b C  F G F o    ���� 0 handlername handlerName G  H I H o    ���� 0 etext eText I  J K J o    	���� 0 enumber eNumber K  L M L o   	 
���� 0 efrom eFrom M  N�� N o   
 ���� 
0 eto eTo��  ��   @ o     ���� 0 _support   2  O P O l     ��������  ��  ��   P  Q R Q l     ��������  ��  ��   R  S T S l     �� U V��   U J D--------------------------------------------------------------------    V � W W � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - T  X Y X l     �� Z [��   Z   URL conversion    [ � \ \    U R L   c o n v e r s i o n Y  ] ^ ] l     ��������  ��  ��   ^  _ ` _ i    a b a I      �� c���� $0 asnsurlparameter asNSURLParameter c  d e d o      ���� 0 urltext urlText e  f�� f o      ���� 0 parametername parameterName��  ��   b k     / g g  h i h r      j k j n     l m l I    �������� "0 standardizedurl standardizedURL��  ��   m l     n���� n n     o p o I    �� q����  0 urlwithstring_ URLWithString_ q  r�� r l    s���� s n    t u t I    �� v���� "0 astextparameter asTextParameter v  w x w o    	���� 0 urltext urlText x  y�� y o   	 
���� 0 parametername parameterName��  ��   u o    ���� 0 _support  ��  ��  ��  ��   p n     z { z o    ���� 0 nsurl NSURL { m     ��
�� misccura��  ��   k o      ���� 0 asocurl asocURL i  | } | Z   , ~ ���� ~ =    � � � o    ���� 0 asocurl asocURL � m    ��
�� 
msng  I    (�� ����� .0 throwinvalidparameter throwInvalidParameter �  � � � o     !���� 0 urltext urlText �  � � � o   ! "���� 0 parametername parameterName �  � � � m   " #��
�� 
ctxt �  ��� � m   # $ � � � � � 6 N o t   a   v a l i d   ( R F C   1 8 0 8 )   U R L .��  ��  ��  ��   }  ��� � L   - / � � o   - .���� 0 urltext urlText��   `  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i    � � � I     �� ���
�� .Web:SplUnull���     ctxt � o      ���� 0 urltext urlText��   � Q     x � � � � k    b � �  � � � r     � � � n    � � � I    �� ����� $0 asnsurlparameter asNSURLParameter �  � � � o    	���� 0 urltext urlText �  ��� � m   	 
 � � � � �  ��  ��   � o    ���� 0 _support   � o      ���� 0 asocurl asocURL �  ��� � l   b � � � � L    b � � K    a � � �� � ��� 0 	urlscheme 	urlScheme � c     � � � n    � � � I    �������� 
0 scheme  ��  ��   � o    ���� 0 asocurl asocURL � m    ��
�� 
**** � �� � ��� 0 username userName � c    ! � � � n    � � � I    �������� 0 user  ��  ��   � o    ���� 0 asocurl asocURL � m     ��
�� 
**** � �� � ��� 0 userpassword userPassword � c   " ) � � � n  " ' � � � I   # '�������� 0 password  ��  ��   � o   " #���� 0 asocurl asocURL � m   ' (��
�� 
**** � � � �� 0 hostname hostName � c   * 1 � � � n  * / � � � I   + /�~�}�|�~ 0 host  �}  �|   � o   * +�{�{ 0 asocurl asocURL � m   / 0�z
�z 
**** � �y � ��y 0 
portnumber 
portNumber � c   2 9 � � � n  2 7 � � � I   3 7�x�w�v�x 0 port  �w  �v   � o   2 3�u�u 0 asocurl asocURL � m   7 8�t
�t 
**** � �s � ��s 0 resourcepath resourcePath � c   : A � � � n  : ? � � � I   ; ?�r�q�p�r 0 path  �q  �p   � o   : ;�o�o 0 asocurl asocURL � m   ? @�n
�n 
**** � �m � ��m "0 parameterstring parameterString � c   B I � � � n  B G � � � I   C G�l�k�j�l "0 parameterstring parameterString�k  �j   � o   B C�i�i 0 asocurl asocURL � m   G H�h
�h 
**** � �g � ��g 0 querystring queryString � c   L S � � � n  L Q � � � I   M Q�f�e�d�f 	0 query  �e  �d   � o   L M�c�c 0 asocurl asocURL � m   Q R�b
�b 
**** � �a ��`�a (0 fragmentidentifier fragmentIdentifier � c   V ] � � � n  V [ � � � I   W [�_�^�]�_ 0 fragment  �^  �]   � o   V W�\�\ 0 asocurl asocURL � m   [ \�[
�[ 
****�`   � E ? TO DO: use empty text rather than missing value where omitted?    � � � � ~   T O   D O :   u s e   e m p t y   t e x t   r a t h e r   t h a n   m i s s i n g   v a l u e   w h e r e   o m i t t e d ?��   � R      �Z � �
�Z .ascrerr ****      � **** � o      �Y�Y 0 etext eText � �X � �
�X 
errn � o      �W�W 0 enumber eNumber � �V � �
�V 
erob � o      �U�U 0 efrom eFrom � �T ��S
�T 
errt � o      �R�R 
0 eto eTo�S   � I   j x�Q ��P�Q 
0 _error   �  � � � m   k n � � � � �  s p l i t   U R L �  � � � o   n o�O�O 0 etext eText �  � � � o   o p�N�N 0 enumber eNumber �  � � � o   p q�M�M 0 efrom eFrom �  ��L � o   q r�K�K 
0 eto eTo�L  �P   �  � � � l     �J�I�H�J  �I  �H   �  � � � l     �G�F�E�G  �F  �E   �  � � � l     ��D�C � I    �B ��A
�B .Web:SplUnull���     ctxt � m        � � h t t p : / / u s e r n a m e : p a s s w o r d @ w w w . e x a m p l e . c o m : 8 0 / i n d e x . h t m l ; f o o ? k e y 1 = v a l u e 1 & k e y 2 = v a l u e 2 # x y z�A  �D  �C   �  l   �@�? I   �>�=
�> .Web:SplUnull���     ctxt m     �  w w w . e x a m p l e . c o m�=  �@  �?   	 l     �<�;�:�<  �;  �:  	 

 l     �9�8�7�9  �8  �7    i   ! I     �6
�6 .Web:JoiUnull���     **** o      �5�5 0 	urlrecord 	urlRecord �4�3
�4 
Base |�2�1�0�2  �1   o      �/�/ 0 baseurl baseURL�0   l     �.�- m       �  �.  �-  �3   l    V Q     V k    @   r    0!"! n   .#$# I    .�,%�+�, 60 asoptionalrecordparameter asOptionalRecordParameter% &'& o    	�*�* 0 	urlrecord 	urlRecord' ()( K   	 )** �)+,�) 0 	urlscheme 	urlScheme+ n  
 -.- o    �(�( 0 requiredvalue RequiredValue. o   
 �'�' 0 _support  , �&/0�& 0 username userName/ m    �%
�% 
msng0 �$12�$ 0 userpassword userPassword1 m    �#
�# 
msng2 �"34�" 0 hostname hostName3 n   565 o    �!�! 0 requiredvalue RequiredValue6 o    � �  0 _support  4 �78� 0 
portnumber 
portNumber7 m    �
� 
msng8 �9:� 0 resourcepath resourcePath9 m     !�
� 
msng: �;<� "0 parameterstring parameterString; m   " #�
� 
msng< �=>� 0 querystring queryString= m   $ %�
� 
msng> �?�� (0 fragmentidentifier fragmentIdentifier? m   & '�
� 
msng�  ) @�@ m   ) *AA �BB  �  �+  $ o    �� 0 _support  " o      �� 0 	urlrecord 	urlRecord  CDC r   1 >EFE n  1 <GHG I   6 <�I�� $0 asnsurlparameter asNSURLParameterI JKJ o   6 7�� 0 baseurl baseURLK L�L m   7 8MM �NN  u s i n g   b a s e   U R L�  �  H o   1 6�� 0 _support  F o      �� 0 baseurl baseURLD O�O l  ? ?�
�	��
  �	  �  �   R      �PQ
� .ascrerr ****      � ****P o      �� 0 etext eTextQ �RS
� 
errnR o      �� 0 enumber eNumberS �TU
� 
erobT o      �� 0 efrom eFromU �V� 
� 
errtV o      ���� 
0 eto eTo�    I   H V��W���� 
0 _error  W XYX m   I LZZ �[[  j o i n   U R LY \]\ o   L M���� 0 etext eText] ^_^ o   M N���� 0 enumber eNumber_ `a` o   N O���� 0 efrom eFroma b��b o   O P���� 
0 eto eTo��  ��   y s TO DO: also allow urlRecord to be text path? (Q. would that substitute or append to any existing path in baseURL?)    �cc �   T O   D O :   a l s o   a l l o w   u r l R e c o r d   t o   b e   t e x t   p a t h ?   ( Q .   w o u l d   t h a t   s u b s t i t u t e   o r   a p p e n d   t o   a n y   e x i s t i n g   p a t h   i n   b a s e U R L ? ) ded l     ��������  ��  ��  e fgf l     ��������  ��  ��  g hih l     ��jk��  j  -----   k �ll 
 - - - - -i mnm l     ��op��  o 7 1 encode/decode '%XX' escapes (UTF8 encoding only)   p �qq b   e n c o d e / d e c o d e   ' % X X '   e s c a p e s   ( U T F 8   e n c o d i n g   o n l y )n rsr l     ��������  ��  ��  s tut l     ��vw��  v > 8 TO DO: boolean param for encoding/decoding space as '+'   w �xx p   T O   D O :   b o o l e a n   p a r a m   f o r   e n c o d i n g / d e c o d i n g   s p a c e   a s   ' + 'u yzy l     ��������  ��  ��  z {|{ i  " %}~} I     ���
�� .Web:EscUnull���     ctxt o      ���� 0 thetext theText� �����
�� 
Safe� |����������  ��  � o      ���� &0 allowedcharacters allowedCharacters��  � l     ������ m      �� ���  /��  ��  ��  ~ Q     ^���� k    H�� ��� r    ��� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    	���� 0 thetext theText� ���� m   	 
�� ���  ��  ��  � o    ���� 0 _support  � o      ���� 0 thetext theText� ��� r    ��� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    ���� &0 allowedcharacters allowedCharacters� ���� m    �� ���  p r e s e r v i n g��  ��  � o    ���� 0 _support  � o      ���� &0 allowedcharacters allowedCharacters� ��� l   ������  ��� Returns a new string made from the receiver by replacing all characters not in the allowedCharacters set with percent encoded characters. UTF-8 encoding is used to determine the correct percent encoded characters. Entire URL strings cannot be percent-encoded. This method is intended to percent-encode an URL component or subcomponent string, NOT the entire URL string. Any characters in allowedCharacters outside of the 7-bit ASCII range are ignored.   � ����   R e t u r n s   a   n e w   s t r i n g   m a d e   f r o m   t h e   r e c e i v e r   b y   r e p l a c i n g   a l l   c h a r a c t e r s   n o t   i n   t h e   a l l o w e d C h a r a c t e r s   s e t   w i t h   p e r c e n t   e n c o d e d   c h a r a c t e r s .   U T F - 8   e n c o d i n g   i s   u s e d   t o   d e t e r m i n e   t h e   c o r r e c t   p e r c e n t   e n c o d e d   c h a r a c t e r s .   E n t i r e   U R L   s t r i n g s   c a n n o t   b e   p e r c e n t - e n c o d e d .   T h i s   m e t h o d   i s   i n t e n d e d   t o   p e r c e n t - e n c o d e   a n   U R L   c o m p o n e n t   o r   s u b c o m p o n e n t   s t r i n g ,   N O T   t h e   e n t i r e   U R L   s t r i n g .   A n y   c h a r a c t e r s   i n   a l l o w e d C h a r a c t e r s   o u t s i d e   o f   t h e   7 - b i t   A S C I I   r a n g e   a r e   i g n o r e d .� ��� r    5��� n   3��� I   ' 3������� j0 3stringbyaddingpercentencodingwithallowedcharacters_ 3stringByAddingPercentEncodingWithAllowedCharacters_� ���� l  ' /������ n  ' /��� I   * /������� J0 #charactersetwithcharactersinstring_ #characterSetWithCharactersInString_� ���� o   * +���� &0 allowedcharacters allowedCharacters��  ��  � n  ' *��� o   ( *����  0 nscharacterset NSCharacterSet� m   ' (��
�� misccura��  ��  ��  ��  � l   '������ n   '��� I   " '������� &0 stringwithstring_ stringWithString_� ���� o   " #���� 0 thetext theText��  ��  � n   "��� o     "���� 0 nsstring NSString� m     ��
�� misccura��  ��  � o      ���� 0 
asocresult 
asocResult� ���� l  6 H���� Z  6 H������� =  6 9��� o   6 7���� 0 
asocresult 
asocResult� m   7 8��
�� 
msng� R   < D����
�� .ascrerr ****      � ****� m   B C�� ��� ^ C o u l d n ' t   c o n v e r t   c h a r a c t e r s   t o   p e r c e n t   e s c a p e s .� ����
�� 
errn� m   > ?�����Y� �����
�� 
erob� o   @ A���� 0 thetext theText��  ��  ��  � , & NSString docs are hopeless on details   � ��� L   N S S t r i n g   d o c s   a r e   h o p e l e s s   o n   d e t a i l s��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I   P ^������� 
0 _error  � ��� m   Q T�� ��� * e s c a p e   U R L   c h a r a c t e r s� ��� o   T U���� 0 etext eText� ��� o   U V���� 0 enumber eNumber� ��� o   V W���� 0 efrom eFrom� ���� o   W X���� 
0 eto eTo��  ��  | ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  & )��� I     �����
�� .Web:UneUnull���     ctxt� o      ���� 0 thetext theText��  � Q     K���� k    7�� ��� r    ��� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    	���� 0 thetext theText� ���� m   	 
�� ���  ��  ��  � o    ���� 0 _support  � o      ���� 0 thetext theText� ��� l   ��������  ��  ��  � ��� l   ������  � � � Returns a new string made from the receiver by replacing all percent encoded sequences with the matching UTF-8 characters. (NSURLUtilites, 10.9+)   � �  $   R e t u r n s   a   n e w   s t r i n g   m a d e   f r o m   t h e   r e c e i v e r   b y   r e p l a c i n g   a l l   p e r c e n t   e n c o d e d   s e q u e n c e s   w i t h   t h e   m a t c h i n g   U T F - 8   c h a r a c t e r s .   ( N S U R L U t i l i t e s ,   1 0 . 9 + )�  r     n    I    �������� B0 stringbyremovingpercentencoding stringByRemovingPercentEncoding��  ��   l   ���� n   	 I    ��
���� &0 stringwithstring_ stringWithString_
 �� o    ���� 0 thetext theText��  ��  	 n    o    ���� 0 nsstring NSString m    ��
�� misccura��  ��   o      ���� 0 
asocresult 
asocResult  Z    2���� =    # o     !���� 0 
asocresult 
asocResult m   ! "��
�� 
msng R   & .�
� .ascrerr ****      � **** m   , - � n C o u l d n ' t   c o n v e r t   p e r c e n t   e s c a p e s   ( e . g .   n o t   v a l i d   U T F 8 ) . �~
�~ 
errn m   ( )�}�}�Y �|�{
�| 
erob o   * +�z�z 0 thetext theText�{  ��  ��   �y L   3 7 c   3 6 o   3 4�x�x 0 
asocresult 
asocResult m   4 5�w
�w 
ctxt�y  � R      �v 
�v .ascrerr ****      � **** o      �u�u 0 etext eText  �t!"
�t 
errn! o      �s�s 0 enumber eNumber" �r#$
�r 
erob# o      �q�q 0 efrom eFrom$ �p%�o
�p 
errt% o      �n�n 
0 eto eTo�o  � I   ? K�m&�l�m 
0 _error  & '(' m   @ A)) �** . u n e s c a p e   U R L   c h a r a c t e r s( +,+ o   A B�k�k 0 etext eText, -.- o   B C�j�j 0 enumber eNumber. /0/ o   C D�i�i 0 efrom eFrom0 1�h1 o   D E�g�g 
0 eto eTo�h  �l  � 232 l     �f�e�d�f  �e  �d  3 454 l     �c�b�a�c  �b  �a  5 676 l     �`89�`  8  -----   9 �:: 
 - - - - -7 ;<; l     �_=>�_  = + % parse/format "key=value&..." strings   > �?? J   p a r s e / f o r m a t   " k e y = v a l u e & . . . "   s t r i n g s< @A@ l     �^�]�\�^  �]  �\  A BCB l     �[DE�[  D � � note: these names overlap `split url`, but as long as `query string` doesn't get defined as a keyword anywhere (ensuring the word `query` can't be mistaken for an identifier) there shouldn't be any ambiguity   E �FF�   n o t e :   t h e s e   n a m e s   o v e r l a p   ` s p l i t   u r l ` ,   b u t   a s   l o n g   a s   ` q u e r y   s t r i n g `   d o e s n ' t   g e t   d e f i n e d   a s   a   k e y w o r d   a n y w h e r e   ( e n s u r i n g   t h e   w o r d   ` q u e r y `   c a n ' t   b e   m i s t a k e n   f o r   a n   i d e n t i f i e r )   t h e r e   s h o u l d n ' t   b e   a n y   a m b i g u i t yC GHG l     �Z�Y�X�Z  �Y  �X  H IJI l     �WKL�W  K M G note: these should probably do '%xx' escaping/unescaping automatically   L �MM �   n o t e :   t h e s e   s h o u l d   p r o b a b l y   d o   ' % x x '   e s c a p i n g / u n e s c a p i n g   a u t o m a t i c a l l yJ NON l     �V�U�T�V  �U  �T  O PQP i  * -RSR I     �ST�R
�S .Web:SplQnull���     ctxtT o      �Q�Q 0 	querytext 	queryText�R  S Q     $UVWU k    XX YZY r    [\[ n   ]^] I    �P_�O�P "0 astextparameter asTextParameter_ `a` o    	�N�N 0 	querytext 	queryTexta b�Mb m   	 
cc �dd  �M  �O  ^ o    �L�L 0 _support  \ o      �K�K 0 	querytext 	queryTextZ e�Je l   �I�H�G�I  �H  �G  �J  V R      �Ffg
�F .ascrerr ****      � ****f o      �E�E 0 etext eTextg �Dhi
�D 
errnh o      �C�C 0 enumber eNumberi �Bjk
�B 
erobj o      �A�A 0 efrom eFromk �@l�?
�@ 
errtl o      �>�> 
0 eto eTo�?  W I    $�=m�<�= 
0 _error  m non m    pp �qq $ s p l i t   q u e r y   s t r i n go rsr o    �;�; 0 etext eTexts tut o    �:�: 0 enumber eNumberu vwv o    �9�9 0 efrom eFromw x�8x o     �7�7 
0 eto eTo�8  �<  Q yzy l     �6�5�4�6  �5  �4  z {|{ l     �3�2�1�3  �2  �1  | }~} i  . 1� I     �0��/
�0 .Web:JoiQnull���     ctxt� o      �.�. 0 	querylist 	queryList�/  � l    $���� Q     $���� k    �� ��� r    ��� n   ��� I    �-��,�- "0 aslistparameter asListParameter� ��� o    	�+�+ 0 	querylist 	queryList� ��*� m   	 
�� ���  �*  �,  � o    �)�) 0 _support  � o      �(�( 0 	querylist 	queryList� ��'� l   �&�%�$�&  �%  �$  �'  � R      �#��
�# .ascrerr ****      � ****� o      �"�" 0 etext eText� �!��
�! 
errn� o      � �  0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  � I    $���� 
0 _error  � ��� m    �� ��� " j o i n   q u e r y   s t r i n g� ��� o    �� 0 etext eText� ��� o    �� 0 enumber eNumber� ��� o    �� 0 efrom eFrom� ��� o     �� 
0 eto eTo�  �  �GA list of form: {{keyText,aValue},...} -- TO DO: what types should be allowed for values? numeric values will need to be converted to canonical text not sure how `true` and `false` should be treated; dates should either convert to ISO8601 or be rejected; should `missing value` indicate no value or just use empty text ""?   � ����   l i s t   o f   f o r m :   { { k e y T e x t , a V a l u e } , . . . }   - -   T O   D O :   w h a t   t y p e s   s h o u l d   b e   a l l o w e d   f o r   v a l u e s ?   n u m e r i c   v a l u e s   w i l l   n e e d   t o   b e   c o n v e r t e d   t o   c a n o n i c a l   t e x t   n o t   s u r e   h o w   ` t r u e `   a n d   ` f a l s e `   s h o u l d   b e   t r e a t e d ;   d a t e s   s h o u l d   e i t h e r   c o n v e r t   t o   I S O 8 6 0 1   o r   b e   r e j e c t e d ;   s h o u l d   ` m i s s i n g   v a l u e `   i n d i c a t e   n o   v a l u e   o r   j u s t   u s e   e m p t y   t e x t   " " ?~ ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l     ����  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ����  �   JSON conversion   � ���     J S O N   c o n v e r s i o n� ��� l     ��
�	�  �
  �	  � ��� i  2 5��� I     ���
� .Web:FJSNnull���     ****� o      �� 0 
jsonobject 
jsonObject� ���
� 
EWSp� |������  �  � o      �� "0 isprettyprinted isPrettyPrinted�  � l     �� ��� m      ��
�� boovfals�   ��  �  � Q     ����� k    ��� ��� Z    ������ n   ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    	���� "0 isprettyprinted isPrettyPrinted� ���� m   	 
�� ��� " e x t r a   w h i t e   s p a c e��  ��  � o    ���� 0 _support  � r    ��� n   ��� o    ���� 80 nsjsonwritingprettyprinted NSJSONWritingPrettyPrinted� m    ��
�� misccura� o      ���� 0 writeoptions writeOptions��  � r    ��� m    ����  � o      ���� 0 writeoptions writeOptions� ��� Z    5������� H    &�� l   %������ n   %��� I     %������� (0 isvalidjsonobject_ isValidJSONObject_� ���� o     !���� 0 
jsonobject 
jsonObject��  ��  � n    ��� o     ���� *0 nsjsonserialization NSJSONSerialization� m    ��
�� misccura��  ��  � R   ) 1����
�� .ascrerr ****      � ****� m   / 0�� ��� z C a n  t   c o n v e r t   o b j e c t   t o   J S O N   ( f o u n d   u n s u p p o r t e d   o b j e c t   t y p e ) .� ����
�� 
errn� m   + ,�����Y� �����
�� 
erob� o   - .���� 0 
jsonobject 
jsonObject��  ��  ��  � ��� r   6 O��� n  6 @��� I   9 @������� F0 !datawithjsonobject_options_error_ !dataWithJSONObject_options_error_� ��� o   9 :���� 0 
jsonobject 
jsonObject� ��� o   : ;���� 0 writeoptions writeOptions� ���� l  ; <������ m   ; <��
�� 
obj ��  ��  ��  ��  � n  6 9��� o   7 9���� *0 nsjsonserialization NSJSONSerialization� m   6 7��
�� misccura� J      �� ��� o      ���� 0 thedata theData�  ��  o      ���� 0 theerror theError��  �  Z  P l���� =  P S o   P Q���� 0 thedata theData m   Q R��
�� 
msng R   V h��
�� .ascrerr ****      � **** b   \ g	
	 b   \ c m   \ ] � : C a n  t   c o n v e r t   o b j e c t   t o   J S O N ( n  ] b I   ^ b�������� ,0 localizeddescription localizedDescription��  ��   o   ] ^���� 0 theerror theError
 m   c f �  ) . ��
�� 
errn m   X Y�����Y ����
�� 
erob o   Z [���� 0 
jsonobject 
jsonObject��  ��  ��   �� L   m � c   m � l  m ����� n  m � I   v ������� 00 initwithdata_encoding_ initWithData_encoding_  o   v w���� 0 thedata theData  ��  l  w |!����! n  w |"#" o   x |���� ,0 nsutf8stringencoding NSUTF8StringEncoding# m   w x��
�� misccura��  ��  ��  ��   n  m v$%$ I   r v�������� 	0 alloc  ��  ��  % n  m r&'& o   n r���� 0 nsstring NSString' m   m n��
�� misccura��  ��   m   � ���
�� 
ctxt��  � R      ��()
�� .ascrerr ****      � ****( o      ���� 0 etext eText) ��*+
�� 
errn* o      ���� 0 enumber eNumber+ ��,-
�� 
erob, o      ���� 0 efrom eFrom- ��.��
�� 
errt. o      ���� 
0 eto eTo��  � I   � ���/���� 
0 _error  / 010 m   � �22 �33  f o r m a t   J S O N1 454 o   � ����� 0 etext eText5 676 o   � ����� 0 enumber eNumber7 898 o   � ����� 0 efrom eFrom9 :��: o   � ����� 
0 eto eTo��  ��  � ;<; l     ��������  ��  ��  < =>= l     ��������  ��  ��  > ?@? i  6 9ABA I     ��CD
�� .Web:PJSNnull���     ctxtC o      ���� 0 jsontext jsonTextD ��E��
�� 
FragE |����F��G��  ��  F o      ���� *0 arefragmentsallowed areFragmentsAllowed��  G l     H����H m      ��
�� boovfals��  ��  ��  B Q     �IJKI k    �LL MNM r    OPO n   QRQ I    ��S���� "0 astextparameter asTextParameterS TUT o    	���� 0 jsontext jsonTextU V��V m   	 
WW �XX  ��  ��  R o    ���� 0 _support  P o      ���� 0 jsontext jsonTextN YZY Z    *[\��][ n   ^_^ I    ��`���� (0 asbooleanparameter asBooleanParameter` aba o    ���� *0 arefragmentsallowed areFragmentsAllowedb c��c m    dd �ee $ a l l o w i n g   f r a g m e n t s��  ��  _ o    ���� 0 _support  \ r    $fgf n   "hih o     "���� :0 nsjsonreadingallowfragments NSJSONReadingAllowFragmentsi m     ��
�� misccurag o      ���� 0 readoptions readOptions��  ] r   ' *jkj m   ' (����  k o      ���� 0 readoptions readOptionsZ lml r   + <non n  + :pqp I   3 :��r���� (0 datausingencoding_ dataUsingEncoding_r s��s l  3 6t����t n  3 6uvu o   4 6�� ,0 nsutf8stringencoding NSUTF8StringEncodingv m   3 4�~
�~ misccura��  ��  ��  ��  q l  + 3w�}�|w n  + 3xyx I   . 3�{z�z�{ &0 stringwithstring_ stringWithString_z {�y{ o   . /�x�x 0 jsontext jsonText�y  �z  y n  + .|}| o   , .�w�w 0 nsstring NSString} m   + ,�v
�v misccura�}  �|  o o      �u�u 0 thedata theDatam ~~ r   = V��� n  = G��� I   @ G�t��s�t F0 !jsonobjectwithdata_options_error_ !JSONObjectWithData_options_error_� ��� o   @ A�r�r 0 thedata theData� ��� o   A B�q�q 0 readoptions readOptions� ��p� l  B C��o�n� m   B C�m
�m 
obj �o  �n  �p  �s  � n  = @��� o   > @�l�l *0 nsjsonserialization NSJSONSerialization� m   = >�k
�k misccura� J      �� ��� o      �j�j 0 
jsonobject 
jsonObject� ��i� o      �h�h 0 theerror theError�i   ��� Z  W {���g�f� =  W Z��� o   W X�e�e 0 
jsonobject 
jsonObject� m   X Y�d
�d 
msng� R   ] w�c��
�c .ascrerr ****      � ****� b   i v��� b   i r��� m   i l�� ���   N o t   v a l i d   J S O N   (� n  l q��� I   m q�b�a�`�b ,0 localizeddescription localizedDescription�a  �`  � o   l m�_�_ 0 theerror theError� m   r u�� ���  ) .� �^��
�^ 
errn� m   _ b�]�]�Y� �\��[
�\ 
erob� o   e f�Z�Z 0 jsontext jsonText�[  �g  �f  � ��Y� L   | ��� c   | ���� o   | }�X�X 0 
jsonobject 
jsonObject� m   } ��W
�W 
****�Y  J R      �V��
�V .ascrerr ****      � ****� o      �U�U 0 etext eText� �T��
�T 
errn� o      �S�S 0 enumber eNumber� �R��
�R 
erob� o      �Q�Q 0 efrom eFrom� �P��O
�P 
errt� o      �N�N 
0 eto eTo�O  K I   � ��M��L�M 
0 _error  � ��� m   � ��� ���  p a r s e   J S O N� ��� o   � ��K�K 0 etext eText� ��� o   � ��J�J 0 enumber eNumber� ��� o   � ��I�I 0 efrom eFrom� ��H� o   � ��G�G 
0 eto eTo�H  �L  @ ��� l     �F�E�D�F  �E  �D  � ��� l     �C�B�A�C  �B  �A  � ��� l     �@���@  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �?���?  �   HTTP dispatch   � ���    H T T P   d i s p a t c h� ��� l     �>�=�<�>  �=  �<  � ��� i  : =��� I     �;��
�; .Web:ReqHnull��� ��� ctxt� |�:�9��8��:  �9  � o      �7�7 0 
httpmethod 
httpMethod�8  � l     ��6�5� m      �� ���  G E T�6  �5  � �4��
�4 
Dest� o      �3�3 0 theurl theURL� �2��
�2 
Head� |�1�0��/��1  �0  � o      �.�. 0 headerslist headersList�/  � J      �-�-  � �,��
�, 
Body� |�+�*��)��+  �*  � o      �(�( 0 bodydata bodyData�)  � l     ��'�&� m      �%
�% 
msng�'  �&  � �$��#
�$ 
Type� |�"�!�� ��"  �!  � o      �� $0 responsebodytype responseBodyType�   � l     ���� m      �
� 
ctxt�  �  �#  � k      �� ��� l     ����  �NH Q. if responseBodyType is `text`, add appropriate content negotiation header automatically? (bear in mind that markup-based formats such as HTTP may have their own ideas about encoding, e.g. an HTML document may include its own content-type header while an inadequately configured server claims a completely different encoding)   � ����   Q .   i f   r e s p o n s e B o d y T y p e   i s   ` t e x t ` ,   a d d   a p p r o p r i a t e   c o n t e n t   n e g o t i a t i o n   h e a d e r   a u t o m a t i c a l l y ?   ( b e a r   i n   m i n d   t h a t   m a r k u p - b a s e d   f o r m a t s   s u c h   a s   H T T P   m a y   h a v e   t h e i r   o w n   i d e a s   a b o u t   e n c o d i n g ,   e . g .   a n   H T M L   d o c u m e n t   m a y   i n c l u d e   i t s   o w n   c o n t e n t - t y p e   h e a d e r   w h i l e   a n   i n a d e q u a t e l y   c o n f i g u r e d   s e r v e r   c l a i m s   a   c o m p l e t e l y   d i f f e r e n t   e n c o d i n g )� ��� l     ����  �  �  � ��� l     ����  �IC note that Text library will need to provide `convert text to data` and `convert data to text` handlers for converting between `utxt` and `rdat` given an explicit encoding (see also File library, which already provides some encoding support, but as constants, not fuzzy name strings, which isn't good for portability/reuse)   � ����   n o t e   t h a t   T e x t   l i b r a r y   w i l l   n e e d   t o   p r o v i d e   ` c o n v e r t   t e x t   t o   d a t a `   a n d   ` c o n v e r t   d a t a   t o   t e x t `   h a n d l e r s   f o r   c o n v e r t i n g   b e t w e e n   ` u t x t `   a n d   ` r d a t `   g i v e n   a n   e x p l i c i t   e n c o d i n g   ( s e e   a l s o   F i l e   l i b r a r y ,   w h i c h   a l r e a d y   p r o v i d e s   s o m e   e n c o d i n g   s u p p o r t ,   b u t   a s   c o n s t a n t s ,   n o t   f u z z y   n a m e   s t r i n g s ,   w h i c h   i s n ' t   g o o d   f o r   p o r t a b i l i t y / r e u s e )�  � ��� l     ����  �  �  � ��� l     ����  �  �  �       ����������� �  � ����
�	��������� 
� 
pimr� 0 _support  � 
0 _error  �
 $0 asnsurlparameter asNSURLParameter
�	 .Web:SplUnull���     ctxt
� .Web:JoiUnull���     ****
� .Web:EscUnull���     ctxt
� .Web:UneUnull���     ctxt
� .Web:SplQnull���     ctxt
� .Web:JoiQnull���     ctxt
� .Web:FJSNnull���     ****
� .Web:PJSNnull���     ctxt
� .Web:ReqHnull��� ��� ctxt
�  .aevtoappnull  �   � ****� ����    ����
�� 
cobj    �� 
�� 
frmk��  � 		   �� *
�� 
scpt� �� 4����
���� 
0 _error  �� ����   ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  
 ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo  D������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+ � �� b�������� $0 asnsurlparameter asNSURLParameter�� ����   ������ 0 urltext urlText�� 0 parametername parameterName��   �������� 0 urltext urlText�� 0 parametername parameterName�� 0 asocurl asocURL 
�������������� �����
�� misccura�� 0 nsurl NSURL�� "0 astextparameter asTextParameter��  0 urlwithstring_ URLWithString_�� "0 standardizedurl standardizedURL
�� 
msng
�� 
ctxt�� �� .0 throwinvalidparameter throwInvalidParameter�� 0��,b  ��l+ k+ j+ E�O��  *�����+ 	Y hO�� �� �������
�� .Web:SplUnull���     ctxt�� 0 urltext urlText��   �������������� 0 urltext urlText�� 0 asocurl asocURL�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo  ������������������������������������������� ������� $0 asnsurlparameter asNSURLParameter�� 0 	urlscheme 	urlScheme�� 
0 scheme  
�� 
****�� 0 username userName�� 0 user  �� 0 userpassword userPassword�� 0 password  �� 0 hostname hostName�� 0 host  �� 0 
portnumber 
portNumber�� 0 port  �� 0 resourcepath resourcePath�� 0 path  �� "0 parameterstring parameterString�� 0 querystring queryString�� 	0 query  �� (0 fragmentidentifier fragmentIdentifier�� 0 fragment  �� �� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� y db  ��l+ E�O�j+ �&�j+ �&�j+ �&�j+ 
�&�j+ �&��j+ �&�j+ �&a �j+ �&a �j+ �&a W X  *a ����a + � ��������
�� .Web:JoiUnull���     ****�� 0 	urlrecord 	urlRecord�� ����
�� 
Base {������ 0 baseurl baseURL��  ��   �������������� 0 	urlrecord 	urlRecord�� 0 baseurl baseURL�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo ������������������������A��M����Z������ 0 	urlscheme 	urlScheme�� 0 requiredvalue RequiredValue�� 0 username userName
�� 
msng�� 0 userpassword userPassword�� 0 hostname hostName�� 0 
portnumber 
portNumber�� 0 resourcepath resourcePath�� "0 parameterstring parameterString�� 0 querystring queryString�� (0 fragmentidentifier fragmentIdentifier�� �� 60 asoptionalrecordparameter asOptionalRecordParameter�� $0 asnsurlparameter asNSURLParameter�� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� W Bb  ��b  �,�����b  �,������������m+ E�Ob  ��l+ E�OPW X  *a ����a + � ��~������
�� .Web:EscUnull���     ctxt�� 0 thetext theText�� ����
�� 
Safe {������� &0 allowedcharacters allowedCharacters��  ��   ����~�}�|�{�z�� 0 thetext theText� &0 allowedcharacters allowedCharacters�~ 0 
asocresult 
asocResult�} 0 etext eText�| 0 enumber eNumber�{ 0 efrom eFrom�z 
0 eto eTo ��y��x�w�v�u�t�s�r�q�p�o�n��m��l�k�y "0 astextparameter asTextParameter
�x misccura�w 0 nsstring NSString�v &0 stringwithstring_ stringWithString_�u  0 nscharacterset NSCharacterSet�t J0 #charactersetwithcharactersinstring_ #characterSetWithCharactersInString_�s j0 3stringbyaddingpercentencodingwithallowedcharacters_ 3stringByAddingPercentEncodingWithAllowedCharacters_
�r 
msng
�q 
errn�p�Y
�o 
erob�n �m 0 etext eText �j�i
�j 
errn�i 0 enumber eNumber �h�g 
�h 
erob�g 0 efrom eFrom  �f�e�d
�f 
errt�e 
0 eto eTo�d  �l �k 
0 _error  �� _ Jb  ��l+ E�Ob  ��l+ E�O��,�k+ ��,�k+ k+ E�O��  )�����Y hW X  *a ����a + � �c��b�a!"�`
�c .Web:UneUnull���     ctxt�b 0 thetext theText�a  ! �_�^�]�\�[�Z�_ 0 thetext theText�^ 0 
asocresult 
asocResult�] 0 etext eText�\ 0 enumber eNumber�[ 0 efrom eFrom�Z 
0 eto eTo" ��Y�X�W�V�U�T�S�R�Q�P�O�N#)�M�L�Y "0 astextparameter asTextParameter
�X misccura�W 0 nsstring NSString�V &0 stringwithstring_ stringWithString_�U B0 stringbyremovingpercentencoding stringByRemovingPercentEncoding
�T 
msng
�S 
errn�R�Y
�Q 
erob�P 
�O 
ctxt�N 0 etext eText# �K�J$
�K 
errn�J 0 enumber eNumber$ �I�H%
�I 
erob�H 0 efrom eFrom% �G�F�E
�G 
errt�F 
0 eto eTo�E  �M �L 
0 _error  �` L 9b  ��l+ E�O��,�k+ j+ E�O��  )�����Y hO��&W X  *��a + � �DS�C�B&'�A
�D .Web:SplQnull���     ctxt�C 0 	querytext 	queryText�B  & �@�?�>�=�<�@ 0 	querytext 	queryText�? 0 etext eText�> 0 enumber eNumber�= 0 efrom eFrom�< 
0 eto eTo' c�;�:(p�9�8�; "0 astextparameter asTextParameter�: 0 etext eText( �7�6)
�7 
errn�6 0 enumber eNumber) �5�4*
�5 
erob�4 0 efrom eFrom* �3�2�1
�3 
errt�2 
0 eto eTo�1  �9 �8 
0 _error  �A % b  ��l+ E�OPW X  *䡢���+   �0��/�.+,�-
�0 .Web:JoiQnull���     ctxt�/ 0 	querylist 	queryList�.  + �,�+�*�)�(�, 0 	querylist 	queryList�+ 0 etext eText�* 0 enumber eNumber�) 0 efrom eFrom�( 
0 eto eTo, ��'�&-��%�$�' "0 aslistparameter asListParameter�& 0 etext eText- �#�".
�# 
errn�" 0 enumber eNumber. �!� /
�! 
erob�  0 efrom eFrom/ ���
� 
errt� 
0 eto eTo�  �% �$ 
0 _error  �- % b  ��l+ E�OPW X  *䡢���+  ����01�
� .Web:FJSNnull���     ****� 0 
jsonobject 
jsonObject� �2�
� 
EWSp2 {���� "0 isprettyprinted isPrettyPrinted�  
� boovfals�  0 	���������� 0 
jsonobject 
jsonObject� "0 isprettyprinted isPrettyPrinted� 0 writeoptions writeOptions� 0 thedata theData� 0 theerror theError� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo1 ��
�	���������� ������������������32�����
 (0 asbooleanparameter asBooleanParameter
�	 misccura� 80 nsjsonwritingprettyprinted NSJSONWritingPrettyPrinted� *0 nsjsonserialization NSJSONSerialization� (0 isvalidjsonobject_ isValidJSONObject_
� 
errn��Y
� 
erob� 
� 
obj �  F0 !datawithjsonobject_options_error_ !dataWithJSONObject_options_error_
�� 
cobj
�� 
msng�� ,0 localizeddescription localizedDescription�� 0 nsstring NSString�� 	0 alloc  �� ,0 nsutf8stringencoding NSUTF8StringEncoding�� 00 initwithdata_encoding_ initWithData_encoding_
�� 
ctxt�� 0 etext eText3 ����4
�� 
errn�� 0 enumber eNumber4 ����5
�� 
erob�� 0 efrom eFrom5 ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  � � �b  ��l+  
��,E�Y jE�O��,�k+  )�����Y hO��,���m+ E[�k/E�Z[�l/E�ZO��  )�����j+ %a %Y hO�a ,j+ ��a ,l+ a &W X  *a ����a +  ��B����67��
�� .Web:PJSNnull���     ctxt�� 0 jsontext jsonText�� ��8��
�� 
Frag8 {�������� *0 arefragmentsallowed areFragmentsAllowed��  
�� boovfals��  6 
���������������������� 0 jsontext jsonText�� *0 arefragmentsallowed areFragmentsAllowed�� 0 readoptions readOptions�� 0 thedata theData�� 0 
jsonobject 
jsonObject�� 0 theerror theError�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo7 W��d����������������������������������������9������� "0 astextparameter asTextParameter�� (0 asbooleanparameter asBooleanParameter
�� misccura�� :0 nsjsonreadingallowfragments NSJSONReadingAllowFragments�� 0 nsstring NSString�� &0 stringwithstring_ stringWithString_�� ,0 nsutf8stringencoding NSUTF8StringEncoding�� (0 datausingencoding_ dataUsingEncoding_�� *0 nsjsonserialization NSJSONSerialization
�� 
obj �� F0 !jsonobjectwithdata_options_error_ !JSONObjectWithData_options_error_
�� 
cobj
�� 
msng
�� 
errn���Y
�� 
erob�� �� ,0 localizeddescription localizedDescription
�� 
****�� 0 etext eText9 ����:
�� 
errn�� 0 enumber eNumber: ����;
�� 
erob�� 0 efrom eFrom; ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� � �b  ��l+ E�Ob  ��l+  
��,E�Y jE�O��,�k+ ��,k+ 	E�O��,���m+ E[�k/E�Z[�l/E�ZO��  )�a a �a a �j+ %a %Y hO�a &W X  *a ����a +  �������<=��
�� .Web:ReqHnull��� ��� ctxt�� {������� 0 
httpmethod 
httpMethod��  �� ����>
�� 
Dest�� 0 theurl theURL> ��?@
�� 
Head? {�������� 0 headerslist headersList��  ��  @ ��AB
�� 
BodyA {�������� 0 bodydata bodyData��  
�� 
msngB ��C��
�� 
TypeC {�������� $0 responsebodytype responseBodyType��  
�� 
ctxt��  < ������������ 0 
httpmethod 
httpMethod�� 0 theurl theURL�� 0 headerslist headersList�� 0 bodydata bodyData�� $0 responsebodytype responseBodyType=  �� h ��D����EF��
�� .aevtoappnull  �   � ****D k     GG  �HH ����  ��  ��  E  F  ��
�� .Web:SplUnull���     ctxt�� �j O�j  ascr  ��ޭ