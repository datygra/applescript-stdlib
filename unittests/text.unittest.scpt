FasdUAS 1.101.10   ��   ��    k             x     �� ����    4     �� 
�� 
scpt  m     	 	 � 
 
  T e s t T o o l s��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l          x    $�� ����    4   � ��� 
�� 
scpt  m   � �   �    T e x t��      the script being tested     �   0   t h e   s c r i p t   b e i n g   t e s t e d      l     ��������  ��  ��        l     ��������  ��  ��        h   $ +��  �� $0 suite_modifytext suite_ModifyText   k       ! !  " # " l      �� $ %��   $2,	to configure_skipTests()		return "checking suite skipping works" -- skip all tests in this suite		return {test_uppercase:"checking per-test skipping works", test_lowercase:missing value} -- skip 'test_uppercase only'		return missing value -- do all tests in this suite	end configure_skipTests	    % � & &X  	 t o   c o n f i g u r e _ s k i p T e s t s ( )  	 	 r e t u r n   " c h e c k i n g   s u i t e   s k i p p i n g   w o r k s "   - -   s k i p   a l l   t e s t s   i n   t h i s   s u i t e  	 	 r e t u r n   { t e s t _ u p p e r c a s e : " c h e c k i n g   p e r - t e s t   s k i p p i n g   w o r k s " ,   t e s t _ l o w e r c a s e : m i s s i n g   v a l u e }   - -   s k i p   ' t e s t _ u p p e r c a s e   o n l y '  	 	 r e t u r n   m i s s i n g   v a l u e   - -   d o   a l l   t e s t s   i n   t h i s   s u i t e  	 e n d   c o n f i g u r e _ s k i p T e s t s  	 #  ' ( ' i     ) * ) I      �������� 0 test_uppercase  ��  ��   * k     � + +  , - , I    ! .�� / . z�� 
�� .���:AsRenull��� ��� null��   / �� 0 1
�� 
Valu 0 l  	  2���� 2 I  	  3 4�� 3 z�� 
�� .Txt:UppTnull���     ctxt 4 b     5 6 5 m     7 7 � 8 8  f o �   b � r 6 1    ��
�� 
lnfd��  ��  ��   1 �� 9��
�� 
Equa 9 b     : ; : m     < < � = =  F O �   B � R ; 1    ��
�� 
lnfd��   -  > ? > I  " A @�� A @ z�� 
�� .���:AsRenull��� ��� null��   A �� B C
�� 
Valu B l  + 8 D���� D I  + 8 E F�� E z�� 
�� .Txt:UppTnull���     ctxt F m   2 3 G G @      ��  ��  ��   C �� H��
�� 
Equa H l  9 < I���� I c   9 < J K J m   9 : L L @       K m   : ;��
�� 
ctxt��  ��  ��   ?  M�� M X   B � N�� O N I  b � P�� Q P z�� 
�� .���:AsErnull��� ��� null��   Q �� R S
�� 
Args R n  o t T U T 1   p t��
�� 
pcnt U o   o p���� 0 aref aRef S �� V��
�� 
Equa V K   u } W W �� X���� 0 errornumber errorNumber X m   x {�����Y��  ��  �� 0 aref aRef O J   E R Y Y  Z [ Z K   E K \ \ �� ]���� 0 a   ] m   F I ^ ^ � _ _  f o o��   [  `�� ` J   K P a a  b�� b 1   K N��
�� 
ascr��  ��  ��   (  c d c l     ��������  ��  ��   d  e f e i    g h g I      �������� 0 test_lowercase  ��  ��   h k     [ i i  j k j I     l�� m l z�� 
�� .���:AsRenull��� ��� null��   m �� n o
�� 
Valu n l  	  p���� p I  	  q r�� q z�� 
�� .Txt:LowTnull���     ctxt r m     s s � t t  F O � B � R��  ��  ��   o �� u��
�� 
Equa u m     v v � w w  f o � b � r��   k  x�� x X    [ y�� z y I  6 V {�� | { z�� 
�� .���:AsErnull��� ��� null��   | �� } ~
�� 
Args } n  C H  �  1   D H��
�� 
pcnt � o   C D���� 0 aref aRef ~ �� ���
�� 
Equa � K   I Q � � �� ����� 0 errornumber errorNumber � m   L O�����Y��  ��  �� 0 aref aRef z J   ! * � �  � � � K   ! % � � �� ����� 0 a   � m   " # � � � � �  f o o��   �  ��� � J   % ( � �  ��� � 1   % &��
�� 
ascr��  ��  ��   f  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� 0 test_capitalize  ��  ��   � k     [ � �  � � � I     ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  	  ����� � I  	  � ��� � z�� 
�� .Txt:CapTnull���     ctxt � m     � � � � �  F O � B � R��  ��  ��   � �� ���
�� 
Equa � m     � � � � �  F o � b � r��   �  ��� � X    [ ��� � � I  6 V ��� � � z�� 
�� .���:AsErnull��� ��� null��   � �� � �
�� 
Args � n  C H � � � 1   D H��
�� 
pcnt � o   C D���� 0 aref aRef � �� ���
�� 
Equa � K   I Q � � �� ����� 0 errornumber errorNumber � m   L O�����Y��  ��  �� 0 aref aRef � J   ! * � �  � � � K   ! % � � �� ����� 0 a   � m   " # � � � � �  f o o��   �  ��� � J   % ( � �  ��� � 1   % &��
�� 
ascr��  ��  ��   �  � � � l     ��~�}�  �~  �}   �  � � � i    � � � I      �| ��{�| 0 call_uppercase   �  ��z � o      �y�y 	0 param  �z  �{   � I     � ��x � z�w 
�w .Txt:UppTnull���     ctxt � o    �v�v 	0 param  �x   �  � � � l     �u�t�s�u  �t  �s   �  � � � i    � � � I      �r ��q�r 0 call_lowercase   �  ��p � o      �o�o 	0 param  �p  �q   � I     � ��n � z�m 
�m .Txt:LowTnull���     ctxt � o    �l�l 	0 param  �n   �  � � � l     �k�j�i�k  �j  �i   �  � � � i    � � � I      �h ��g�h 0 call_capitalize   �  ��f � o      �e�e 	0 param  �f  �g   � I     � ��d � z�c 
�c .Txt:CapTnull���     ctxt � o    �b�b 	0 param  �d   �  ��a � l     �`�_�^�`  �_  �^  �a     � � � l     �]�\�[�]  �\  �[   �  � � � l     �Z�Y�X�Z  �Y  �X   �  � � � h   , 3�W ��W $0 suite_searchtext suite_SearchText � k       � �  � � � l     �V�U�T�V  �U  �T   �  � � � l     �S � ��S   � | v TO DO: tests need to randomize Unicode normalization, considering/ignoring, TIDs to ensure those don't affect results    � � � � �   T O   D O :   t e s t s   n e e d   t o   r a n d o m i z e   U n i c o d e   n o r m a l i z a t i o n ,   c o n s i d e r i n g / i g n o r i n g ,   T I D s   t o   e n s u r e   t h o s e   d o n ' t   a f f e c t   r e s u l t s �  � � � l     �R�Q�P�R  �Q  �P   �  � � � i     � � � I      �O�N�M�O "0 test_searchtext test_searchText�N  �M   � k     � � �  � � � I    Y ��L � � z�K 
�K .���:AsRenull��� ��� null�L   � �J � �
�J 
Valu � l  	  ��I�H � I  	  � � � � z�G 
�G .Txt:Srchnull���     ctxt � m     � � � � �  a b c � �F � �
�F 
For_ � m     � � � � �  a b c � �E ��D
�E 
Retu � m     � � z�C 
�C RetEAllT�D  �I  �H   � �B �A
�B 
Equa  J    T  K    + �@
�@ 
pcls m     z�? 
�? 
TxtU �>	�> 0 
startindex 
startIndex m    �=�= 	 �<
�< 0 endindex endIndex
 m     !�;�;   �:�9�: 0 	foundtext 	foundText m   $ ' �  �9    K   + B �8
�8 
pcls m   , / z�7 
�7 
TxtM �6�6 0 
startindex 
startIndex m   0 1�5�5  �4�4 0 endindex endIndex m   2 3�3�3  �2�2 0 	foundtext 	foundText m   6 9 �  a b c �1�0�1 0 foundgroups foundGroups J   < >�/�/  �0   �. K   B R �- !
�- 
pcls  m   C D"" z�, 
�, 
TxtU! �+#$�+ 0 
startindex 
startIndex# m   E F�*�* $ �)%&�) 0 endindex endIndex% m   G H�(�( & �''�&�' 0 	foundtext 	foundText' m   K N(( �))  �&  �.  �A   � *+* l  Z Z�%�$�#�%  �$  �#  + ,�", I  Z �-�!.- z�  
�  .���:AsRenull��� ��� null�!  . �/0
� 
Valu/ l  e z1��1 I  e z2342 z� 
� .Txt:Srchnull���     ctxt3 m   n q55 �66  a b4 �7�
� 
For_7 m   r u88 �99  a b�  �  �  0 �:�
� 
Equa: J   { �;; <�< K   { �== �>?
� 
pcls> m   | @@ z� 
� 
TxtM? �AB� 0 
startindex 
startIndexA m   � ��� B �CD� 0 endindex endIndexC m   � ��� D �EF� 0 	foundtext 	foundTextE m   � �GG �HH  a bF �I�� 0 foundgroups foundGroupsI J   � ���  �  �  �  �"   � JKJ l     ���
�  �  �
  K LML i   NON I      �	���	 (0 test_searchpattern test_searchPattern�  �  O l     ����  �  �  M P�P l     ��� �  �  �   �   � QRQ l     ��������  ��  ��  R STS l     ��������  ��  ��  T UVU h   4 ;��W�� "0 suite_slicetext suite_SliceTextW k      XX YZY l     ��������  ��  ��  Z [\[ i    ]^] I      �������� 0 
test_slice  ��  ��  ^ k     �__ `a` I    !b��cb z�� 
�� .���:AsRenull��� ��� null��  c ��de
�� 
Valud l  	 f����f I  	 ghig z�� 
�� .Txt:SliTnull���     ctxth m    jj �kk  a b ci ��lm
�� 
FIdxl m    ���� m ��n��
�� 
TIdxn m    ���� ��  ��  ��  e ��o��
�� 
Equao m    pp �qq  b c��  a rsr I  " Ct��ut z�� 
�� .���:AsRenull��� ��� null��  u ��vw
�� 
Valuv l  + <x����x I  + <yz{y z�� 
�� .Txt:SliTnull���     ctxtz m   2 3|| �}}  a b c{ ��~
�� 
FIdx~ m   4 5����  �����
�� 
TIdx� m   6 7���� ��  ��  ��  w �����
�� 
Equa� m   = >�� ���  ��  s ��� I  D o����� z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  O f������ I  O f���� z�� 
�� .Txt:SliTnull���     ctxt� m   X [�� ���  a b c� ����
�� 
FIdx� m   \ _������� �����
�� 
TIdx� m   ` a���� ��  ��  ��  � �����
�� 
Equa� m   g j�� ���  a b��  � ��� I  p ������ z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  { ������� I  { ����� z�� 
�� .Txt:SliTnull���     ctxt� m   � ��� ���  a b c� ����
�� 
FIdx� m   � �������� �����
�� 
TIdx� m   � ���������  ��  ��  � �����
�� 
Equa� m   � ��� ���  a��  � ���� I  � ������ z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  � ������� I  � ����� z�� 
�� .Txt:SliTnull���     ctxt� m   � ��� ���  a b c� ����
�� 
FIdx� m   � �������� �����
�� 
TIdx� m   � ���������  ��  ��  � �����
�� 
Equa� m   � ��� ���  ��  ��  \ ���� l     ��������  ��  ��  ��  V ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� h   < C����� $0 suite_formattext suite_FormatText� k      �� ��� l     ��������  ��  ��  � ��� i    ��� I      �������� *0 configure_skiptests configure_skipTests��  ��  � L     �� m     �� ���  T O D O� ��� l     ��������  ��  ��  � ��� j    ����� 	0 _date  � m    ��
�� 
msng� ��� j    	����� 0 	_testdata 	_testData� m    ��
�� 
msng� ��� l     ��������  ��  ��  � ��� i  
 ��� I      �������� "0 configure_setup configure_setUp��  ��  � k     @�� ��� r     ��� I    ������
�� .misccurdldt    ��� null��  ��  � o      ���� 	0 _date  � ���� r    @��� J    :�� ��� l 	  ������ J    �� ��� l   ������ m    �� @��������  ��  � ���� l   ������ c    ��� m    �� @������� m    ��
�� 
ctxt��  ��  ��  ��  ��  � ��� l 	  ������ J    �� ��� l   ������ m    �� ���  ��  ��  � ���� l   ����� m    �� ���  " "��  �  ��  ��  ��  � ��� l 	  +��~�}� J    +��    l    �|�{ J       m     �  f o o 	 m    �z�z 	 

 m    �y
�y boovtrue �x o    �w�w 	0 _date  �x  �|  �{   �v l    )�u�t b     ) b     ' m     ! � . { " f o o " ,   1 ,   t r u e ,   d a t e   " o   ! &�s�s 	0 _date   m   ' ( �  " }�u  �t  �v  �~  �}  � �r l 	 + 8�q�p l 
 + 8�o�n J   + 8  l  + 3�m�l K   + 3 �k �k 0 a   m   , -�j
�j 
msng  �i!"
�i 
pnam! m   . /�h
�h 
alis" �g#�f
�g 
pcls# m   0 1�e
�e 
docu�f  �m  �l   $�d$ l  3 6%�c�b% m   3 6&& �'' Z { a : m i s s i n g   v a l u e ,   n a m e : a l i a s ,   c l a s s : d o c u m e n t }�c  �b  �d  �o  �n  �q  �p  �r  � o      �a�a 0 	_testdata 	_testData��  � ()( l     �`�_�^�`  �_  �^  ) *+* i   ,-, I      �]�\�[�] 80 test_literalrepresentation test_literalRepresentation�\  �[  - X     +.�Z/. k    &00 121 r    $343 o    �Y�Y 0 aref aRef4 J      55 676 o      �X�X 0 avalue aValue7 8�W8 o      �V�V  0 expectedresult expectedResult�W  2 9�U9 l  % %�T:;�T  : R Lassert test result for (literal representation for aValue) is expectedResult   ; �<< � a s s e r t   t e s t   r e s u l t   f o r   ( l i t e r a l   r e p r e s e n t a t i o n   f o r   a V a l u e )   i s   e x p e c t e d R e s u l t�U  �Z 0 aref aRef/ o    �S�S 0 	_testdata 	_testData+ =�R= l     �Q�P�O�Q  �P  �O  �R  � >?> l     �N�M�L�N  �M  �L  ? @A@ l     �K�J�I�K  �J  �I  A BCB i   D GDED I     �H�G�F
�H .aevtoappnull  �   � ****�G  �F  E l    FGHF I    IJ�EI z�D 
�D .���:RunTnull���     fileJ l   K�C�BK I   �AL�@
�A .earsffdralis        afdrL  f    �@  �C  �B  �E  G N H including this command allows tests to be run directly in Script Editor   H �MM �   i n c l u d i n g   t h i s   c o m m a n d   a l l o w s   t e s t s   t o   b e   r u n   d i r e c t l y   i n   S c r i p t   E d i t o rC NON l     �?�>�=�?  �>  �=  O PQP l     �<�;�:�<  �;  �:  Q R�9R l     �8�7�6�8  �7  �6  �9       �5STUVWXY�5  S �4�3�2�1�0�/
�4 
pimr�3 $0 suite_modifytext suite_ModifyText�2 $0 suite_searchtext suite_SearchText�1 "0 suite_slicetext suite_SliceText�0 $0 suite_formattext suite_FormatText
�/ .aevtoappnull  �   � ****T �.Z�. Z  [\][ �-^�,
�- 
cobj^ __   �+ 	
�+ 
scpt�,  \ �*`�)
�* 
cobj` aa   �(
�( 
osax�)  ] �'b�&
�' 
cobjb cc   �% 
�% 
scpt�&  U �$    d�$ $0 suite_modifytext suite_ModifyTextd �#efghijk�#  e �"�!� ����" 0 test_uppercase  �! 0 test_lowercase  �  0 test_capitalize  � 0 call_uppercase  � 0 call_lowercase  � 0 call_capitalize  f � *��lm�� 0 test_uppercase  �  �  l �� 0 aref aRefm � 	�  7��� <�� 	  G�� ^���� 	�
�	���
� 
scpt
� 
Valu
� 
lnfd
� .Txt:UppTnull���     ctxt
� 
Equa� 
� .���:AsRenull��� ��� null
� 
ctxt� 0 a  
� 
ascr
� 
kocl
� 
cobj
� .corecnte****       ****
�
 
Args
�	 
pcnt� 0 errornumber errorNumber��Y
� .���:AsErnull��� ��� null� �)��/ *�)��/ 	��%j U���%� 
UO)��/ *�)��/ �j U���&� 
UO D�a l_ kvlv[a a l kh  )�a / *a �a ,�a a l� U[OY��g � h��no�� 0 test_lowercase  �  �  n �� 0 aref aRefo �  	��  s���� v������ ��������� 	����������
�  
scpt
�� 
Valu
�� .Txt:LowTnull���     ctxt
�� 
Equa�� 
�� .���:AsRenull��� ��� null�� 0 a  
�� 
ascr
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
Args
�� 
pcnt�� 0 errornumber errorNumber���Y
�� .���:AsErnull��� ��� null� \)��/ *�)��/ �j U��� 	UO <��l�kvlv[��l kh  )�a / *a �a ,�a a l� U[OY��h �� �����pq���� 0 test_capitalize  ��  ��  p ���� 0 aref aRefq �� 	��  ����� ������� ��������� 	����������
�� 
scpt
�� 
Valu
�� .Txt:CapTnull���     ctxt
�� 
Equa�� 
�� .���:AsRenull��� ��� null�� 0 a  
�� 
ascr
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
Args
�� 
pcnt�� 0 errornumber errorNumber���Y
�� .���:AsErnull��� ��� null�� \)��/ *�)��/ �j U��� 	UO <��l�kvlv[��l kh  )�a / *a �a ,�a a l� U[OY��i �� �����rs���� 0 call_uppercase  �� ��t�� t  ���� 	0 param  ��  r ���� 	0 param  s �� ��
�� 
scpt
�� .Txt:UppTnull���     ctxt�� )��/ �j Uj �� �����uv���� 0 call_lowercase  �� ��w�� w  ���� 	0 param  ��  u ���� 	0 param  v �� ��
�� 
scpt
�� .Txt:LowTnull���     ctxt�� )��/ �j Uk �� �����xy���� 0 call_capitalize  �� ��z�� z  ���� 	0 param  ��  x ���� 	0 param  y �� ��
�� 
scpt
�� .Txt:CapTnull���     ctxt�� )��/ �j UV �� �  {�� $0 suite_searchtext suite_SearchText{ ��|}~��  | ������ "0 test_searchtext test_searchText�� (0 test_searchpattern test_searchPattern} �� ���������� "0 test_searchtext test_searchText��  ��    � �� 	��  ��� �����������������������������(�� 	 58G
�� 
scpt
�� 
Valu
�� 
For_
�� 
Retu
�� RetEAllT�� 
�� .Txt:Srchnull���     ctxt
�� 
Equa
�� 
pcls
�� 
TxtU�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 
�� 
TxtM�� 0 foundgroups foundGroups�� 

�� .���:AsRenull��� ��� null�� �)��/ S*�)��/ ������ 
U����k�ja a a �a �k�ma a a jva �����ma a a mv� UO)�a / 7*�)�a / a �a l 
U��a �k�la a a jva kv� U~ ��O���������� (0 test_searchpattern test_searchPattern��  ��  �  �  �� hW ��W  ��� "0 suite_slicetext suite_SliceText� ������  � ���� 0 
test_slice  � ��^���������� 0 
test_slice  ��  ��  �  � �� 	�� j����������p�� 	 |� 	 ���� 	 ���� 	 ����
�� 
scpt
�� 
Valu
�� 
FIdx
�� 
TIdx�� 
�� .Txt:SliTnull���     ctxt
�� 
Equa
�� .���:AsRenull��� ��� null�������������� �)��/ *�)��/ ��l�m� U��� UO)��/ *�)��/ ��m�l� U��� UO)�a / #*�)�a / a �a �l� U�a � UO)�a / %*�)�a / a �a �a � U�a � UO)�a / %*�)�a / a �a �a � U�a � UX ���  ��� $0 suite_formattext suite_FormatText� ������������  � ������������ *0 configure_skiptests configure_skipTests�� 	0 _date  �� 0 	_testdata 	_testData�� "0 configure_setup configure_setUp�� 80 test_literalrepresentation test_literalRepresentation� ������������� *0 configure_skiptests configure_skipTests��  ��  �  � ��� �
�� 
msng
�� 
msng� ������������� "0 configure_setup configure_setUp��  ��  �  � ���~���}�|�{�z�y�x�w�v&
� .misccurdldt    ��� null
�~ 
ctxt�} �| 0 a  
�{ 
msng
�z 
pnam
�y 
alis
�x 
pcls
�w 
docu�v �� A*j  Ec  O���&lv��lv�keb  �v�b  %�%lv�������a lv�vEc  � �u-�t�s���r�u 80 test_literalrepresentation test_literalRepresentation�t  �s  � �q�p�o�q 0 aref aRef�p 0 avalue aValue�o  0 expectedresult expectedResult� �n�m�l
�n 
kocl
�m 
cobj
�l .corecnte****       ****�r , *b  [��l kh  �E[�k/E�Z[�l/E�ZOP[OY��Y �kE�j�i���h
�k .aevtoappnull  �   � ****�j  �i  �  � �g 	�f�e
�g 
scpt
�f .earsffdralis        afdr
�e .���:RunTnull���     file�h )��/ )j j Uascr  ��ޭ