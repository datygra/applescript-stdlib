FasdUAS 1.101.10   ��   ��    k             x     �� ����    4     �� 
�� 
scpt  m     	 	 � 
 
  T e s t T o o l s��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l          x    $�� ����    4   ' +�� 
�� 
scpt  m   ) *   �    N u m b e r��      the script being tested     �   0   t h e   s c r i p t   b e i n g   t e s t e d      l     ��������  ��  ��        l     ��������  ��  ��        h   $ +��  �� 0 suite_round suite_Round   k       ! !  " # " l     ��������  ��  ��   #  $ % $ i     & ' & I      ��������  0 test_rounddate test_roundDate��  ��   ' I    - (�� ) ( z�� 
�� .���:AsRenull��� ��� null��   ) �� * +
�� 
Valu * l  	  ,���� , I  	  - . / - z�� 
�� .Mth:RouNnull���     nmbr . m     0 0 @�z�G� / �� 1��
�� 
Plac 1 m    ���� ��  ��  ��   + �� 2 3
�� 
Equa 2 m     4 4 @�\(� 3 �� 5��
�� 
Usin 5 l   ( 6���� 6 I   ( 7���� 7 z�� 
�� .���:ExEqnull��� ��� null��  ��  ��  ��  ��   %  8�� 8 l      �� 9 :��   9��	to test_square()		assert test result for (0.7 ^ 2) is 0.49 -- TEST: this fails not because code is wrong but because floating point math hardware has limited precision	end test_square		to test_square2()		assert test result for (0.7 ^ 2) is 0.49 using (numeric equality check) -- TEST: this passes as `numeric equality check` allows up to �1.0e-9 difference between numbers	end test_square2	    : � ; ;  	 t o   t e s t _ s q u a r e ( )  	 	 a s s e r t   t e s t   r e s u l t   f o r   ( 0 . 7   ^   2 )   i s   0 . 4 9   - -   T E S T :   t h i s   f a i l s   n o t   b e c a u s e   c o d e   i s   w r o n g   b u t   b e c a u s e   f l o a t i n g   p o i n t   m a t h   h a r d w a r e   h a s   l i m i t e d   p r e c i s i o n  	 e n d   t e s t _ s q u a r e  	  	 t o   t e s t _ s q u a r e 2 ( )  	 	 a s s e r t   t e s t   r e s u l t   f o r   ( 0 . 7   ^   2 )   i s   0 . 4 9   u s i n g   ( n u m e r i c   e q u a l i t y   c h e c k )   - -   T E S T :   t h i s   p a s s e s   a s   ` n u m e r i c   e q u a l i t y   c h e c k `   a l l o w s   u p   t o   � 1 . 0 e - 9   d i f f e r e n c e   b e t w e e n   n u m b e r s  	 e n d   t e s t _ s q u a r e 2  	��     < = < l     ��������  ��  ��   =  > ? > h   , 3�� @�� $0 suite_conversion suite_Conversion @ k       A A  B C B l     ��������  ��  ��   C  D E D i     F G F I      �������� $0 test_parsenumber test_parseNumber��  ��   G k     = H H  I J I I     K�� L K z�� 
�� .���:AsRenull��� ��� null��   L �� M N
�� 
Valu M l  	  O���� O I  	  P Q�� P z�� 
�� .Mth:PNumnull���     ctxt Q m     R R � S S  3 . 1 4��  ��  ��   N �� T��
�� 
Equa T m     U U @	�Q���   J  V�� V I   = W�� X W z�� 
�� .���:AsRenull��� ��� null��   X �� Y Z
�� 
Valu Y l  ' 6 [���� [ I  ' 6 \ ] ^ \ z�� 
�� .Mth:PNumnull���     ctxt ] m   . / _ _ � ` `  3 , 1 4 ^ �� a��
�� 
Loca a m   0 1 b b � c c 
 d e _ D E��  ��  ��   Z �� d��
�� 
Equa d m   7 8 e e @	�Q���  ��   E  f g f l     ��������  ��  ��   g  h i h i    j k j I      �������� &0 test_formatnumber test_formatNumber��  ��   k k     = l l  m n m I     o�� p o z�� 
�� .���:AsRenull��� ��� null��   p �� q r
�� 
Valu q l  	  s���� s I  	  t u�� t z�� 
�� .Mth:FNumnull���     nmbr u m     v v @	�Q���  ��  ��   r �� w��
�� 
Equa w m     x x � y y  3 . 1 4��   n  z�� z I   = {�� | { z�� 
�� .���:AsRenull��� ��� null��   | �� } ~
�� 
Valu } l  ' 6 ����  I  ' 6 � � � � z�� 
�� .Mth:FNumnull���     nmbr � m   . / � � @	�Q� � �� ���
�� 
Loca � m   0 1 � � � � � 
 d e _ D E��  ��  ��   ~ �� ���
�� 
Equa � m   7 8 � � � � �  3 , 1 4��  ��   i  ��� � l     ��������  ��  ��  ��   ?  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i   4 7 � � � I     ������
�� .aevtoappnull  �   � ****��  ��   � l     � � � � I     � ��� � z�� 
�� .���:RunTnull���     file � l    ����� � I   �� ���
�� .earsffdralis        afdr �  f    ��  ��  ��  ��   � N H including this command allows tests to be run directly in Script Editor    � � � � �   i n c l u d i n g   t h i s   c o m m a n d   a l l o w s   t e s t s   t o   b e   r u n   d i r e c t l y   i n   S c r i p t   E d i t o r �  � � � l     �������  ��  �   �  � � � l     �~�}�|�~  �}  �|   �  ��{ � l     �z�y�x�z  �y  �x  �{       �w � � � � ��w   � �v�u�t�s
�v 
pimr�u 0 suite_round suite_Round�t $0 suite_conversion suite_Conversion
�s .aevtoappnull  �   � **** � �r ��r  �   � � � � �q ��p
�q 
cobj �  � �   �o 	
�o 
scpt�p   � �n ��m
�n 
cobj �  � �   �l
�l 
osax�m   � �k ��j
�k 
cobj �  � �   �i 
�i 
scpt�j   � �h     ��h 0 suite_round suite_Round � �g � ��g   � �f�f  0 test_rounddate test_roundDate � �e '�d�c � ��b�e  0 test_rounddate test_roundDate�d  �c   �   � �a 	�`  0�_�^�] 4�\ 	�[�Z�Y
�a 
scpt
�` 
Valu
�_ 
Plac
�^ .Mth:RouNnull���     nmbr
�] 
Equa
�\ 
Usin
�[ .���:ExEqnull��� ��� null�Z 
�Y .���:AsRenull��� ��� null�b .)��/ '*�)��/ 	��ll U���)��/ *j U� U � �X @   ��X $0 suite_conversion suite_Conversion � �W � � ��W   � �V�U�V $0 test_parsenumber test_parseNumber�U &0 test_formatnumber test_formatNumber � �T G�S�R � ��Q�T $0 test_parsenumber test_parseNumber�S  �R   �   � �P 	�O  R�N�M U�L�K 	  _�J b
�P 
scpt
�O 
Valu
�N .Mth:PNumnull���     ctxt
�M 
Equa�L 
�K .���:AsRenull��� ��� null
�J 
Loca�Q >)��/ *�)��/ �j U��� 	UO)��/ *�)��/ 	���l U��� 	U � �I k�H�G � ��F�I &0 test_formatnumber test_formatNumber�H  �G   �   � �E 	�D  v�C�B x�A�@ 	 �? � �
�E 
scpt
�D 
Valu
�C .Mth:FNumnull���     nmbr
�B 
Equa�A 
�@ .���:AsRenull��� ��� null
�? 
Loca�F >)��/ *�)��/ �j U��� 	UO)��/ *�)��/ 	���l U��� 	U � �> ��=�< � ��;
�> .aevtoappnull  �   � ****�=  �<   �   � �: 	�9�8
�: 
scpt
�9 .earsffdralis        afdr
�8 .���:RunTnull���     file�; )��/ )j j U ascr  ��ޭ