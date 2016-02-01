FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� TestTools -- unit testing framework and other testing/profiling tools

About:

- TestTools's unit testing framework takes a NAME.unittest.scpt file containing one or more script objects, each representing a test suite, and each of those script objects containing one or more handlers representing individual unit tests. Test suite scripts must have `suite_` name prefixes; test handlers within those scripts must have `test_` name prefixes.

- The command line `osatest` test runner introspects the unittest script to obtain all suite and test names. For each found test it creates a new AppleScript component instance (interpreter), loads a clean copy of the unittest script into it, then calls [indirectly] TestTools's `__performunittestforsuite__` handler to run that test. The resulting `TestReport` object is then returned to `osatest` to finish generating the report for that test and print it.

Notes:

- Saving unittest scripts as compiled `.scpt` files rather than `.applescript` snippets avoids any risk of test scripts not compiling correctly when run by `osatest` - i.e. it's one less thing to go wrong.

- The `.unittest.scpt[d]` suffix is a convention, not a requirement, but is strongly encouraged. e.g. Future improvements to `osatest` may include the ability to search a library script bundle for any embedded unittest files and run them all automatically.


TO DO:

- implement line-wrapping in TestSupport.scpt to improve readability when displaying reports in Terminal

- embed `osatest` executable in library bundle? or is it best to keep it separate?

- options for automatically spiking TIDs and considering/ignoring options before calling `test_NAME` handler; also, what about an option for composing/decomposing unicode (assuming that's an issue in AS/Cocoa, e.g. when comparing/sorting AS/NS strings); note that localization is harder to spike, but should be done if possible as it affects date and number coercions

- what other check objects should be defined as standard? e.g. `exact range check`, `numeric range check`, `exact containment check`, `exact type check` (checks only that the expected and actual values are of the same type; relatively weak, but still potentially of some use when checking, say, e.g. that actual errorNumber is `integer` and actual errorMessage is `text`), `ASObjC equality check`(checks both values are ocid specifiers then compares them using `-isEqual:`), `text pattern check` (allow wildcard/regexp checking, possibly applying additional check objects to wildcard-matched ranges; this could be useful e.g. when checking error messages where some parts of the message may vary - e.g. disk and home folder names in file paths - so should be either ignored or custom-checked but the rest of the message is constant); also, how might multiple checks be usefully composed? (e.g. currently the `exact error check` constructor optionally accepts an record of one or more equality checkers for customizing how specific error attributes are checked)

      � 	 	~   T e s t T o o l s   - -   u n i t   t e s t i n g   f r a m e w o r k   a n d   o t h e r   t e s t i n g / p r o f i l i n g   t o o l s 
 
 A b o u t : 
 
 -   T e s t T o o l s ' s   u n i t   t e s t i n g   f r a m e w o r k   t a k e s   a   N A M E . u n i t t e s t . s c p t   f i l e   c o n t a i n i n g   o n e   o r   m o r e   s c r i p t   o b j e c t s ,   e a c h   r e p r e s e n t i n g   a   t e s t   s u i t e ,   a n d   e a c h   o f   t h o s e   s c r i p t   o b j e c t s   c o n t a i n i n g   o n e   o r   m o r e   h a n d l e r s   r e p r e s e n t i n g   i n d i v i d u a l   u n i t   t e s t s .   T e s t   s u i t e   s c r i p t s   m u s t   h a v e   ` s u i t e _ `   n a m e   p r e f i x e s ;   t e s t   h a n d l e r s   w i t h i n   t h o s e   s c r i p t s   m u s t   h a v e   ` t e s t _ `   n a m e   p r e f i x e s . 
 
 -   T h e   c o m m a n d   l i n e   ` o s a t e s t `   t e s t   r u n n e r   i n t r o s p e c t s   t h e   u n i t t e s t   s c r i p t   t o   o b t a i n   a l l   s u i t e   a n d   t e s t   n a m e s .   F o r   e a c h   f o u n d   t e s t   i t   c r e a t e s   a   n e w   A p p l e S c r i p t   c o m p o n e n t   i n s t a n c e   ( i n t e r p r e t e r ) ,   l o a d s   a   c l e a n   c o p y   o f   t h e   u n i t t e s t   s c r i p t   i n t o   i t ,   t h e n   c a l l s   [ i n d i r e c t l y ]   T e s t T o o l s ' s   ` _ _ p e r f o r m u n i t t e s t f o r s u i t e _ _ `   h a n d l e r   t o   r u n   t h a t   t e s t .   T h e   r e s u l t i n g   ` T e s t R e p o r t `   o b j e c t   i s   t h e n   r e t u r n e d   t o   ` o s a t e s t `   t o   f i n i s h   g e n e r a t i n g   t h e   r e p o r t   f o r   t h a t   t e s t   a n d   p r i n t   i t . 
 
 N o t e s : 
 
 -   S a v i n g   u n i t t e s t   s c r i p t s   a s   c o m p i l e d   ` . s c p t `   f i l e s   r a t h e r   t h a n   ` . a p p l e s c r i p t `   s n i p p e t s   a v o i d s   a n y   r i s k   o f   t e s t   s c r i p t s   n o t   c o m p i l i n g   c o r r e c t l y   w h e n   r u n   b y   ` o s a t e s t `   -   i . e .   i t ' s   o n e   l e s s   t h i n g   t o   g o   w r o n g . 
 
 -   T h e   ` . u n i t t e s t . s c p t [ d ] `   s u f f i x   i s   a   c o n v e n t i o n ,   n o t   a   r e q u i r e m e n t ,   b u t   i s   s t r o n g l y   e n c o u r a g e d .   e . g .   F u t u r e   i m p r o v e m e n t s   t o   ` o s a t e s t `   m a y   i n c l u d e   t h e   a b i l i t y   t o   s e a r c h   a   l i b r a r y   s c r i p t   b u n d l e   f o r   a n y   e m b e d d e d   u n i t t e s t   f i l e s   a n d   r u n   t h e m   a l l   a u t o m a t i c a l l y . 
 
 
 T O   D O : 
 
 -   i m p l e m e n t   l i n e - w r a p p i n g   i n   T e s t S u p p o r t . s c p t   t o   i m p r o v e   r e a d a b i l i t y   w h e n   d i s p l a y i n g   r e p o r t s   i n   T e r m i n a l 
 
 -   e m b e d   ` o s a t e s t `   e x e c u t a b l e   i n   l i b r a r y   b u n d l e ?   o r   i s   i t   b e s t   t o   k e e p   i t   s e p a r a t e ? 
 
 -   o p t i o n s   f o r   a u t o m a t i c a l l y   s p i k i n g   T I D s   a n d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   b e f o r e   c a l l i n g   ` t e s t _ N A M E `   h a n d l e r ;   a l s o ,   w h a t   a b o u t   a n   o p t i o n   f o r   c o m p o s i n g / d e c o m p o s i n g   u n i c o d e   ( a s s u m i n g   t h a t ' s   a n   i s s u e   i n   A S / C o c o a ,   e . g .   w h e n   c o m p a r i n g / s o r t i n g   A S / N S   s t r i n g s ) ;   n o t e   t h a t   l o c a l i z a t i o n   i s   h a r d e r   t o   s p i k e ,   b u t   s h o u l d   b e   d o n e   i f   p o s s i b l e   a s   i t   a f f e c t s   d a t e   a n d   n u m b e r   c o e r c i o n s 
 
 -   w h a t   o t h e r   c h e c k   o b j e c t s   s h o u l d   b e   d e f i n e d   a s   s t a n d a r d ?   e . g .   ` e x a c t   r a n g e   c h e c k ` ,   ` n u m e r i c   r a n g e   c h e c k ` ,   ` e x a c t   c o n t a i n m e n t   c h e c k ` ,   ` e x a c t   t y p e   c h e c k `   ( c h e c k s   o n l y   t h a t   t h e   e x p e c t e d   a n d   a c t u a l   v a l u e s   a r e   o f   t h e   s a m e   t y p e ;   r e l a t i v e l y   w e a k ,   b u t   s t i l l   p o t e n t i a l l y   o f   s o m e   u s e   w h e n   c h e c k i n g ,   s a y ,   e . g .   t h a t   a c t u a l   e r r o r N u m b e r   i s   ` i n t e g e r `   a n d   a c t u a l   e r r o r M e s s a g e   i s   ` t e x t ` ) ,   ` A S O b j C   e q u a l i t y   c h e c k ` ( c h e c k s   b o t h   v a l u e s   a r e   o c i d   s p e c i f i e r s   t h e n   c o m p a r e s   t h e m   u s i n g   ` - i s E q u a l : ` ) ,   ` t e x t   p a t t e r n   c h e c k `   ( a l l o w   w i l d c a r d / r e g e x p   c h e c k i n g ,   p o s s i b l y   a p p l y i n g   a d d i t i o n a l   c h e c k   o b j e c t s   t o   w i l d c a r d - m a t c h e d   r a n g e s ;   t h i s   c o u l d   b e   u s e f u l   e . g .   w h e n   c h e c k i n g   e r r o r   m e s s a g e s   w h e r e   s o m e   p a r t s   o f   t h e   m e s s a g e   m a y   v a r y   -   e . g .   d i s k   a n d   h o m e   f o l d e r   n a m e s   i n   f i l e   p a t h s   -   s o   s h o u l d   b e   e i t h e r   i g n o r e d   o r   c u s t o m - c h e c k e d   b u t   t h e   r e s t   o f   t h e   m e s s a g e   i s   c o n s t a n t ) ;   a l s o ,   h o w   m i g h t   m u l t i p l e   c h e c k s   b e   u s e f u l l y   c o m p o s e d ?   ( e . g .   c u r r e n t l y   t h e   ` e x a c t   e r r o r   c h e c k `   c o n s t r u c t o r   o p t i o n a l l y   a c c e p t s   a n   r e c o r d   o f   o n e   o r   m o r e   e q u a l i t y   c h e c k e r s   f o r   c u s t o m i z i n g   h o w   s p e c i f i c   e r r o r   a t t r i b u t e s   a r e   c h e c k e d ) 
 
     
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��   !��       support    ! � " "    s u p p o r t   # $ # l     ��������  ��  ��   $  % & % l      ' ( ) ' j    �� *�� 0 _support   * N     + + 4    �� ,
�� 
scpt , m     - - � . .  T y p e S u p p o r t ( "  used for parameter checking    ) � / / 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g &  0 1 0 l     ��������  ��  ��   1  2 3 2 i   ! 4 5 4 I      �� 6���� 
0 _error   6  7 8 7 o      ���� 0 handlername handlerName 8  9 : 9 o      ���� 0 etext eText :  ; < ; o      ���� 0 enumber eNumber <  = > = o      ���� 0 efrom eFrom >  ?�� ? o      ���� 
0 eto eTo��  ��   5 n     @ A @ I    �� B���� &0 throwcommanderror throwCommandError B  C D C m     E E � F F  T e s t T o o l s D  G H G o    ���� 0 handlername handlerName H  I J I o    ���� 0 etext eText J  K L K o    	���� 0 enumber eNumber L  M N M o   	 
���� 0 efrom eFrom N  O�� O o   
 ���� 
0 eto eTo��  ��   A o     ���� 0 _support   3  P Q P l     ��������  ��  ��   Q  R S R l     ��������  ��  ��   S  T U T l      V W X V j   " (�� Y�� 0 _testsupport _TestSupport Y N   " ' Z Z 4   " &�� [
�� 
scpt [ m   $ % \ \ � ] ]  T e s t S u p p o r t W . ( sub-library embedded in TestTools.scptd    X � ^ ^ P   s u b - l i b r a r y   e m b e d d e d   i n   T e s t T o o l s . s c p t d U  _ ` _ l     ��������  ��  ��   `  a b a l     ��������  ��  ��   b  c d c l     �� e f��   e J D--------------------------------------------------------------------    f � g g � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - d  h i h l     �� j k��   j   Test Utilities    k � l l    T e s t   U t i l i t i e s i  m n m l     ��������  ��  ��   n  o p o i  ) , q r q I      �� s���� 0 
randomword 
randomWord s  t u t o      ���� 0 	minlength 	minLength u  v�� v o      ���� 0 	maxlength 	maxLength��  ��   r l    ' w x y w k     ' z z  { | { r      } ~ } m        � � �   ~ o      ���� 0 s   |  � � � U    $ � � � r     � � � b     � � � o    ���� 0 s   � n     � � � 3    ��
�� 
cobj � m     � � � � � 4 a b c d e f g h i j k l m n o p q r s t u v w x y z � o      ���� 0 s   � l    ����� � I    ��� � � z����
�� .sysorandnmbr    ��� nmbr
�� misccura��   � �� � �
�� 
from � o    ���� 0 	minlength 	minLength � �� ���
�� 
to   � o    ���� 0 	maxlength 	maxLength��  ��  ��   �  ��� � L   % ' � � o   % &���� 0 s  ��   x R L TO DO: can this be turned into a genuinely useful test tool? if not, delete    y � � � �   T O   D O :   c a n   t h i s   b e   t u r n e d   i n t o   a   g e n u i n e l y   u s e f u l   t e s t   t o o l ?   i f   n o t ,   d e l e t e p  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � J D--------------------------------------------------------------------    � � � � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - �  � � � l     �� � ���   �   Timing/Profiling    � � � � "   T i m i n g / P r o f i l i n g �  � � � l     ��������  ��  ��   �  � � � i  - 0 � � � I     �� ���
�� .���:MTmrnull��� ��� ctxt � |���� ��� ���  ��   � o      ���� 0 nametext nameText��   � l      ����� � m       � � � � �  ��  ��  ��   � h     �� ��� 0 timerobject TimerObject � k       � �  � � � l     �� � ���   � � � note: AS can't serialize ASOC objects when [auto-]saving scripts, so store start and end times as NSTimeInterval (Double/real) to avoid any complaints    � � � �.   n o t e :   A S   c a n ' t   s e r i a l i z e   A S O C   o b j e c t s   w h e n   [ a u t o - ] s a v i n g   s c r i p t s ,   s o   s t o r e   s t a r t   a n d   e n d   t i m e s   a s   N S T i m e I n t e r v a l   ( D o u b l e / r e a l )   t o   a v o i d   a n y   c o m p l a i n t s �  � � � x     �� �����   � 4    �� �
�� 
frmk � m     � � � � �  F o u n d a t i o n��   �  � � � j    �� ��� 0 
_starttime 
_startTime � m    ��
�� 
msng �  � � � j    �� ��� 0 _totalseconds _totalSeconds � m     � �          �  � � � j    �� ��� 0 
_isrunning 
_isRunning � m    ��
�� boovfals �  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� 0 	timername 	timerName��  ��   � L      � � o     ���� 0 nametext nameText �  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� 0 
starttimer 
startTimer��  ��   � k     ' � �  � � � Z     � ����� � o     ���� 0 
_isrunning 
_isRunning � L    
����  ��  ��   �  � � � r     � � � m    ��
�� boovtrue � o      �� 0 
_isrunning 
_isRunning �  � � � r    $ � � � n    � � � I    �~�}�|�~ @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�}  �|   � n    � � � o    �{�{ 0 nsdate NSDate � m    �z
�z misccura � o      �y�y 0 
_starttime 
_startTime �  ��x � L   % ' � �  f   % &�x   �  � � � l     �w�v�u�w  �v  �u   �  � � � i    � � � I      �t�s�r�t 0 	stoptimer 	stopTimer�s  �r   � k     8 � �  � � � Z     � ��q�p � H      � � o     �o�o 0 
_isrunning 
_isRunning � L   	  � � m   	 
�n�n  �q  �p   �  � � � r     � � � \     � � � l    ��m�l � n    � � � I    �k�j�i�k @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�j  �i   � n    � � � o    �h�h 0 nsdate NSDate � m    �g
�g misccura�m  �l   � o    �f�f 0 
_starttime 
_startTime � o      �e�e 0 elapsedtime elapsedTime �  � � � r     - �  � [     ' o     %�d�d 0 _totalseconds _totalSeconds o   % &�c�c 0 elapsedtime elapsedTime  o      �b�b 0 _totalseconds _totalSeconds �  r   . 5 m   . /�a
�a boovfals o      �`�` 0 
_isrunning 
_isRunning �_ L   6 8 o   6 7�^�^ 0 elapsedtime elapsedTime�_   � 	
	 l     �]�\�[�]  �\  �[  
  i    # I      �Z�Y�X�Z 0 elapsedtime elapsedTime�Y  �X   Z     �W o     �V�V 0 
_isrunning 
_isRunning L     \     l   �U�T n    I   	 �S�R�Q�S @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�R  �Q   o    	�P�P 0 nsdate NSDate�U  �T   o    �O�O 0 
_starttime 
_startTime�W   L     m    �N�N    l     �M�L�K�M  �L  �K   �J i  $ ' I      �I�H�G�I 0 	totaltime 	totalTime�H  �G   Z     �F  o     �E�E 0 
_isrunning 
_isRunning L    !! [    "#" o    �D�D 0 _totalseconds _totalSeconds# I    �C�B�A�C 0 elapsedtime elapsedTime�B  �A  �F    L    $$ o    �@�@ 0 _totalseconds _totalSeconds�J   � %&% l     �?�>�=�?  �>  �=  & '(' l     �<�;�:�<  �;  �:  ( )*) l     �9+,�9  + J D--------------------------------------------------------------------   , �-- � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -* ./. l     �801�8  0   Unit Test Framework   1 �22 (   U n i t   T e s t   F r a m e w o r k/ 343 l     �7�6�5�7  �6  �5  4 565 l     7897 j   1 3�4:�4 00 _abortedassertionerror _AbortedAssertionError: m   1 2�3�3A8 P J raised by `assert�` handlers upon failed assertion to terminate that test   9 �;; �   r a i s e d   b y   ` a s s e r t & `   h a n d l e r s   u p o n   f a i l e d   a s s e r t i o n   t o   t e r m i n a t e   t h a t   t e s t6 <=< l     �2�1�0�2  �1  �0  = >?> h   4 ;�/@�/ 00 _abortedassertiontoken _AbortedAssertionToken@ l     �.AB�.  A.( when raising error number AbortedAssertionError, the `from` parameter should carry this unique identifier to confirm error was raised by TestTools, and isn't merely an error in the test code/code being tested that happens to use the same error number (in which case it should be treated as such)   B �CCP   w h e n   r a i s i n g   e r r o r   n u m b e r   A b o r t e d A s s e r t i o n E r r o r ,   t h e   ` f r o m `   p a r a m e t e r   s h o u l d   c a r r y   t h i s   u n i q u e   i d e n t i f i e r   t o   c o n f i r m   e r r o r   w a s   r a i s e d   b y   T e s t T o o l s ,   a n d   i s n ' t   m e r e l y   a n   e r r o r   i n   t h e   t e s t   c o d e / c o d e   b e i n g   t e s t e d   t h a t   h a p p e n s   t o   u s e   t h e   s a m e   e r r o r   n u m b e r   ( i n   w h i c h   c a s e   i t   s h o u l d   b e   t r e a t e d   a s   s u c h )? DED l     �-�,�+�-  �,  �+  E FGF l     �*�)�(�*  �)  �(  G HIH l     �'JK�'  J L F the following are set/unset by __performunittestforsuite__ as it runs   K �LL �   t h e   f o l l o w i n g   a r e   s e t / u n s e t   b y   _ _ p e r f o r m u n i t t e s t f o r s u i t e _ _   a s   i t   r u n sI MNM l     �&�%�$�&  �%  �$  N OPO l     QRSQ j   < @�#T�# $0 _testsuiteobject _testSuiteObjectT m   < ?�"
�" 
msngR � � the test suite object that was passed to `perform unit test`; assigned and cleared at start and end of `perform unit test`; may be used by assert handlers (e.g. `assert test error` uses it when calling a `call_NAME` handler)   S �UU�   t h e   t e s t   s u i t e   o b j e c t   t h a t   w a s   p a s s e d   t o   ` p e r f o r m   u n i t   t e s t ` ;   a s s i g n e d   a n d   c l e a r e d   a t   s t a r t   a n d   e n d   o f   ` p e r f o r m   u n i t   t e s t ` ;   m a y   b e   u s e d   b y   a s s e r t   h a n d l e r s   ( e . g .   ` a s s e r t   t e s t   e r r o r `   u s e s   i t   w h e n   c a l l i n g   a   ` c a l l _ N A M E `   h a n d l e r )P VWV l     �!� ��!  �   �  W XYX l     Z[\Z j   A E�]� 0 _testreport _testReport] m   A D�
� 
msng[ x r a single test_NAME handler may perform multiple asserts, the result of each is recorded in TestReport object here   \ �^^ �   a   s i n g l e   t e s t _ N A M E   h a n d l e r   m a y   p e r f o r m   m u l t i p l e   a s s e r t s ,   t h e   r e s u l t   o f   e a c h   i s   r e c o r d e d   i n   T e s t R e p o r t   o b j e c t   h e r eY _`_ l     ����  �  �  ` aba l     cdec j   F J�f� $0 _testhandlername _testHandlerNamef m   F I�
� 
msngd R L used to generate default `call_NAME` handler name for a `test_NAME` handler   e �gg �   u s e d   t o   g e n e r a t e   d e f a u l t   ` c a l l _ N A M E `   h a n d l e r   n a m e   f o r   a   ` t e s t _ N A M E `   h a n d l e rb hih l     ����  �  �  i jkj j   K O�l� 0 
_skipsuite 
_SKIPSUITEl m   K N�� ck mnm l     ����  �  �  n opo l     ����  �  �  p qrq l     �st�  s  -------   t �uu  - - - - - - -r vwv l     �xy�  x ) # execute a single test_NAME handler   y �zz F   e x e c u t e   a   s i n g l e   t e s t _ N A M E   h a n d l e rw {|{ l     �
}~�
  } ] W (called by `osatest` via a code-generated glue handler it adds to the unittest script)   ~ � �   ( c a l l e d   b y   ` o s a t e s t `   v i a   a   c o d e - g e n e r a t e d   g l u e   h a n d l e r   i t   a d d s   t o   t h e   u n i t t e s t   s c r i p t )| ��� l     �	���	  �  �  � ��� i  P S��� I      ���� 0 __performunittestforsuite__  � ��� o      �� 0 suiteobject suiteObject� ��� J      �� ��� o      �� 0 	suitename 	suiteName� ��� o      �� 0 handlername handlerName� �� � o      ���� 0 isstyled isStyled�   �  �  � k    |�� ��� l      ������  �e_
		suiteObject : script -- test suite object
		suiteName : text -- test suite name, for reporting use
		handlerName : text -- name of the test suite handler to call
		allHandlerNames : list of text -- all handler names in this test suite; used to determine which if any fixture methods (configure_setUp, configure_tearDown, etc.) need to be called
		isStyled : boolean -- if true, the returned report will include special formatting codes (bold, underline) to improve presentation in Terminal.app and other VT100 emulators; use false if you intend to use this text elsewhere
		Result: script -- TestReport
	   � ���� 
 	 	 s u i t e O b j e c t   :   s c r i p t   - -   t e s t   s u i t e   o b j e c t 
 	 	 s u i t e N a m e   :   t e x t   - -   t e s t   s u i t e   n a m e ,   f o r   r e p o r t i n g   u s e 
 	 	 h a n d l e r N a m e   :   t e x t   - -   n a m e   o f   t h e   t e s t   s u i t e   h a n d l e r   t o   c a l l 
 	 	 a l l H a n d l e r N a m e s   :   l i s t   o f   t e x t   - -   a l l   h a n d l e r   n a m e s   i n   t h i s   t e s t   s u i t e ;   u s e d   t o   d e t e r m i n e   w h i c h   i f   a n y   f i x t u r e   m e t h o d s   ( c o n f i g u r e _ s e t U p ,   c o n f i g u r e _ t e a r D o w n ,   e t c . )   n e e d   t o   b e   c a l l e d 
 	 	 i s S t y l e d   :   b o o l e a n   - -   i f   t r u e ,   t h e   r e t u r n e d   r e p o r t   w i l l   i n c l u d e   s p e c i a l   f o r m a t t i n g   c o d e s   ( b o l d ,   u n d e r l i n e )   t o   i m p r o v e   p r e s e n t a t i o n   i n   T e r m i n a l . a p p   a n d   o t h e r   V T 1 0 0   e m u l a t o r s ;   u s e   f a l s e   i f   y o u   i n t e n d   t o   u s e   t h i s   t e x t   e l s e w h e r e 
 	 	 R e s u l t :   s c r i p t   - -   T e s t R e p o r t 
 	� ��� r     ��� n    ��� I    �������  0 maketestreport makeTestReport� ��� o    ���� 0 	suitename 	suiteName� ��� o    ���� 0 handlername handlerName� ���� o    ���� 0 isstyled isStyled��  ��  � o     ���� 0 _testsupport _TestSupport� o      ���� 0 _testreport _testReport� ��� l   ������  � = 7 check if this test (or entire suite) should be skipped   � ��� n   c h e c k   i f   t h i s   t e s t   ( o r   e n t i r e   s u i t e )   s h o u l d   b e   s k i p p e d� ��� Z   C������� n    ��� I     ������� 0 
hashandler 
hasHandler� ���� N    �� n    ��� o    ���� *0 configure_skiptests configure_skipTests� o    ���� 0 suiteobject suiteObject��  ��  � o    ���� 0 _support  � Q   #?���� k   &�� ��� r   & -��� n  & +��� I   ' +�������� *0 configure_skiptests configure_skipTests��  ��  � o   & '���� 0 suiteobject suiteObject� o      ���� 0 skipinfo skipInfo� ��� Q   . Q���� l  1 4���� r   1 4��� o   1 2���� 0 skipinfo skipInfo� o      ���� 0 skipinfo skipInfo� > 8 make sure configure_skipTests actually returned a value   � ��� p   m a k e   s u r e   c o n f i g u r e _ s k i p T e s t s   a c t u a l l y   r e t u r n e d   a   v a l u e� R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      ����
���  � k   < Q�� ��� R   < J����
�� .ascrerr ****      � ****� m   H I�� ��� �  c o n f i g u r e _ s k i p T e s t s    d i d n  t   r e t u r n   a n y t h i n g   ( e . g .   t o   r u n   a l l   t e s t s   i n   s u i t e ,   r e t u r n    m i s s i n g   v a l u e  ) .� ����
�� 
errn� m   > ?�����?� ����
�� 
erob� o   @ A���� 0 suiteobject suiteObject� �����
�� 
errt� J   B G�� ��� m   B C��
�� 
reco� ��� m   C D��
�� 
ctxt� ���� m   D E��
�� 
msng��  ��  � ���� L   K Q�� o   K P���� 0 _testreport _testReport��  � ���� Z   R������� >  R U��� o   R S���� 0 skipinfo skipInfo� m   S T��
�� 
msng� l  X���� Z   X������ n  X c��� I   ] c������� 0 istype isType� ��� o   ] ^���� 0 skipinfo skipInfo� ���� m   ^ _��
�� 
reco��  ��  � o   X ]���� 0 _testsupport _TestSupport� l  f ����� k   f ��� ��� r   f {��� c   f y��� l  f u������ n  f u��� I   p u������� 0 objectforkey_ objectForKey_� ���� o   p q���� 0 handlername handlerName��  ��  � l  f p������ n  f p� � I   k p������ 60 dictionarywithdictionary_ dictionaryWithDictionary_ �� o   k l���� 0 skipinfo skipInfo��  ��    n  f k o   g k���� 0 nsdictionary NSDictionary m   f g��
�� misccura��  ��  ��  ��  � m   u x��
�� 
****� o      ���� 0 
skipreason 
skipReason� �� Z   | ����� >  | 	 o   | }���� 0 
skipreason 
skipReason	 m   } ~��
�� 
msng k   � �

  Q   � � r   � � c   � � o   � ����� 0 
skipreason 
skipReason m   � ���
�� 
ctxt o      ���� 0 
skipreason 
skipReason R      ����
�� .ascrerr ****      � ****��   ����
�� 
errn d       m      �������   R   � ���
�� .ascrerr ****      � **** b   � � b   � � m   � � � f  c o n f i g u r e _ s k i p T e s t s    d i d n  t   r e t u r n   v a l i d   r e c o r d   (  o   � ����� 0 handlername handlerName m   � � �   h    p r o p e r t y   d o e s n  t   c o n t a i n   t e x t   o r    m i s s i n g   v a l u e  ) . ��!"
�� 
errn! m   � ������\" ��#$
�� 
erob# o   � ����� 0 skipinfo skipInfo$ ��%��
�� 
errt% J   � �&& '(' m   � ���
�� 
ctxt( )��) m   � ���
�� 
msng��  ��   *+* n  � �,-, I   � ���.���� 0 
addskipped 
addSkipped. /0/ o   � ����� 0 handlername handlerName0 1��1 o   � ����� 0 
skipreason 
skipReason��  ��  - o   � ����� 0 _testreport _testReport+ 2��2 L   � �33 o   � ����� 0 _testreport _testReport��  ��  ��  ��  � + % check if this test should be skipped   � �44 J   c h e c k   i f   t h i s   t e s t   s h o u l d   b e   s k i p p e d� 565 >  � �787 o   � ����� 0 skipinfo skipInfo8 m   � ���
�� 
msng6 9��9 l  � �:;<: k   � �== >?> Q   � �@AB@ r   � �CDC c   � �EFE o   � ����� 0 skipinfo skipInfoF m   � ���
�� 
ctxtD o      ���� 0 
skipreason 
skipReasonA R      ����G
�� .ascrerr ****      � ****��  G ��H��
�� 
errnH d      II m      �������  B R   � ���JK
�� .ascrerr ****      � ****J m   � �LL �MM �  c o n f i g u r e _ s k i p T e s t s    d i d n  t   r e t u r n   r e c o r d ,   t e x t ,   o r    m i s s i n g   v a l u e  .K ��NO
�� 
errnN m   � ������\O ��PQ
�� 
erobP o   � ����� 0 skipinfo skipInfoQ ��R��
�� 
errtR J   � �SS TUT m   � ���
�� 
recoU VWV m   � ���
�� 
ctxtW X��X m   � ���
�� 
msng��  ��  ? YZY n  � �[\[ I   � ���]���� 0 	skipsuite 	skipSuite] ^�^ o   � ��~�~ 0 
skipreason 
skipReason�  ��  \ o   � ��}�} 0 _testreport _testReportZ _�|_ L   � �`` o   � ��{�{ 0 _testreport _testReport�|  ;   skip the whole suite   < �aa *   s k i p   t h e   w h o l e   s u i t e��  ��  � L F (missing value = run test; text = skip suite; record = run/skip test)   � �bb �   ( m i s s i n g   v a l u e   =   r u n   t e s t ;   t e x t   =   s k i p   s u i t e ;   r e c o r d   =   r u n / s k i p   t e s t )��  ��  ��  � R      �zcd
�z .ascrerr ****      � ****c o      �y�y 0 etext eTextd �xef
�x 
errne o      �w�w 0 enumber eNumberf �vgh
�v 
erobg o      �u�u 0 efrom eFromh �tij
�t 
errti o      �s�s 
0 eto eToj �rk�q
�r 
ptlrk o      �p�p 0 epartial ePartial�q  � k  ?ll mnm n 8opo I  8�oq�n�o 0 	addbroken 	addBrokenq rsr m  tt �uu & c o n f i g u r e _ s k i p T e s t ss vwv m  xx �yy $ b r o k e   d u e   t o   e r r o rw z{z m  || �}}  { ~�m~ l 	2�l�k J  2�� ��j� J  0�� ��� m  �� ���   u n e x p e c t e d   e r r o r� ��i� n .��� I  #.�h��g�h .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o  #$�f�f 0 etext eText� ��� o  $%�e�e 0 enumber eNumber� ��� o  %&�d�d 0 efrom eFrom� ��� o  &'�c�c 
0 eto eTo� ��b� o  '(�a�a 0 epartial ePartial�b  �g  � o  #�`�` 0 _testsupport _TestSupport�i  �j  �l  �k  �m  �n  p o  �_�_ 0 _testreport _testReportn ��^� L  9?�� o  9>�]�] 0 _testreport _testReport�^  ��  ��  � ��� l DD�\���\  �   pre-test preparation   � ��� *   p r e - t e s t   p r e p a r a t i o n� ��� r  DK��� o  DE�[�[ 0 suiteobject suiteObject� o      �Z�Z $0 _testsuiteobject _testSuiteObject� ��� r  LS��� o  LM�Y�Y 0 handlername handlerName� o      �X�X $0 _testhandlername _testHandlerName� ��� l TT�W���W  �)# note: while `osatest` could supply a list of found handler names to check for existence of `configure_setUp` and `configure_tearDown`, that would only work for configure_setUp/configure_tearDown handlers defined directly within the suite script, not configure_setUp/configure_tearDown handlers inherited from a parent script; thus it's necessary to resort here to some undocumented hackery to determine existence of callable configure_setUp/configure_tearDown handlers before trying to call them (see also comments on `hasHandler` in TypeSupport)   � ���F   n o t e :   w h i l e   ` o s a t e s t `   c o u l d   s u p p l y   a   l i s t   o f   f o u n d   h a n d l e r   n a m e s   t o   c h e c k   f o r   e x i s t e n c e   o f   ` c o n f i g u r e _ s e t U p `   a n d   ` c o n f i g u r e _ t e a r D o w n ` ,   t h a t   w o u l d   o n l y   w o r k   f o r   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   d e f i n e d   d i r e c t l y   w i t h i n   t h e   s u i t e   s c r i p t ,   n o t   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   i n h e r i t e d   f r o m   a   p a r e n t   s c r i p t ;   t h u s   i t ' s   n e c e s s a r y   t o   r e s o r t   h e r e   t o   s o m e   u n d o c u m e n t e d   h a c k e r y   t o   d e t e r m i n e   e x i s t e n c e   o f   c a l l a b l e   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   b e f o r e   t r y i n g   t o   c a l l   t h e m   ( s e e   a l s o   c o m m e n t s   o n   ` h a s H a n d l e r `   i n   T y p e S u p p o r t )� ��� Z  T����V�U� n Tc��� I  Yc�T��S�T 0 
hashandler 
hasHandler� ��R� N  Y_�� n  Y^��� o  Z^�Q�Q "0 configure_setup configure_setUp� o  YZ�P�P 0 suiteobject suiteObject�R  �S  � o  TY�O�O 0 _support  � Q  f����� n in��� I  jn�N�M�L�N "0 configure_setup configure_setUp�M  �L  � o  ij�K�K 0 suiteobject suiteObject� R      �J��
�J .ascrerr ****      � ****� o      �I�I 0 etext eText� �H��
�H 
errn� o      �G�G 0 enumber eNumber� �F��
�F 
erob� o      �E�E 0 efrom eFrom� �D��
�D 
errt� o      �C�C 
0 eto eTo� �B��A
�B 
ptlr� o      �@�@ 0 epartial ePartial�A  � k  v��� ��� n v���� I  {��?��>�? 0 	addbroken 	addBroken� ��� m  {~�� ���  c o n f i g u r e _ s e t U p� ��� m  ~��� ��� $ b r o k e   d u e   t o   e r r o r� ��� m  ���� ���  � ��=� l 	����<�;� J  ���� ��:� J  ���� ��� m  ���� ���   u n e x p e c t e d   e r r o r� ��9� n ����� I  ���8��7�8 .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o  ���6�6 0 etext eText� ��� o  ���5�5 0 enumber eNumber� ��� o  ���4�4 0 efrom eFrom� ��� o  ���3�3 
0 eto eTo� ��2� o  ���1�1 0 epartial ePartial�2  �7  � o  ���0�0 0 _testsupport _TestSupport�9  �:  �<  �;  �=  �>  � o  v{�/�/ 0 _testreport _testReport� ��� r  ����� m  ���.
�. 
msng� o      �-�- $0 _testsuiteobject _testSuiteObject� ��,� L  ���� o  ���+�+ 0 _testreport _testReport�,  �V  �U  � ��� r  ����� n ����� I  ���*��)�*  0 makecallobject makeCallObject� ��� o  ���(�( 0 handlername handlerName� ��'� m  ���&�&  �'  �)  � o  ���%�% 0 _testsupport _TestSupport� o      �$�$ 0 
callobject 
callObject� ��� l ���#���#  �   do test   � ���    d o   t e s t� ��� Q  �   n �� I  ���"�!�" 0 dotest doTest  o  ��� �  0 suiteobject suiteObject � m  ���
� 
msng�  �!   o  ���� 0 
callobject 
callObject R      �	

� .ascrerr ****      � ****	 o      �� 0 etext eText
 �
� 
errn o      �� 0 enumber eNumber �
� 
erob o      �� 0 efrom eFrom �
� 
errt o      �� 
0 eto eTo ��
� 
ptlr o      �� 0 epartial ePartial�   l � Z  ��� H  �� l ���� F  �� =  �� o  ���� 0 enumber eNumber o  ���� 00 _abortedassertionerror _AbortedAssertionError = �� o  ���� 0 efrom eFrom o  ���
�
 00 _abortedassertiontoken _AbortedAssertionToken�  �   l � ! l �"#$" n �%&% I  ��	'��	 0 
addfailure 
addFailure' ()( o  ���� 0 handlername handlerName) *+* m  ��,, �-- j ( e . g .   e r r o r   i n   c o d e   b e i n g   t e s t e d / b u g   i n   t e s t   h a n d l e r )+ ./. m  ��00 �11  / 2�2 l 	�3��3 J  �44 5�5 J  �66 787 m  ��99 �::   u n e x p e c t e d   e r r o r8 ;�; n �<=< I  �>� � .0 makecaughterrorrecord makeCaughtErrorRecord> ?@? o  ���� 0 etext eText@ ABA o  ���� 0 enumber eNumberB CDC o  ���� 0 efrom eFromD EFE o  ���� 
0 eto eToF G��G o  ���� 0 epartial ePartial��  �   = o  ����� 0 _testsupport _TestSupport�  �  �  �  �  �  & o  ������ 0 _testreport _testReport#�� TO DO: without stack trace support, there's no way to distinguish an error raised by the code being tested versus an error caused by a bug in the test code, so we can only say error was 'unexpected' and leave user to figure out why; allowing `call_NAME` handlers to be used by `assert test result` would give users the opportunity to box up the code being tested allowing TestTools to distinguish the cause   $ �HH.   T O   D O :   w i t h o u t   s t a c k   t r a c e   s u p p o r t ,   t h e r e ' s   n o   w a y   t o   d i s t i n g u i s h   a n   e r r o r   r a i s e d   b y   t h e   c o d e   b e i n g   t e s t e d   v e r s u s   a n   e r r o r   c a u s e d   b y   a   b u g   i n   t h e   t e s t   c o d e ,   s o   w e   c a n   o n l y   s a y   e r r o r   w a s   ' u n e x p e c t e d '   a n d   l e a v e   u s e r   t o   f i g u r e   o u t   w h y ;   a l l o w i n g   ` c a l l _ N A M E `   h a n d l e r s   t o   b e   u s e d   b y   ` a s s e r t   t e s t   r e s u l t `   w o u l d   g i v e   u s e r s   t h e   o p p o r t u n i t y   t o   b o x   u p   t h e   c o d e   b e i n g   t e s t e d   a l l o w i n g   T e s t T o o l s   t o   d i s t i n g u i s h   t h e   c a u s e  � � check if failure was already reported, and this is the subsequent abort, in which case ignore; if not, it's an error in either the test_NAME handler or the code being tested, so report it   ! �IIx   c h e c k   i f   f a i l u r e   w a s   a l r e a d y   r e p o r t e d ,   a n d   t h i s   i s   t h e   s u b s e q u e n t   a b o r t ,   i n   w h i c h   c a s e   i g n o r e ;   i f   n o t ,   i t ' s   a n   e r r o r   i n   e i t h e r   t h e   t e s t _ N A M E   h a n d l e r   o r   t h e   c o d e   b e i n g   t e s t e d ,   s o   r e p o r t   i t�  �     test failed    �JJ    t e s t   f a i l e d� KLK l ��MN��  M   post-test clean up   N �OO &   p o s t - t e s t   c l e a n   u pL PQP Z  mRS����R n +TUT I  !+��V���� 0 
hashandler 
hasHandlerV W��W N  !'XX n  !&YZY o  "&���� (0 configure_teardown configure_tearDownZ o  !"���� 0 suiteobject suiteObject��  ��  U o  !���� 0 _support  S Q  .i[\][ n 16^_^ I  26�������� (0 configure_teardown configure_tearDown��  ��  _ o  12���� 0 suiteobject suiteObject\ R      ��`a
�� .ascrerr ****      � ****` o      ���� 0 etext eTexta ��bc
�� 
errnb o      ���� 0 enumber eNumberc ��de
�� 
erobd o      ���� 0 efrom eFrome ��fg
�� 
errtf o      ���� 
0 eto eTog ��h��
�� 
ptlrh o      ���� 0 epartial ePartial��  ] n >iiji I  Ci��k���� 0 	addbroken 	addBrokenk lml m  CFnn �oo $ c o n f i g u r e _ t e a r D o w nm pqp m  FIrr �ss $ b r o k e   d u e   t o   e r r o rq tut m  ILvv �ww  u x��x l 	Lcy����y J  Lczz {��{ J  La|| }~} m  LO ���   u n e x p e c t e d   e r r o r~ ���� n O_��� I  T_������� .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o  TU���� 0 etext eText� ��� o  UV���� 0 enumber eNumber� ��� o  VW���� 0 efrom eFrom� ��� o  WX���� 
0 eto eTo� ���� o  XY���� 0 epartial ePartial��  ��  � o  OT���� 0 _testsupport _TestSupport��  ��  ��  ��  ��  ��  j o  >C���� 0 _testreport _testReport��  ��  Q ��� r  nu��� m  no��
�� 
msng� o      ���� $0 _testsuiteobject _testSuiteObject� ���� l v|���� L  v|�� o  v{���� 0 _testreport _testReport��{ TO DO: wrapping all the test data (result values, error info, status, etc) in a script object and returning that preserves AS context info and AS types across the AE bridge; the script object can then be loaded into a new OSAID and its methods called to extract each bit of data in turn for formatting and final message generation  (caveat not sure what ocids and optrs will do)   � ����   T O   D O :   w r a p p i n g   a l l   t h e   t e s t   d a t a   ( r e s u l t   v a l u e s ,   e r r o r   i n f o ,   s t a t u s ,   e t c )   i n   a   s c r i p t   o b j e c t   a n d   r e t u r n i n g   t h a t   p r e s e r v e s   A S   c o n t e x t   i n f o   a n d   A S   t y p e s   a c r o s s   t h e   A E   b r i d g e ;   t h e   s c r i p t   o b j e c t   c a n   t h e n   b e   l o a d e d   i n t o   a   n e w   O S A I D   a n d   i t s   m e t h o d s   c a l l e d   t o   e x t r a c t   e a c h   b i t   o f   d a t a   i n   t u r n   f o r   f o r m a t t i n g   a n d   f i n a l   m e s s a g e   g e n e r a t i o n     ( c a v e a t   n o t   s u r e   w h a t   o c i d s   a n d   o p t r s   w i l l   d o )��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �   Unit Test Comparators   � ��� ,   U n i t   T e s t   C o m p a r a t o r s� ��� l     ��������  ��  ��  � ��� l     ������  �   result checking   � ���     r e s u l t   c h e c k i n g� ��� l     ��������  ��  ��  � ��� i  T W��� I     ������
�� .���:ExEqnull��� ��� null��  ��  � h     ����� (0 exactequalitycheck ExactEqualityCheck� i    ��� I      �������  0 compareobjects compareObjects� ��� o      ���� 0 expectederror expectedError� ���� o      ���� 0 actualerror actualError��  ��  � P     ���� k    �� ��� l   ������  � l f also check types are identical, e.g. if unittest indicates a real is expected then integer is a smell   � ��� �   a l s o   c h e c k   t y p e s   a r e   i d e n t i c a l ,   e . g .   i f   u n i t t e s t   i n d i c a t e s   a   r e a l   i s   e x p e c t e d   t h e n   i n t e g e r   i s   a   s m e l l� ��� Z   ������� >   ��� n    ��� m    ��
�� 
pcls� o    ���� 0 expectederror expectedError� n    ��� m   	 ��
�� 
pcls� o    	���� 0 actualerror actualError� L    �� m    ��
�� boovfals��  ��  � ���� L    �� =   ��� o    ���� 0 expectederror expectedError� o    ���� 0 actualerror actualError��  � ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  � ����
�� consnume��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  X [��� I     ������
�� .���:NmEqnull��� ��� null��  ��  � l    ���� h     ����� 00 numericalequalitycheck NumericalEqualityCheck� k      �� ��� j     ����� 0 _isequaldelta _isEqualDelta� m     �� >.�&֕� ���� i   ��� I      �������  0 compareobjects compareObjects� ��� o      ���� 0 expectederror expectedError� ���� o      ���� 0 actualerror actualError��  ��  � k     .�� ��� l     ������  � R L TO DO: needs to check if two integers, else if two reals, else return false   � ��� �   T O   D O :   n e e d s   t o   c h e c k   i f   t w o   i n t e g e r s ,   e l s e   i f   t w o   r e a l s ,   e l s e   r e t u r n   f a l s e� ��� Z    ������� >     ��� l    
������ I    
����
�� .corecnte****       ****� J     �� ��� o     ���� 0 expectederror expectedError�  ��  o    ���� 0 actualerror actualError��  � ����
�� 
kocl m    ��
�� 
nmbr��  ��  ��  � m   
 ���� � L     m    ��
�� boovfals��  ��  � �� l   . L    . F    -	 l   
��~
 A     \     o    �}�} 0 expectederror expectedError o    �|�| 0 _isequaldelta _isEqualDelta o    �{�{ 0 actualerror actualError�  �~  	 l  " +�z�y ?   " + [   " ) o   " #�x�x 0 expectederror expectedError o   # (�w�w 0 _isequaldelta _isEqualDelta o   ) *�v�v 0 actualerror actualError�z  �y  C= TO DO: FIX! (i.e. these calculations are incorrect: the min & max bounds need to be calculated as -9DP *relative* to the given value, otherwise 'imprecisely identical' large numbers will always compare as false while significantly different small numbers will always compare as true); see also Number library's TODOs    �z   T O   D O :   F I X !   ( i . e .   t h e s e   c a l c u l a t i o n s   a r e   i n c o r r e c t :   t h e   m i n   &   m a x   b o u n d s   n e e d   t o   b e   c a l c u l a t e d   a s   - 9 D P   * r e l a t i v e *   t o   t h e   g i v e n   v a l u e ,   o t h e r w i s e   ' i m p r e c i s e l y   i d e n t i c a l '   l a r g e   n u m b e r s   w i l l   a l w a y s   c o m p a r e   a s   f a l s e   w h i l e   s i g n i f i c a n t l y   d i f f e r e n t   s m a l l   n u m b e r s   w i l l   a l w a y s   c o m p a r e   a s   t r u e ) ;   s e e   a l s o   N u m b e r   l i b r a r y ' s   T O D O s��  ��  � ? 9 allows for limited precision when comparing real numbers   � � r   a l l o w s   f o r   l i m i t e d   p r e c i s i o n   w h e n   c o m p a r i n g   r e a l   n u m b e r s�  l     �u�t�s�u  �t  �s    l     �r�q�p�r  �q  �p    j   \ b�o�o .0 _defaultequalitycheck _defaultEqualityCheck I  \ a�n�m�l
�n .���:ExEqnull��� ��� null�m  �l    l     �k�j�i�k  �j  �i     l     �h�g�f�h  �g  �f    !"! l     �e#$�e  #  -----   $ �%% 
 - - - - -" &'& l     �d()�d  (   error checking   ) �**    e r r o r   c h e c k i n g' +,+ l     �c�b�a�c  �b  �a  , -.- l     �`/0�`  / � � TO DO: what about checking error record's properties are valid types (e.g. error number should be integer, message should be text, etc.), and fail test if not?   0 �11@   T O   D O :   w h a t   a b o u t   c h e c k i n g   e r r o r   r e c o r d ' s   p r o p e r t i e s   a r e   v a l i d   t y p e s   ( e . g .   e r r o r   n u m b e r   s h o u l d   b e   i n t e g e r ,   m e s s a g e   s h o u l d   b e   t e x t ,   e t c . ) ,   a n d   f a i l   t e s t   i f   n o t ?. 232 l     �_�^�]�_  �^  �]  3 454 i  c f676 I     �\�[8
�\ .���:ExErnull��� ��� null�[  8 �Z9�Y
�Z 
Usin9 |�X�W:�V;�X  �W  : o      �U�U ,0 errorattributechecks errorAttributeChecks�V  ; J      �T�T  �Y  7 l    r<=>< k     r?? @A@ Q     fBCDB k    PEE FGF r    HIH n   JKJ I    �SL�R�S &0 asrecordparameter asRecordParameterL MNM o    	�Q�Q ,0 errorattributechecks errorAttributeChecksN O�PO m   	 
PP �QQ 
 u s i n g�P  �R  K o    �O�O 0 _support  I o      �N�N ,0 errorattributechecks errorAttributeChecksG RSR r    3TUT K    1VV �MWX�M 0 errormessage errorMessageW o    �L�L .0 _defaultequalitycheck _defaultEqualityCheckX �KYZ�K 0 errornumber errorNumberY o    �J�J .0 _defaultequalitycheck _defaultEqualityCheckZ �I[\�I 0 	fromvalue 	fromValue[ o    #�H�H .0 _defaultequalitycheck _defaultEqualityCheck\ �G]^�G 0 totype toType] o   $ )�F�F .0 _defaultequalitycheck _defaultEqualityCheck^ �E_�D�E 0 partialresult partialResult_ o   * /�C�C .0 _defaultequalitycheck _defaultEqualityCheck�D  U o      �B�B :0 defaulterrorattributechecks defaultErrorAttributeChecksS `a` r   4 9bcb b   4 7ded o   4 5�A�A ,0 errorattributechecks errorAttributeCheckse o   5 6�@�@ :0 defaulterrorattributechecks defaultErrorAttributeChecksc o      �?�? 0 checkobjects checkObjectsa f�>f l  : Pghig Z  : Pjk�=�<j >   : Alml n   : =non 1   ; =�;
�; 
lengo o   : ;�:�: 0 checkobjects checkObjectsm n   = @pqp 1   > @�9
�9 
lengq o   = >�8�8 :0 defaulterrorattributechecks defaultErrorAttributeChecksk R   D L�7rs
�7 .ascrerr ****      � ****r m   J Ktt �uu � I n v a l i d    u s i n g    p a r a m e t e r   ( r e c o r d   c o n t a i n s   o n e   o r   m o r e   u n r e c o g n i z e d   p r o p e r t i e s ) .s �6vw
�6 
errnv m   F G�5�5�Yw �4x�3
�4 
erobx o   H I�2�2 ,0 errorattributechecks errorAttributeChecks�3  �=  �<  h � � (note: this doesn't bother to check each property's type or that each object has a �compareObjects� handler as any problems there will raise errors if/when those error attributes are checked)   i �yy�   ( n o t e :   t h i s   d o e s n ' t   b o t h e r   t o   c h e c k   e a c h   p r o p e r t y ' s   t y p e   o r   t h a t   e a c h   o b j e c t   h a s   a    c o m p a r e O b j e c t s    h a n d l e r   a s   a n y   p r o b l e m s   t h e r e   w i l l   r a i s e   e r r o r s   i f / w h e n   t h o s e   e r r o r   a t t r i b u t e s   a r e   c h e c k e d )�>  C R      �1z{
�1 .ascrerr ****      � ****z o      �0�0 0 etext eText{ �/|}
�/ 
errn| o      �.�. 0 enumber eNumber} �-~
�- 
erob~ o      �,�, 0 efrom eFrom �+��*
�+ 
errt� o      �)�) 
0 eto eTo�*  D I   X f�(��'�( 
0 _error  � ��� m   Y \�� ��� " e x a c t   e r r o r   c h e c k� ��� o   \ ]�&�& 0 etext eText� ��� o   ] ^�%�% 0 enumber eNumber� ��� o   ^ _�$�$ 0 efrom eFrom� ��#� o   _ `�"�" 
0 eto eTo�#  �'  A ��!� h   g r� ��  "0 exacterrorcheck ExactErrorCheck� i    ��� I      ����  0 compareobjects compareObjects� ��� o      �� 0 expectederror expectedError� ��� o      �� 0 actualerror actualError�  �  � k     ��� ��� l     ����  � � note: `assert test error` normalizes the `expectedError` record prior to calling compareObjects so it will always contain the following properties; any properties that were not supplied by the test script will contain the unique script object `NoValue`   � ����   n o t e :   ` a s s e r t   t e s t   e r r o r `   n o r m a l i z e s   t h e   ` e x p e c t e d E r r o r `   r e c o r d   p r i o r   t o   c a l l i n g   c o m p a r e O b j e c t s   s o   i t   w i l l   a l w a y s   c o n t a i n   t h e   f o l l o w i n g   p r o p e r t i e s ;   a n y   p r o p e r t i e s   t h a t   w e r e   n o t   s u p p l i e d   b y   t h e   t e s t   s c r i p t   w i l l   c o n t a i n   t h e   u n i q u e   s c r i p t   o b j e c t   ` N o V a l u e `� ��� X     ����� k   \ ��� ��� l  \ \����  � � � AS fun fact: using `set {a,b,c} to aRef` is hideously slow compared to `set {a,b,c} to contents of aRef` -- TO DO: figure out why   � ���   A S   f u n   f a c t :   u s i n g   ` s e t   { a , b , c }   t o   a R e f `   i s   h i d e o u s l y   s l o w   c o m p a r e d   t o   ` s e t   { a , b , c }   t o   c o n t e n t s   o f   a R e f `   - -   T O   D O :   f i g u r e   o u t   w h y� ��� r   \ u��� n   \ _��� 1   ] _�
� 
pcnt� o   \ ]�� 0 aref aRef� J      �� ��� o      �� $0 expectedproperty expectedProperty� ��� o      ��  0 actualproperty actualProperty� ��� o      �� 0 checkobject checkObject�  � ��� Z   v ������ >  v ��� o   v w�� $0 expectedproperty expectedProperty� n  w ~��� o   | ~�� 0 novalue NoValue� o   w |�� 0 _testsupport _TestSupport� Z  � �����
� =  � ���� n  � ���� I   � ��	���	  0 compareobjects compareObjects� ��� o   � ��� $0 expectedproperty expectedProperty� ��� o   � ���  0 actualproperty actualProperty�  �  � o   � ��� 0 checkobject checkObject� m   � ��
� boovfals� L   � ��� m   � ��
� boovfals�  �
  �  �  �  � 0 aref aRef� J    P�� ��� l 	  ��� � J    �� ��� n   ��� o    ���� 0 errornumber errorNumber� o    ���� 0 expectederror expectedError� ��� n   	��� o    	���� 0 errornumber errorNumber� o    ���� 0 actualerror actualError� ���� n   	 ��� o    ���� 0 errornumber errorNumber� o   	 ���� 0 checkobjects checkObjects��  �  �   � ��� l 	  !������ J    !�� ��� n   ��� o    ���� 0 errormessage errorMessage� o    ���� 0 expectederror expectedError� ��� n   ��� o    ���� 0 errormessage errorMessage� o    ���� 0 actualerror actualError� ���� n    ��� o    ���� 0 errormessage errorMessage� o    ���� 0 checkobjects checkObjects��  ��  ��  � ��� l 	 ! 0������ J   ! 0�� ��� n  ! $��� o   " $���� 0 	fromvalue 	fromValue� o   ! "���� 0 expectederror expectedError� ��� n  $ '��� o   % '���� 0 	fromvalue 	fromValue� o   $ %���� 0 actualerror actualError� ���� n   ' .��� o   , .���� 0 	fromvalue 	fromValue� o   ' ,���� 0 checkobjects checkObjects��  ��  ��  � ��� l 	 0 ?������ J   0 ?�� ��� n  0 3��� o   1 3���� 0 totype toType� o   0 1���� 0 expectederror expectedError� ��� n  3 6��� o   4 6���� 0 totype toType� o   3 4���� 0 actualerror actualError� ���� n   6 =��� o   ; =���� 0 totype toType� o   6 ;���� 0 checkobjects checkObjects��  ��  ��  �  ��  l 	 ? N���� l 
 ? N���� J   ? N  n  ? B o   @ B���� 0 partialresult partialResult o   ? @���� 0 expectederror expectedError 	 n  B E

 o   C E���� 0 partialresult partialResult o   B C���� 0 actualerror actualError	 �� n   E L o   J L���� 0 partialresult partialResult o   E J���� 0 checkobjects checkObjects��  ��  ��  ��  ��  ��  � �� L   � � m   � ���
�� boovtrue��  �!  = q k compare two �class ����� (expected/actual error records) for equality, ignoring any placeholder attributes   > � �   c o m p a r e   t w o   � c l a s s   �   � � �   ( e x p e c t e d / a c t u a l   e r r o r   r e c o r d s )   f o r   e q u a l i t y ,   i g n o r i n g   a n y   p l a c e h o l d e r   a t t r i b u t e s5  l     ��������  ��  ��    l     ��������  ��  ��    j   g o���� (0 _defaulterrorcheck _defaultErrorCheck I  g l������
�� .���:ExErnull��� ��� null��  ��    l     ��������  ��  ��    l     ��������  ��  ��    l     �� ��   J D--------------------------------------------------------------------     �!! � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "#" l     ��$%��  $   Unit Test Assertions    % �&& ,   U n i t   T e s t   A s s e r t i o n s  # '(' l     ��������  ��  ��  ( )*) i  p s+,+ I      ��-���� 20 _ascheckobjectparameter _asCheckObjectParameter- ./. o      ���� 0 checkobject checkObject/ 0��0 o      ���� (0 defaultcheckobject defaultCheckObject��  ��  , k     <11 232 Z    45����4 =    676 o     ���� 0 checkobject checkObject7 m    ��
�� 
msng5 r    	898 o    ���� (0 defaultcheckobject defaultCheckObject9 o      ���� 0 checkobject checkObject��  ��  3 :;: r    <=< n   >?> I    ��@���� &0 asscriptparameter asScriptParameter@ ABA o    ���� 0 checkobject checkObjectB C��C m    DD �EE 
 u s i n g��  ��  ? o    ���� 0 _support  = o      ���� 0 checkobject checkObject; FGF Z   9HI����H H    *JJ n   )KLK I   ! )��M���� 0 
hashandler 
hasHandlerM N��N N   ! %OO n   ! $PQP o   " $����  0 compareobjects compareObjectsQ o   ! "���� 0 checkobject checkObject��  ��  L o    !���� 0 _support  I R   - 5��RS
�� .ascrerr ****      � ****R m   3 4TT �UU � B a d    u s i n g    p a r a m e t e r   ( s c r i p t   o b j e c t   d o e s n  t   c o n t a i n   a    c o m p a r e O b j e c t s    h a n d l e r ) .S ��VW
�� 
errnV m   / 0�����@W ��X��
�� 
erobX o   1 2���� 0 checkobject checkObject��  ��  ��  G Y��Y L   : <ZZ o   : ;���� 0 checkobject checkObject��  * [\[ l     ��������  ��  ��  \ ]^] i  t w_`_ I      ��a���� .0 _compareassertresults _compareAssertResultsa bcb o      ���� 0 checkobject checkObjectc ded o      ����  0 expectedresult expectedResulte fgf o      ���� 0 actualresult actualResultg hih o      ���� 0 
assertname 
assertNamei j��j o      ���� 0 usernote userNote��  ��  ` Q     Cklmk L    nn n   
opo I    
��q����  0 compareobjects compareObjectsq rsr o    ����  0 expectedresult expectedResults t��t o    ���� 0 actualresult actualResult��  ��  p o    ���� 0 checkobject checkObjectl R      ��uv
�� .ascrerr ****      � ****u o      ���� 0 etext eTextv ��wx
�� 
errnw o      ���� 0 enumber eNumberx ��yz
�� 
eroby o      ���� 0 efrom eFromz ��{|
�� 
errt{ o      ���� 
0 eto eTo| ��}�
�� 
ptlr} o      �~�~ 0 epartial ePartial�  m k    C~~ � n   2��� I    2�}��|�} 0 	addbroken 	addBroken� ��� o    �{�{ 0 
assertname 
assertName� ��� m    �� ��� D b r o k e   d u e   t o   e r r o r   i n   c h e c k   o b j e c t� ��� o    �z�z 0 usernote userNote� ��y� l 	  .��x�w� J    .�� ��v� J    ,�� ��� m    �� ���   u n e x p e c t e d   e r r o r� ��u� n   *��� I   ! *�t��s�t .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o   ! "�r�r 0 etext eText� ��� o   " #�q�q 0 enumber eNumber� ��� o   # $�p�p 0 efrom eFrom� ��� o   $ %�o�o 
0 eto eTo� ��n� o   % &�m�m 0 epartial ePartial�n  �s  � o    !�l�l 0 _testsupport _TestSupport�u  �v  �x  �w  �y  �|  � o    �k�k 0 _testreport _testReport� ��j� R   3 C�i�h�
�i .ascrerr ****      � ****�h  � �g��
�g 
errn� o   5 :�f�f 00 _abortedassertionerror _AbortedAssertionError� �e��d
�e 
erob� o   ; @�c�c 00 _abortedassertiontoken _AbortedAssertionToken�d  �j  ^ ��� l     �b�a�`�b  �a  �`  � ��� l     �_���_  �  -----   � ��� 
 - - - - -� ��� l     �^�]�\�^  �]  �\  � ��� i  x {��� I     �[�Z�
�[ .���:AsRenull��� ��� null�Z  � �Y��
�Y 
Valu� o      �X�X 0 actualresult actualResult� �W��
�W 
Equa� o      �V�V  0 expectedresult expectedResult� �U��
�U 
Summ� |�T�S��R��T  �S  � o      �Q�Q 0 usernote userNote�R  � l     ��P�O� m      �� ���  �P  �O  � �N��M
�N 
Usin� |�L�K��J��L  �K  � o      �I�I 0 checkobject checkObject�J  � l     ��H�G� m      �F
�F 
msng�H  �G  �M  � k     ��� ��� Z    ���E�D� =    ��� o     �C�C $0 _testsuiteobject _testSuiteObject� m    �B
�B 
msng� R   
 �A��
�A .ascrerr ****      � ****� m    �� ��� d C a n n o t    a s s e r t   t e s t   r e s u l t    o u t s i d e   o f   u n i t   t e s t s .� �@��?
�@ 
errn� m    �>�>�T�?  �E  �D  � ��=� P    ����� k    ��� ��� Q    v���� k    8�� ��� r    *��� n   (��� I   " (�<��;�< "0 astextparameter asTextParameter� ��� o   " #�:�: 0 usernote userNote� ��9� m   # $�� ���  s u m m a r y�9  �;  � o    "�8�8 0 _support  � o      �7�7 0 usernote userNote� ��6� r   + 8��� I   + 6�5��4�5 20 _ascheckobjectparameter _asCheckObjectParameter� ��� o   , -�3�3 0 checkobject checkObject� ��2� o   - 2�1�1 .0 _defaultequalitycheck _defaultEqualityCheck�2  �4  � o      �0�0 0 checkobject checkObject�6  � R      �/��
�/ .ascrerr ****      � ****� o      �.�. 0 etext eText� �-��
�- 
errn� o      �,�, 0 enumber eNumber� �+��
�+ 
erob� o      �*�* 0 efrom eFrom� �)��
�) 
errt� o      �(�( 
0 eto eTo� �'��&
�' 
ptlr� o      �%�% 0 epartial ePartial�&  � k   @ v�� ��� n  @ a��� I   E a�$��#�$ 0 	addbroken 	addBroken� ��� m   E F�� �   $ a s s e r t   t e s t   r e s u l t�  m   F G � . r e c e i v e d   b a d   p a r a m e t e r s  o   G H�"�" 0 usernote userNote �! l 	 H [� � J   H [		 
�
 J   H Y  m   H I �   u n e x p e c t e d   e r r o r � n  I W I   N W��� .0 makecaughterrorrecord makeCaughtErrorRecord  o   N O�� 0 etext eText  o   O P�� 0 enumber eNumber  o   P Q�� 0 efrom eFrom  o   Q R�� 
0 eto eTo � o   R S�� 0 epartial ePartial�  �   o   I N�� 0 _testsupport _TestSupport�  �  �   �  �!  �#  � o   @ E�� 0 _testreport _testReport� � R   b v��
� .ascrerr ****      � ****�   � 
� 
errn o   d i�� 00 _abortedassertionerror _AbortedAssertionError  �!�
� 
erob! o   l q�� 00 _abortedassertiontoken _AbortedAssertionToken�  �  � "#" r   w �$%$ I   w ��
&�	�
 .0 _compareassertresults _compareAssertResults& '(' o   x y�� 0 checkobject checkObject( )*) o   y z��  0 expectedresult expectedResult* +,+ o   z {�� 0 actualresult actualResult, -.- m   { ~// �00 $ a s s e r t   t e s t   r e s u l t. 1�1 o   ~ �� 0 usernote userNote�  �	  % o      �� 0 isequal isEqual# 232 r   � �454 J   � �66 787 J   � �99 :;: m   � �<< �==  e x p e c t e d   r e s u l t; >�> o   � ���  0 expectedresult expectedResult�  8 ?� ? J   � �@@ ABA m   � �CC �DD  a c t u a l   r e s u l tB E��E o   � ����� 0 actualresult actualResult��  �   5 o      ���� 0 testdata testData3 F��F Z   � �GH��IG o   � ����� 0 isequal isEqualH k   � �JJ KLK n  � �MNM I   � ���O���� 0 
addsuccess 
addSuccessO PQP m   � �RR �SS $ a s s e r t   t e s t   r e s u l tQ TUT o   � ����� 0 usernote userNoteU V��V o   � ����� 0 testdata testData��  ��  N o   � ����� 0 _testreport _testReportL W��W L   � �����  ��  ��  I k   � �XX YZY n  � �[\[ I   � ���]���� 0 
addfailure 
addFailure] ^_^ m   � �`` �aa $ a s s e r t   t e s t   r e s u l t_ bcb m   � �dd �ee 2 r e c e i v e d   i n c o r r e c t   r e s u l tc fgf o   � ����� 0 usernote userNoteg h��h o   � ����� 0 testdata testData��  ��  \ o   � ����� 0 _testreport _testReportZ i��i R   � �����j
�� .ascrerr ****      � ****��  j ��kl
�� 
errnk o   � ����� 00 _abortedassertionerror _AbortedAssertionErrorl ��m��
�� 
erobm o   � ����� 00 _abortedassertiontoken _AbortedAssertionToken��  ��  ��  � ��n
�� conscasen ��o
�� consdiaco ��p
�� conshyphp ��q
�� conspuncq ����
�� conswhit��  � ����
�� consnume��  �=  � rsr l     ��������  ��  ��  s tut l     ��������  ��  ��  u vwv i  | xyx I     ����z
�� .���:AsErnull��� ��� null��  z ��{|
�� 
Hand{ |����}��~��  ��  } o      ���� "0 callhandlername callHandlerName��  ~ l     ���� m      �� ���  ��  ��  | ����
�� 
Args� |����������  ��  � o      ����  0 parametervalue parameterValue��  � l     ������ m      ��
�� 
���!��  ��  � ����
�� 
Equa� o      ���� 0 expectederror expectedError� ����
�� 
Summ� |����������  ��  � o      ���� 0 usernote userNote��  � l     ������ m      �� ���  ��  ��  � �����
�� 
Usin� |����������  ��  � o      ���� 0 checkobject checkObject��  � l     ������ m      ��
�� 
msng��  ��  ��  y k    R�� ��� Z    ������� =    ��� o     ���� $0 _testsuiteobject _testSuiteObject� m    ��
�� 
msng� R   
 ����
�� .ascrerr ****      � ****� m    �� ��� b C a n n o t    a s s e r t   t e s t   e r r o r    o u t s i d e   o f   u n i t   t e s t s .� �����
�� 
errn� m    �����T��  ��  ��  � ���� P   R���� k   Q�� ��� Q    ����� k    a�� ��� r    *��� n   (��� I   " (������� "0 astextparameter asTextParameter� ��� o   " #���� "0 callhandlername callHandlerName� ���� m   # $�� ���  i n��  ��  � o    "���� 0 _support  � o      ���� "0 callhandlername callHandlerName� ��� r   + 8��� n  + 6��� I   0 6������� &0 asrecordparameter asRecordParameter� ��� o   0 1���� 0 expectederror expectedError� ���� m   1 2�� ���  i s��  ��  � o   + 0���� 0 _support  � o      ���� 0 expectederror expectedError� ��� r   9 E��� n  9 C��� I   > C������� <0 normalizeexpectederrorrecord normalizeExpectedErrorRecord� ���� o   > ?���� 0 expectederror expectedError��  ��  � o   9 >���� 0 _testsupport _TestSupport� o      ���� 0 expectederror expectedError� ��� l  F F������  � � � TO DO: what about checking expectedError record's properties are valid types (e.g. error number should be integer, message should be text, etc.), and abort with broken test if not   � ���h   T O   D O :   w h a t   a b o u t   c h e c k i n g   e x p e c t e d E r r o r   r e c o r d ' s   p r o p e r t i e s   a r e   v a l i d   t y p e s   ( e . g .   e r r o r   n u m b e r   s h o u l d   b e   i n t e g e r ,   m e s s a g e   s h o u l d   b e   t e x t ,   e t c . ) ,   a n d   a b o r t   w i t h   b r o k e n   t e s t   i f   n o t� ��� r   F S��� n  F Q��� I   K Q������� "0 astextparameter asTextParameter� ��� o   K L���� 0 usernote userNote� ���� m   L M�� ���  s u m m a r y��  ��  � o   F K���� 0 _support  � o      ���� 0 usernote userNote� ���� r   T a��� I   T _������� 20 _ascheckobjectparameter _asCheckObjectParameter� ��� o   U V���� 0 checkobject checkObject� ���� o   V [���� (0 _defaulterrorcheck _defaultErrorCheck��  ��  � o      ���� 0 checkobject checkObject��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� ����
�� 
errt� o      ���� 
0 eto eTo� �����
�� 
ptlr� o      �� 0 epartial ePartial��  � k   i ��� ��� n  i ���� I   n ��~��}�~ 0 	addbroken 	addBroken� ��� m   n o�� ��� " a s s e r t   t e s t   e r r o r� ��� m   o r�� ��� . r e c e i v e d   b a d   p a r a m e t e r s� ��� o   r s�|�| 0 usernote userNote� ��{� l 	 s ���z�y� J   s ��� ��x� J   s �    m   s v �   u n e x p e c t e d   e r r o r �w n  v � I   { ��v�u�v .0 makecaughterrorrecord makeCaughtErrorRecord 	
	 o   { |�t�t 0 etext eText
  o   | }�s�s 0 enumber eNumber  o   } ~�r�r 0 efrom eFrom  o   ~ �q�q 
0 eto eTo �p o    ��o�o 0 epartial ePartial�p  �u   o   v {�n�n 0 _testsupport _TestSupport�w  �x  �z  �y  �{  �}  � o   i n�m�m 0 _testreport _testReport� �l R   � ��k�j
�k .ascrerr ****      � ****�j   �i
�i 
errn o   � ��h�h 00 _abortedassertionerror _AbortedAssertionError �g�f
�g 
erob o   � ��e�e 00 _abortedassertiontoken _AbortedAssertionToken�f  �l  �  l  � ��d�d   G A code-generate a script object to invoke the `call_NAME` handler�    � �   c o d e - g e n e r a t e   a   s c r i p t   o b j e c t   t o   i n v o k e   t h e   ` c a l l _ N A M E `   h a n d l e r &  P   � ��c Z   � � !"�b  =  � �#$# o   � ��a�a "0 callhandlername callHandlerName$ m   � �%% �&&  ! l  � �'()' r   � �*+* b   � �,-, m   � �.. �//  c a l l- l  � �0�`�_0 n   � �121 7  � ��^34
�^ 
ctxt3 m   � ��]�] 4 m   � ��\�\��2 o   � ��[�[ $0 _testhandlername _testHandlerName�`  �_  + o      �Z�Z "0 callhandlername callHandlerName( | v if `for` parameter is omitted, automatically call a `call_NAME` handler with the same NAME as the `test_NAME` handler   ) �55 �   i f   ` f o r `   p a r a m e t e r   i s   o m i t t e d ,   a u t o m a t i c a l l y   c a l l   a   ` c a l l _ N A M E `   h a n d l e r   w i t h   t h e   s a m e   N A M E   a s   t h e   ` t e s t _ N A M E `   h a n d l e r" 676 H   � �88 C   � �9:9 o   � ��Y�Y "0 callhandlername callHandlerName: m   � �;; �<< 
 c a l l _7 =�X= r   � �>?> b   � �@A@ m   � �BB �CC 
 c a l l _A o   � ��W�W "0 callhandlername callHandlerName? o      �V�V "0 callhandlername callHandlerName�X  �b  �c   �U�T
�U conscase�T   DED Z   �FG�SHF =  � �IJI o   � ��R�R  0 parametervalue parameterValueJ m   � ��Q
�Q 
���!G r   � �KLK n  � �MNM I   � ��PO�O�P  0 makecallobject makeCallObjectO PQP o   � ��N�N "0 callhandlername callHandlerNameQ R�MR m   � ��L�L  �M  �O  N o   � ��K�K 0 _testsupport _TestSupportL o      �J�J 0 
callobject 
callObject�S  H r   �STS n  �
UVU I  
�IW�H�I  0 makecallobject makeCallObjectW XYX o  �G�G "0 callhandlername callHandlerNameY Z�FZ m  �E�E �F  �H  V o   ��D�D 0 _testsupport _TestSupportT o      �C�C 0 
callobject 
callObjectE [\[ l �B]^�B  ]   �then call it   ^ �__    & t h e n   c a l l   i t\ `a` l >bcdb r  >efe J  "gg hih n jkj o  �A�A 0 novalue NoValuek o  �@�@ 0 _testsupport _TestSupporti lml n non o  �?�? 0 novalue NoValueo o  �>�> 0 _testsupport _TestSupportm p�=p m   �<
�< boovfals�=  f J      qq rsr o      �;�; 0 actualerror actualErrors tut o      �:�: 0 actualresult actualResultu v�9v o      �8�8 0 isequal isEqual�9  c \ V TO DO: rename isEqual to isSuccess once 'is equal' test code is moved to Check object   d �ww �   T O   D O :   r e n a m e   i s E q u a l   t o   i s S u c c e s s   o n c e   ' i s   e q u a l '   t e s t   c o d e   i s   m o v e d   t o   C h e c k   o b j e c ta xyx Q  ?zz{|z l BO}~} r  BO��� n BM��� I  CM�7��6�7 0 dotest doTest� ��� o  CH�5�5 $0 _testsuiteobject _testSuiteObject� ��4� o  HI�3�3  0 parametervalue parameterValue�4  �6  � o  BC�2�2 0 
callobject 
callObject� o      �1�1 0 actualresult actualResult~ n h note: this may return literal 'no value' due to AS's schlonky design - this will be accounted for below    ��� �   n o t e :   t h i s   m a y   r e t u r n   l i t e r a l   ' n o   v a l u e '   d u e   t o   A S ' s   s c h l o n k y   d e s i g n   -   t h i s   w i l l   b e   a c c o u n t e d   f o r   b e l o w{ R      �0��
�0 .ascrerr ****      � ****� o      �/�/ 0 etext eText� �.��
�. 
errn� o      �-�- 0 enumber eNumber� �,��
�, 
erob� o      �+�+ 0 efrom eFrom� �*��
�* 
errt� o      �)�) 
0 eto eTo� �(��'
�( 
ptlr� o      �&�& 0 epartial ePartial�'  | k  Wz�� ��� l WW�%���%  � y s compare expected vs actual error info, ignoring any actual error info that user-supplied record doesn't care about   � ��� �   c o m p a r e   e x p e c t e d   v s   a c t u a l   e r r o r   i n f o ,   i g n o r i n g   a n y   a c t u a l   e r r o r   i n f o   t h a t   u s e r - s u p p l i e d   r e c o r d   d o e s n ' t   c a r e   a b o u t� ��� r  Wi��� n Wg��� I  \g�$��#�$ .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o  \]�"�" 0 etext eText� ��� o  ]^�!�! 0 enumber eNumber� ��� o  ^_� �  0 efrom eFrom� ��� o  _`�� 
0 eto eTo� ��� o  `a�� 0 epartial ePartial�  �#  � o  W\�� 0 _testsupport _TestSupport� o      �� 0 actualerror actualError� ��� r  jz��� I  jx���� .0 _compareassertresults _compareAssertResults� ��� o  kl�� 0 checkobject checkObject� ��� o  lm�� 0 expectederror expectedError� ��� o  mn�� 0 actualerror actualError� ��� m  nq�� ��� " a s s e r t   t e s t   e r r o r� ��� o  qr�� 0 usernote userNote�  �  � o      �� 0 isequal isEqual�  y ��� r  {���� J  {��� ��� J  {��� ��� m  {~�� ���  e x p e c t e d   e r r o r� ��� o  ~�� 0 expectederror expectedError�  �  � o      �� 0 testdata testData� ��� Z  �Q����� o  ���� 0 isequal isEqual� l ������ k  ���� ��� n ����� I  ���
��	�
 0 
addsuccess 
addSuccess� ��� m  ���� ��� " a s s e r t   t e s t   e r r o r� ��� o  ���� 0 usernote userNote� ��� b  ����� o  ���� 0 testdata testData� J  ���� ��� J  ���� ��� m  ���� ���  a c t u a l   e r r o r� ��� o  ���� 0 actualerror actualError�  �  �  �	  � o  ���� 0 _testreport _testReport� ��� L  ��� �   �  �   success   � ���    s u c c e s s�  � l �Q���� k  �Q�� ��� Q  ������ l ������ l ������ r  ����� o  ������ 0 actualresult actualResult� o      ���� 0 actualresult actualResult� � z this variable lookup fails if call_NAME returned nothing (i.e. `null`, which AS literally treats as 'no value at all')...   � ��� �   t h i s   v a r i a b l e   l o o k u p   f a i l s   i f   c a l l _ N A M E   r e t u r n e d   n o t h i n g   ( i . e .   ` n u l l ` ,   w h i c h   A S   l i t e r a l l y   t r e a t s   a s   ' n o   v a l u e   a t   a l l ' ) . . .� g a kludge-around for AS's dumb commands-are-not-expressions-so-do-not-have-to-return-results design   � ��� �   k l u d g e - a r o u n d   f o r   A S ' s   d u m b   c o m m a n d s - a r e - n o t - e x p r e s s i o n s - s o - d o - n o t - h a v e - t o - r e t u r n - r e s u l t s   d e s i g n� R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      ����
���  � l ������ r  ����� n ����� o  ������ 0 novalue NoValue� o  ������ 0 _testsupport _TestSupport� o      ���� 0 actualresult actualResult� a [ ... in which case replace it with a 'no value placeholder' object that AS can actually see   � �   �   . . .   i n   w h i c h   c a s e   r e p l a c e   i t   w i t h   a   ' n o   v a l u e   p l a c e h o l d e r '   o b j e c t   t h a t   A S   c a n   a c t u a l l y   s e e�  Z ������ > �� o  ������ 0 actualerror actualError n �� o  ������ 0 novalue NoValue o  ������ 0 _testsupport _TestSupport r  ��	
	 J  ��  m  �� � 0 r e c e i v e d   i n c o r r e c t   e r r o r �� b  �� o  ������ 0 testdata testData J  �� �� J  ��  m  �� �  a c t u a l   e r r o r �� o  ������ 0 actualerror actualError��  ��  ��  
 J        o      ���� 0 problemtype problemType �� o      ���� 0 testdata testData��  ��  ��     Z �*!"����! > �#$# o  ������ 0 actualresult actualResult$ n � %&% o  � ���� 0 novalue NoValue& o  ������ 0 _testsupport _TestSupport" r  &'(' J  )) *+* m  ,, �-- " r e c e i v e d   n o   e r r o r+ .��. b  /0/ o  ���� 0 testdata testData0 J  11 2��2 J  33 454 m  66 �77 " u n e x p e c t e d   r e s u l t5 8��8 o  ���� 0 actualresult actualResult��  ��  ��  ( J      99 :;: o      ���� 0 problemtype problemType; <��< o      ���� 0 testdata testData��  ��  ��    =>= n +<?@? I  0<��A���� 0 
addfailure 
addFailureA BCB m  03DD �EE " a s s e r t   t e s t   e r r o rC FGF o  34���� 0 problemtype problemTypeG HIH o  45���� 0 usernote userNoteI J��J o  56���� 0 testdata testData��  ��  @ o  +0���� 0 _testreport _testReport> K��K R  =Q����L
�� .ascrerr ****      � ****��  L ��MN
�� 
errnM o  ?D���� 00 _abortedassertionerror _AbortedAssertionErrorN ��O��
�� 
erobO o  GL���� 00 _abortedassertiontoken _AbortedAssertionToken��  ��  � 2 , raised wrong error or didn't raise an error   � �PP X   r a i s e d   w r o n g   e r r o r   o r   d i d n ' t   r a i s e   a n   e r r o r�  � ��Q
�� conscaseQ ��R
�� consdiacR ��S
�� conshyphS ��T
�� conspuncT ����
�� conswhit��  � ����
�� consnume��  ��  w UVU l     ��������  ��  ��  V WXW l     ��������  ��  ��  X Y��Y l     ��������  ��  ��  ��       ��Z[\]^_`��a��������bcdefghijk��  Z ��������������������������������������������
�� 
pimr�� 0 _support  �� 
0 _error  �� 0 _testsupport _TestSupport�� 0 
randomword 
randomWord
�� .���:MTmrnull��� ��� ctxt�� 00 _abortedassertionerror _AbortedAssertionError�� 00 _abortedassertiontoken _AbortedAssertionToken�� $0 _testsuiteobject _testSuiteObject�� 0 _testreport _testReport�� $0 _testhandlername _testHandlerName�� 0 
_skipsuite 
_SKIPSUITE�� 0 __performunittestforsuite__  
�� .���:ExEqnull��� ��� null
�� .���:NmEqnull��� ��� null�� .0 _defaultequalitycheck _defaultEqualityCheck
�� .���:ExErnull��� ��� null�� (0 _defaulterrorcheck _defaultErrorCheck�� 20 _ascheckobjectparameter _asCheckObjectParameter�� .0 _compareassertresults _compareAssertResults
�� .���:AsRenull��� ��� null
�� .���:AsErnull��� ��� null[ ��l�� l  mnm ��o��
�� 
cobjo pp   �� 
�� 
frmk��  n ��q��
�� 
cobjq rr   ��
�� 
osax��  \ ss   �� -
�� 
scpt] �� 5����tu���� 
0 _error  �� ��v�� v  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  t ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTou  E������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+ ^ ww   �� \
�� 
scpt_ �� r����xy���� 0 
randomword 
randomWord�� ��z�� z  ��~� 0 	minlength 	minLength�~ 0 	maxlength 	maxLength��  x �}�|�{�} 0 	minlength 	minLength�| 0 	maxlength 	maxLength�{ 0 s  y  �z�y�x�w�v ��u
�z misccura
�y 
from
�x 
to  �w 
�v .sysorandnmbr    ��� nmbr
�u 
cobj�� (�E�O � *��� Ukh���.%E�[OY��O�` �t ��s�r{|�q
�t .���:MTmrnull��� ��� ctxt�s {�p�o ��p 0 nametext nameText�o  �r  { �n�m�n 0 nametext nameText�m 0 timerobject TimerObject| �l �}�l 0 timerobject TimerObject} �k~�j�i��h
�k .ascrinit****      � ****~ k     '��  ���  ���  ���  ���  ���  ���  ��� �� �g�g  �j  �i   	�f�e�d�c�b�a�`�_�^
�f 
pimr�e 0 
_starttime 
_startTime�d 0 _totalseconds _totalSeconds�c 0 
_isrunning 
_isRunning�b 0 	timername 	timerName�a 0 
starttimer 
startTimer�` 0 	stoptimer 	stopTimer�_ 0 elapsedtime elapsedTime�^ 0 	totaltime 	totalTime� �]�\ ��[�Z ��Y�X�����
�] 
cobj
�\ 
frmk
�[ 
msng�Z 0 
_starttime 
_startTime�Y 0 _totalseconds _totalSeconds�X 0 
_isrunning 
_isRunning� �W ��V�U���T�W 0 	timername 	timerName�V  �U  �  �  �T b   � �S ��R�Q���P�S 0 
starttimer 
startTimer�R  �Q  �  � �O�N�M
�O misccura�N 0 nsdate NSDate�M @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�P (b   hY hOeEc  O��,j+ Ec  O)� �L ��K�J���I�L 0 	stoptimer 	stopTimer�K  �J  � �H�H 0 elapsedtime elapsedTime� �G�F�E
�G misccura�F 0 nsdate NSDate�E @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�I 9b   jY hO��,j+ b  E�Ob  �Ec  OfEc  O�� �D�C�B���A�D 0 elapsedtime elapsedTime�C  �B  � �@�@ 0 nsdate NSDate� �?�? @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�A b   �j+  b  Y j� �>�=�<���;�> 0 	totaltime 	totalTime�=  �<  �  � �:�: 0 elapsedtime elapsedTime�; b   b  *j+  Y b  �h (�*��/lkv��O�Of�OL OL 	OL 
OL OL �q ��K S���Aa �9@  ��9 00 _abortedassertiontoken _AbortedAssertionToken�  ��  
�� 
msng
�� 
msng
�� 
msng�� cb �8��7�6���5�8 0 __performunittestforsuite__  �7 �4��4 �  �3��3 0 suiteobject suiteObject� �2��2 �  �1�0�/�1 0 	suitename 	suiteName�0 0 handlername handlerName�/ 0 isstyled isStyled�6  � �.�-�,�+�*�)�(�'�&�%�$�#�. 0 suiteobject suiteObject�- 0 	suitename 	suiteName�, 0 handlername handlerName�+ 0 isstyled isStyled�* 0 skipinfo skipInfo�) 0 
skipreason 
skipReason�( 0 etext eText�' 0 enumber eNumber�& 0 efrom eFrom�% 
0 eto eTo�$ 0 epartial ePartial�# 0 
callobject 
callObject� 6�"�!� ��������������������L���tx|����
�	��������,09��nrv�"  0 maketestreport makeTestReport�! *0 configure_skiptests configure_skipTests�  0 
hashandler 
hasHandler�  � ��� 
� 
errn��?�   
� 
errn��?
� 
erob
� 
errt
� 
reco
� 
ctxt
� 
msng� � 0 istype isType
� misccura� 0 nsdictionary NSDictionary� 60 dictionarywithdictionary_ dictionaryWithDictionary_� 0 objectforkey_ objectForKey_
� 
****� ������
�� 
errn���\��  ��\� 0 
addskipped 
addSkipped� 0 	skipsuite 	skipSuite� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� �����
�� 
errt�� 
0 eto eTo� ������
�� 
ptlr�� 0 epartial ePartial��  � � .0 makecaughterrorrecord makeCaughtErrorRecord�
 �	 0 	addbroken 	addBroken� "0 configure_setup configure_setUp�  0 makecallobject makeCallObject� 0 dotest doTest
� 
bool� 0 
addfailure 
addFailure� (0 configure_teardown configure_tearDown�5}b  ���m+  Ec  	Ob  ��,k+ ! �j+ E�O �E�W X  )�������mv��Ob  	O�� �b  ��l+  _�a ,�k+ �k+ a &E�O�� ? 
��&E�W X  )�a ����lv�a �%a %Ob  	��l+ Ob  	Y hY @�� 9 
��&E�W X  )�a �����mv�a Ob  	�k+ Ob  	Y hY hW 9X  b  	a a a a  b  �����a !+ "lvkva #+ $Ob  	Y hO�Ec  O�Ec  
Ob  �a %,k+  O 
�j+ %W AX  b  	a &a 'a (a )b  �����a !+ "lvkva #+ $O�Ec  Ob  	Y hOb  �jl+ *E�O ���l+ +W MX  �b   	 �b   a ,& .b  	�a -a .a /b  �����a !+ "lvkva #+ 0Y hOb  �a 1,k+  @ 
�j+ 1W 2X  b  	a 2a 3a 4a 5b  �����a !+ "lvkva #+ $Y hO�Ec  Ob  	c �����������
�� .���:ExEqnull��� ��� null��  ��  � ���� (0 exactequalitycheck ExactEqualityCheck� ������ (0 exactequalitycheck ExactEqualityCheck� �����������
�� .ascrinit****      � ****� k     �� �����  ��  ��  � ����  0 compareobjects compareObjects� �� �������������  0 compareobjects compareObjects�� ����� �  ������ 0 expectederror expectedError�� 0 actualerror actualError��  � ������ 0 expectederror expectedError�� 0 actualerror actualError� ����
�� 
pcls�� �� ��,��, fY hO�� V�� L  �� ��K S�d �����������
�� .���:NmEqnull��� ��� null��  ��  � ���� 00 numericalequalitycheck NumericalEqualityCheck� ������ 00 numericalequalitycheck NumericalEqualityCheck� �����������
�� .ascrinit****      � ****� k     �� ��� �����  ��  ��  � ������ 0 _isequaldelta _isEqualDelta��  0 compareobjects compareObjects� ������ 0 _isequaldelta _isEqualDelta� �������������  0 compareobjects compareObjects�� ����� �  ������ 0 expectederror expectedError�� 0 actualerror actualError��  � ������ 0 expectederror expectedError�� 0 actualerror actualError� ��������
�� 
kocl
�� 
nmbr
�� .corecnte****       ****
�� 
bool�� /��lv��l l fY hO�b   �	 �b   ��&�� �OL �� ��K S�e ���  ��� (0 exactequalitycheck ExactEqualityCheck� ������  f ��7��������
�� .���:ExErnull��� ��� null��  �� �����
�� 
Usin� {�������� ,0 errorattributechecks errorAttributeChecks��  ��  ��  � ������������������ ,0 errorattributechecks errorAttributeChecks�� :0 defaulterrorattributechecks defaultErrorAttributeChecks�� 0 checkobjects checkObjects�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� "0 exacterrorcheck ExactErrorCheck� P������������������������t�������������� &0 asrecordparameter asRecordParameter�� 0 errormessage errorMessage�� 0 errornumber errorNumber�� 0 	fromvalue 	fromValue�� 0 totype toType�� 0 partialresult partialResult�� 

�� 
leng
�� 
errn���Y
�� 
erob�� �� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� "0 exacterrorcheck ExactErrorCheck� �����������
�� .ascrinit****      � ****� k     �� �����  ��  ��  � ����  0 compareobjects compareObjects� �� �������������  0 compareobjects compareObjects�� ����� �  ������ 0 expectederror expectedError�� 0 actualerror actualError��  � �������������� 0 expectederror expectedError�� 0 actualerror actualError�� 0 aref aRef�� $0 expectedproperty expectedProperty��  0 actualproperty actualProperty�� 0 checkobject checkObject� ��������������~�}�|�{�z�� 0 errornumber errorNumber�� 0 errormessage errorMessage�� 0 	fromvalue 	fromValue�� 0 totype toType�� 0 partialresult partialResult�� 
� 
kocl
�~ 
cobj
�} .corecnte****       ****
�| 
pcnt�{ 0 novalue NoValue�z  0 compareobjects compareObjects�� � ���,��,b  �,mv��,��,b  �,mv��,��,b  �,mv��,��,b  �,mv��,��,b  �,mv�v[��l kh ��,E[�k/E�Z[�l/E�Z[�m/E�ZO�b  �, ���l+ f  fY hY h[OY��Oe�� L  �� s Rb  ��l+ E�O�b  �b  �b  �b  �b  �E�O��%E�O��,��, )�����Y hW X  *a ����a + Oa a K S�g �y�  ��y "0 exacterrorcheck ExactErrorCheck� ���� 
 �����x�w�v�ug� �t�s�t  �s  � �re��r 0 errormessage errorMessage� �qe��q 0 errornumber errorNumber� �pe��p 0 	fromvalue 	fromValue� �oe��o 0 totype toType� �ne�m�n 0 partialresult partialResult�m  �x  �w  �v  �u  h �l,�k�j���i�l 20 _ascheckobjectparameter _asCheckObjectParameter�k �h��h �  �g�f�g 0 checkobject checkObject�f (0 defaultcheckobject defaultCheckObject�j  � �e�d�e 0 checkobject checkObject�d (0 defaultcheckobject defaultCheckObject� 
�cD�b�a�`�_�^�]�\T
�c 
msng�b &0 asscriptparameter asScriptParameter�a  0 compareobjects compareObjects�` 0 
hashandler 
hasHandler
�_ 
errn�^�@
�] 
erob�\ �i =��  �E�Y hOb  ��l+ E�Ob  ��,k+  )�����Y hO�i �[`�Z�Y���X�[ .0 _compareassertresults _compareAssertResults�Z �W��W �  �V�U�T�S�R�V 0 checkobject checkObject�U  0 expectedresult expectedResult�T 0 actualresult actualResult�S 0 
assertname 
assertName�R 0 usernote userNote�Y  � 
�Q�P�O�N�M�L�K�J�I�H�Q 0 checkobject checkObject�P  0 expectedresult expectedResult�O 0 actualresult actualResult�N 0 
assertname 
assertName�M 0 usernote userNote�L 0 etext eText�K 0 enumber eNumber�J 0 efrom eFrom�I 
0 eto eTo�H 0 epartial ePartial� �G�F����E�D�C�B�A�@�G  0 compareobjects compareObjects�F 0 etext eText� �?�>�
�? 
errn�> 0 enumber eNumber� �=�<�
�= 
erob�< 0 efrom eFrom� �;�:�
�; 
errt�: 
0 eto eTo� �9�8�7
�9 
ptlr�8 0 epartial ePartial�7  �E �D .0 makecaughterrorrecord makeCaughtErrorRecord�C �B 0 	addbroken 	addBroken
�A 
errn
�@ 
erob�X D ���l+  W 7X  b  	���b  ������+ lvkv�+ O)�b  �b  �hj �6��5�4���3
�6 .���:AsRenull��� ��� null�5  �4 �2�1�
�2 
Valu�1 0 actualresult actualResult� �0�/�
�0 
Equa�/  0 expectedresult expectedResult� �.��
�. 
Summ� {�-�,��- 0 usernote userNote�,  � �+��*
�+ 
Usin� {�)�(�'�) 0 checkobject checkObject�(  
�' 
msng�*  � �&�%�$�#�"�!� �����& 0 actualresult actualResult�%  0 expectedresult expectedResult�$ 0 usernote userNote�# 0 checkobject checkObject�" 0 etext eText�! 0 enumber eNumber�  0 efrom eFrom� 
0 eto eTo� 0 epartial ePartial� 0 isequal isEqual� 0 testdata testData� �����������������/�<CR�`d�
� 
msng
� 
errn��T� "0 astextparameter asTextParameter� 20 _ascheckobjectparameter _asCheckObjectParameter� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ��
�
� 
erob�
 0 efrom eFrom� �	��
�	 
errt� 
0 eto eTo� ���
� 
ptlr� 0 epartial ePartial�  � � .0 makecaughterrorrecord makeCaughtErrorRecord� � 0 	addbroken 	addBroken
� 
erob� .0 _compareassertresults _compareAssertResults� 0 
addsuccess 
addSuccess� 0 
addfailure 
addFailure�3 �b  �  )��l�Y hO�� �  b  ��l+ E�O*�b  l+ E�W =X 	 
b  	���b  ������+ lvkva + O)�b  a b  a hO*���a ��+ E�Oa �lva �lvlvE�O� b  	a ��m+ OhY *b  	a a ��a + O)�b  a b  a hVk �y�����
� .���:AsErnull��� ��� null�  � � ��
�  
Hand� {������� "0 callhandlername callHandlerName��  � ����
�� 
Args� {��������  0 parametervalue parameterValue��  
�� 
���!� �����
�� 
Equa�� 0 expectederror expectedError� ����
�� 
Summ� {������� 0 usernote userNote��  � �����
�� 
Usin� {�������� 0 checkobject checkObject��  
�� 
msng��  � ���������������������������������� "0 callhandlername callHandlerName��  0 parametervalue parameterValue�� 0 expectederror expectedError�� 0 usernote userNote�� 0 checkobject checkObject�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 epartial ePartial�� 0 
callobject 
callObject�� 0 actualerror actualError�� 0 actualresult actualResult�� 0 isequal isEqual�� 0 testdata testData�� 0 problemtype problemType� 0�����������������������������������%.��;B���������������������,6D��
�� 
msng
�� 
errn���T�� "0 astextparameter asTextParameter�� &0 asrecordparameter asRecordParameter�� <0 normalizeexpectederrorrecord normalizeExpectedErrorRecord�� 20 _ascheckobjectparameter _asCheckObjectParameter�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� �����
�� 
errt�� 
0 eto eTo� ������
�� 
ptlr�� 0 epartial ePartial��  �� �� .0 makecaughterrorrecord makeCaughtErrorRecord�� �� 0 	addbroken 	addBroken
�� 
erob
�� 
ctxt
�� 
���!��  0 makecallobject makeCallObject�� 0 novalue NoValue
�� 
cobj�� 0 dotest doTest�� .0 _compareassertresults _compareAssertResults�� 0 
addsuccess 
addSuccess��  � ������
�� 
errn���?��  �� 0 
addfailure 
addFailure�Sb  �  )��l�Y hO��: Ib  ��l+ E�Ob  ��l+ 	E�Ob  �k+ 
E�Ob  ��l+ E�O*�b  l+ E�W CX  b  	�a �a b  �����a + lvkva + O)�b  a b  a hOga  ;�a   a b  
[a \[Za \Zi2%E�Y �a  a �%E�Y hVO�a   b  �jl+ E�Y b  �kl+ E�Ob  a ,b  a ,fmvE[a  k/E�Z[a  l/E�Z[a  m/E�ZO �b  �l+ !E�W *X  b  �����a + E�O*���a "�a + #E�Oa $�lvkvE�O� b  	a %��a &�lvkv%m+ 'OhY � �E�W X ( )b  a ,E�O�b  a , 'a *�a +�lvkv%lvE[a  k/E�Z[a  l/E�ZY hO�b  a , 'a ,�a -�lvkv%lvE[a  k/E�Z[a  l/E�ZY hOb  	a .���a + /O)�b  a b  a hVascr  ��ޭ