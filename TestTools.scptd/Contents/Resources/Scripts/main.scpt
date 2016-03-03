FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� TestTools -- unit testing framework and other testing/profiling tools

About:

- TestTools's unit testing framework takes a NAME.unittest.scpt file containing one or more script objects, each representing a test suite, and each of those script objects containing one or more handlers representing individual unit tests. Test suite scripts must have `suite_` name prefixes; test handlers within those scripts must have `test_` name prefixes.

- The command line `osatest` test runner introspects the unittest script to obtain all suite and test names. For each found test it creates a new AppleScript component instance (interpreter), loads a clean copy of the unittest script into it, then calls [indirectly] TestTools's `__performunittestforsuite__` handler to run that test. The resulting `TestReport` object is then returned to `osatest` to finish generating the report for that test and print it.

Notes:

- Saving unittest scripts as compiled `.scpt` files rather than `.applescript` snippets avoids any risk of test scripts not compiling correctly when run by `osatest` - i.e. it's one less thing to go wrong.

- The `.unittest.scpt[d]` suffix is a convention, not a requirement, but is strongly encouraged. e.g. Future improvements to `osatest` may include the ability to search a library script bundle for any embedded unittest files and run them all automatically.

- `assert` command names are intentionally verbose, to minimize risk of collisions with keywords in other libraries, apps, etc.


TO DO:

- There is a problem with `do shell script` command in `run unit tests` sometimes aborting mid-run with error 1011 (dsMixedModeFailure?) when running date.unittest.scpt file directly in SE. No idea why; osatest output is normal up to the point it starts generating report, and the error code isn't being returned by osatest process itself, which implies something in OSA/AS is causing osatest process to exit() unexpectedly. Note that error appears/disappears when unittest and/or TestTools code is altered (e.g. when inserting debugging code to locate the point of failure), i.e. Heisenbug; it appears to be 100% repeatable, but not easily reproducible (at a guess, something in the .scpt bytecode is tickling a bug deep down in AS, possibly at a point where 68k/PPC/i386/x86_64 translations occur). Lastly, the problem has not to date manifested when running osatest in Terminal, so if it persists the best solution would be to remove the `run unit tests` handler and require users to run unit tests via Terminal only (although this is less convenient than running in SE during test development).


- assert command notes don't currently appear in report except when an assert command reports a fail; should osatest provide a `--verbose` option that displays all test report information?

- should `assert test result` support optional `in` and `with parameter` as an alternative to using `for` should user wish to isolate the operation being tested in a `call_NAME` handler? (A. probably not: it makes the API more complex and confusing; user can always wrap the `assert test result` command in a `try` block that catches errors and reports them via `assert test failed`)

- options for automatically spiking TIDs and considering/ignoring options before calling `test_NAME` handler; also, what about an option for composing/decomposing unicode (while AS ignores differences, NSString-based code may be sensitive to this); note that localization is harder to spike, but should be done if possible as it affects date and number coercions


- what other check objects should be defined as standard? e.g.:

	- `text equality check [considering/ignoring OPTIONS]` (note that whitespace should be normalized rather than ignored completely)
	
	- `exact type check` (checks only that the expected and actual values are of the same type; relatively weak, but still potentially of some use when checking, say, e.g. that actual errorNumber is `integer` and actual errorMessage is `text`)
	
	- `ASObjC equality check`(checks both values are ocid specifiers then compares them using `-isEqual:`),
	
	- `text pattern check` (allow wildcard/regexp checking, possibly applying additional check objects to wildcard-matched ranges; this could be useful e.g. when checking error messages where some parts of the message may vary - e.g. disk and home folder names in file paths - so should be either ignored or custom-checked but the rest of the message is constant); also, how might multiple checks be usefully composed? (e.g. currently the `exact error check` constructor optionally accepts an record of one or more equality checkers for customizing how specific error attributes are checked)
	
	- 'set equality' check that takes two lists and checks both contain same items, though not necessarily in same order

	- how to provide partial/pattern matching based checks of error messages? (e.g. might want to normalize case and whitespace before comparison; it'd also be handy if a reusable handler could be written that checks library and handler name are correct)


- should `assert test error` automatically check error record's properties are valid types (e.g. error number should be integer, message should be text, etc.), and fail test if not?

- how to indicate mismatched error attribute in ExactErrorCheck? (currently the `compareObjects` handler signature only allows for returning true/false, and cannot [and should not] write messages to TestReport object itself; should it also be allowed to return a {isEqual:BOOL,messageText:TEXT} record, or is there any better alternative?)

      � 	 	+�   T e s t T o o l s   - -   u n i t   t e s t i n g   f r a m e w o r k   a n d   o t h e r   t e s t i n g / p r o f i l i n g   t o o l s 
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
 -   ` a s s e r t `   c o m m a n d   n a m e s   a r e   i n t e n t i o n a l l y   v e r b o s e ,   t o   m i n i m i z e   r i s k   o f   c o l l i s i o n s   w i t h   k e y w o r d s   i n   o t h e r   l i b r a r i e s ,   a p p s ,   e t c . 
 
 
 T O   D O : 
 
 -   T h e r e   i s   a   p r o b l e m   w i t h   ` d o   s h e l l   s c r i p t `   c o m m a n d   i n   ` r u n   u n i t   t e s t s `   s o m e t i m e s   a b o r t i n g   m i d - r u n   w i t h   e r r o r   1 0 1 1   ( d s M i x e d M o d e F a i l u r e ? )   w h e n   r u n n i n g   d a t e . u n i t t e s t . s c p t   f i l e   d i r e c t l y   i n   S E .   N o   i d e a   w h y ;   o s a t e s t   o u t p u t   i s   n o r m a l   u p   t o   t h e   p o i n t   i t   s t a r t s   g e n e r a t i n g   r e p o r t ,   a n d   t h e   e r r o r   c o d e   i s n ' t   b e i n g   r e t u r n e d   b y   o s a t e s t   p r o c e s s   i t s e l f ,   w h i c h   i m p l i e s   s o m e t h i n g   i n   O S A / A S   i s   c a u s i n g   o s a t e s t   p r o c e s s   t o   e x i t ( )   u n e x p e c t e d l y .   N o t e   t h a t   e r r o r   a p p e a r s / d i s a p p e a r s   w h e n   u n i t t e s t   a n d / o r   T e s t T o o l s   c o d e   i s   a l t e r e d   ( e . g .   w h e n   i n s e r t i n g   d e b u g g i n g   c o d e   t o   l o c a t e   t h e   p o i n t   o f   f a i l u r e ) ,   i . e .   H e i s e n b u g ;   i t   a p p e a r s   t o   b e   1 0 0 %   r e p e a t a b l e ,   b u t   n o t   e a s i l y   r e p r o d u c i b l e   ( a t   a   g u e s s ,   s o m e t h i n g   i n   t h e   . s c p t   b y t e c o d e   i s   t i c k l i n g   a   b u g   d e e p   d o w n   i n   A S ,   p o s s i b l y   a t   a   p o i n t   w h e r e   6 8 k / P P C / i 3 8 6 / x 8 6 _ 6 4   t r a n s l a t i o n s   o c c u r ) .   L a s t l y ,   t h e   p r o b l e m   h a s   n o t   t o   d a t e   m a n i f e s t e d   w h e n   r u n n i n g   o s a t e s t   i n   T e r m i n a l ,   s o   i f   i t   p e r s i s t s   t h e   b e s t   s o l u t i o n   w o u l d   b e   t o   r e m o v e   t h e   ` r u n   u n i t   t e s t s `   h a n d l e r   a n d   r e q u i r e   u s e r s   t o   r u n   u n i t   t e s t s   v i a   T e r m i n a l   o n l y   ( a l t h o u g h   t h i s   i s   l e s s   c o n v e n i e n t   t h a n   r u n n i n g   i n   S E   d u r i n g   t e s t   d e v e l o p m e n t ) . 
 
 
 -   a s s e r t   c o m m a n d   n o t e s   d o n ' t   c u r r e n t l y   a p p e a r   i n   r e p o r t   e x c e p t   w h e n   a n   a s s e r t   c o m m a n d   r e p o r t s   a   f a i l ;   s h o u l d   o s a t e s t   p r o v i d e   a   ` - - v e r b o s e `   o p t i o n   t h a t   d i s p l a y s   a l l   t e s t   r e p o r t   i n f o r m a t i o n ? 
 
 -   s h o u l d   ` a s s e r t   t e s t   r e s u l t `   s u p p o r t   o p t i o n a l   ` i n `   a n d   ` w i t h   p a r a m e t e r `   a s   a n   a l t e r n a t i v e   t o   u s i n g   ` f o r `   s h o u l d   u s e r   w i s h   t o   i s o l a t e   t h e   o p e r a t i o n   b e i n g   t e s t e d   i n   a   ` c a l l _ N A M E `   h a n d l e r ?   ( A .   p r o b a b l y   n o t :   i t   m a k e s   t h e   A P I   m o r e   c o m p l e x   a n d   c o n f u s i n g ;   u s e r   c a n   a l w a y s   w r a p   t h e   ` a s s e r t   t e s t   r e s u l t `   c o m m a n d   i n   a   ` t r y `   b l o c k   t h a t   c a t c h e s   e r r o r s   a n d   r e p o r t s   t h e m   v i a   ` a s s e r t   t e s t   f a i l e d ` ) 
 
 -   o p t i o n s   f o r   a u t o m a t i c a l l y   s p i k i n g   T I D s   a n d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   b e f o r e   c a l l i n g   ` t e s t _ N A M E `   h a n d l e r ;   a l s o ,   w h a t   a b o u t   a n   o p t i o n   f o r   c o m p o s i n g / d e c o m p o s i n g   u n i c o d e   ( w h i l e   A S   i g n o r e s   d i f f e r e n c e s ,   N S S t r i n g - b a s e d   c o d e   m a y   b e   s e n s i t i v e   t o   t h i s ) ;   n o t e   t h a t   l o c a l i z a t i o n   i s   h a r d e r   t o   s p i k e ,   b u t   s h o u l d   b e   d o n e   i f   p o s s i b l e   a s   i t   a f f e c t s   d a t e   a n d   n u m b e r   c o e r c i o n s 
 
 
 -   w h a t   o t h e r   c h e c k   o b j e c t s   s h o u l d   b e   d e f i n e d   a s   s t a n d a r d ?   e . g . : 
 
 	 -   ` t e x t   e q u a l i t y   c h e c k   [ c o n s i d e r i n g / i g n o r i n g   O P T I O N S ] `   ( n o t e   t h a t   w h i t e s p a c e   s h o u l d   b e   n o r m a l i z e d   r a t h e r   t h a n   i g n o r e d   c o m p l e t e l y ) 
 	 
 	 -   ` e x a c t   t y p e   c h e c k `   ( c h e c k s   o n l y   t h a t   t h e   e x p e c t e d   a n d   a c t u a l   v a l u e s   a r e   o f   t h e   s a m e   t y p e ;   r e l a t i v e l y   w e a k ,   b u t   s t i l l   p o t e n t i a l l y   o f   s o m e   u s e   w h e n   c h e c k i n g ,   s a y ,   e . g .   t h a t   a c t u a l   e r r o r N u m b e r   i s   ` i n t e g e r `   a n d   a c t u a l   e r r o r M e s s a g e   i s   ` t e x t ` ) 
 	 
 	 -   ` A S O b j C   e q u a l i t y   c h e c k ` ( c h e c k s   b o t h   v a l u e s   a r e   o c i d   s p e c i f i e r s   t h e n   c o m p a r e s   t h e m   u s i n g   ` - i s E q u a l : ` ) , 
 	 
 	 -   ` t e x t   p a t t e r n   c h e c k `   ( a l l o w   w i l d c a r d / r e g e x p   c h e c k i n g ,   p o s s i b l y   a p p l y i n g   a d d i t i o n a l   c h e c k   o b j e c t s   t o   w i l d c a r d - m a t c h e d   r a n g e s ;   t h i s   c o u l d   b e   u s e f u l   e . g .   w h e n   c h e c k i n g   e r r o r   m e s s a g e s   w h e r e   s o m e   p a r t s   o f   t h e   m e s s a g e   m a y   v a r y   -   e . g .   d i s k   a n d   h o m e   f o l d e r   n a m e s   i n   f i l e   p a t h s   -   s o   s h o u l d   b e   e i t h e r   i g n o r e d   o r   c u s t o m - c h e c k e d   b u t   t h e   r e s t   o f   t h e   m e s s a g e   i s   c o n s t a n t ) ;   a l s o ,   h o w   m i g h t   m u l t i p l e   c h e c k s   b e   u s e f u l l y   c o m p o s e d ?   ( e . g .   c u r r e n t l y   t h e   ` e x a c t   e r r o r   c h e c k `   c o n s t r u c t o r   o p t i o n a l l y   a c c e p t s   a n   r e c o r d   o f   o n e   o r   m o r e   e q u a l i t y   c h e c k e r s   f o r   c u s t o m i z i n g   h o w   s p e c i f i c   e r r o r   a t t r i b u t e s   a r e   c h e c k e d ) 
 	 
 	 -   ' s e t   e q u a l i t y '   c h e c k   t h a t   t a k e s   t w o   l i s t s   a n d   c h e c k s   b o t h   c o n t a i n   s a m e   i t e m s ,   t h o u g h   n o t   n e c e s s a r i l y   i n   s a m e   o r d e r 
 
 	 -   h o w   t o   p r o v i d e   p a r t i a l / p a t t e r n   m a t c h i n g   b a s e d   c h e c k s   o f   e r r o r   m e s s a g e s ?   ( e . g .   m i g h t   w a n t   t o   n o r m a l i z e   c a s e   a n d   w h i t e s p a c e   b e f o r e   c o m p a r i s o n ;   i t ' d   a l s o   b e   h a n d y   i f   a   r e u s a b l e   h a n d l e r   c o u l d   b e   w r i t t e n   t h a t   c h e c k s   l i b r a r y   a n d   h a n d l e r   n a m e   a r e   c o r r e c t ) 
 
 
 -   s h o u l d   ` a s s e r t   t e s t   e r r o r `   a u t o m a t i c a l l y   c h e c k   e r r o r   r e c o r d ' s   p r o p e r t i e s   a r e   v a l i d   t y p e s   ( e . g .   e r r o r   n u m b e r   s h o u l d   b e   i n t e g e r ,   m e s s a g e   s h o u l d   b e   t e x t ,   e t c . ) ,   a n d   f a i l   t e s t   i f   n o t ? 
 
 -   h o w   t o   i n d i c a t e   m i s m a t c h e d   e r r o r   a t t r i b u t e   i n   E x a c t E r r o r C h e c k ?   ( c u r r e n t l y   t h e   ` c o m p a r e O b j e c t s `   h a n d l e r   s i g n a t u r e   o n l y   a l l o w s   f o r   r e t u r n i n g   t r u e / f a l s e ,   a n d   c a n n o t   [ a n d   s h o u l d   n o t ]   w r i t e   m e s s a g e s   t o   T e s t R e p o r t   o b j e c t   i t s e l f ;   s h o u l d   i t   a l s o   b e   a l l o w e d   t o   r e t u r n   a   { i s E q u a l : B O O L , m e s s a g e T e x t : T E X T }   r e c o r d ,   o r   i s   t h e r e   a n y   b e t t e r   a l t e r n a t i v e ? ) 
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
scpt [ m   $ % \ \ � ] ]  T e s t S u p p o r t W . ( sub-library embedded in TestTools.scptd    X � ^ ^ P   s u b - l i b r a r y   e m b e d d e d   i n   T e s t T o o l s . s c p t d U  _ ` _ l     ��������  ��  ��   `  a b a l     ��������  ��  ��   b  c d c l     �� e f��   e J D--------------------------------------------------------------------    f � g g � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - d  h i h l     �� j k��   j   Timing/Profiling    k � l l "   T i m i n g / P r o f i l i n g i  m n m l     ��������  ��  ��   n  o p o i  ) , q r q I     �� s��
�� .���:MTmrnull��� ��� ctxt s |���� t�� u��  ��   t o      ���� 0 nametext nameText��   u l      v���� v m       w w � x x  ��  ��  ��   r h     �� y�� 0 timerobject TimerObject y k       z z  { | { l     �� } ~��   } � � note: AS can't serialize ASOC objects when [auto-]saving scripts, so store start and end times as NSTimeInterval (Double/real) to avoid any complaints    ~ �  .   n o t e :   A S   c a n ' t   s e r i a l i z e   A S O C   o b j e c t s   w h e n   [ a u t o - ] s a v i n g   s c r i p t s ,   s o   s t o r e   s t a r t   a n d   e n d   t i m e s   a s   N S T i m e I n t e r v a l   ( D o u b l e / r e a l )   t o   a v o i d   a n y   c o m p l a i n t s |  � � � x     �� �����   � 4    �� �
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
�� boovtrue � o      ���� 0 
_isrunning 
_isRunning �  � � � r    $ � � � n    � � � I    �������� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate��  ��   � n    � � � o    ���� 0 nsdate NSDate � m    ��
�� misccura � o      ���� 0 
_starttime 
_startTime �  ��� � L   % ' � �  f   % &��   �  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� 0 	stoptimer 	stopTimer��  ��   � k     8 � �  � � � Z     � ����� � H      � � o     ���� 0 
_isrunning 
_isRunning � L   	  � � m   	 
����  ��  ��   �  � � � r     � � � \     � � � l    ����� � n    � � � I    �������� @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate��  ��   � n    � � � o    ���� 0 nsdate NSDate � m    ��
�� misccura��  ��   � o    ���� 0 
_starttime 
_startTime � o      ���� 0 elapsedtime elapsedTime �  � � � r     - � � � [     ' � � � o     %���� 0 _totalseconds _totalSeconds � o   % &���� 0 elapsedtime elapsedTime � o      �� 0 _totalseconds _totalSeconds �  � � � r   . 5 � � � m   . /�~
�~ boovfals � o      �}�} 0 
_isrunning 
_isRunning �  ��| � L   6 8 � � o   6 7�{�{ 0 elapsedtime elapsedTime�|   �  � � � l     �z�y�x�z  �y  �x   �  � � � i    # � � � I      �w�v�u�w 0 elapsedtime elapsedTime�v  �u   � Z      � ��t � � o     �s�s 0 
_isrunning 
_isRunning � L     � � \     � � � l    ��r�q � n    � � � I   	 �p�o�n�p @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�o  �n   � o    	�m�m 0 nsdate NSDate�r  �q   � o    �l�l 0 
_starttime 
_startTime�t   � L     � � m    �k�k   �  � � � l     �j�i�h�j  �i  �h   �  ��g � i  $ ' � � � I      �f�e�d�f 0 	totaltime 	totalTime�e  �d   � Z      � ��c � � o     �b�b 0 
_isrunning 
_isRunning � L     � � [     � � � o    �a�a 0 _totalseconds _totalSeconds � I    �`�_�^�` 0 elapsedtime elapsedTime�_  �^  �c   � L     � � o    �]�] 0 _totalseconds _totalSeconds�g   p  � � � l     �\�[�Z�\  �[  �Z   �  � � � l     �Y�X�W�Y  �X  �W   �  � � � l     �V � ��V   � J D--------------------------------------------------------------------    � � � � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - �  � � � l     �U � ��U   �   Unit Test Framework    � � � � (   U n i t   T e s t   F r a m e w o r k �  � � � l     �T�S�R�T  �S  �R   �    l      j   - /�Q�Q 00 _abortedassertionerror _AbortedAssertionError m   - .�P�PA P J raised by `assert�` handlers upon failed assertion to terminate that test    � �   r a i s e d   b y   ` a s s e r t & `   h a n d l e r s   u p o n   f a i l e d   a s s e r t i o n   t o   t e r m i n a t e   t h a t   t e s t  l     �O�N�M�O  �N  �M   	
	 h   0 7�L�L 00 _abortedassertiontoken _AbortedAssertionToken l     �K�K  .( when raising error number AbortedAssertionError, the `from` parameter should carry this unique identifier to confirm error was raised by TestTools, and isn't merely an error in the test code/code being tested that happens to use the same error number (in which case it should be treated as such)    �P   w h e n   r a i s i n g   e r r o r   n u m b e r   A b o r t e d A s s e r t i o n E r r o r ,   t h e   ` f r o m `   p a r a m e t e r   s h o u l d   c a r r y   t h i s   u n i q u e   i d e n t i f i e r   t o   c o n f i r m   e r r o r   w a s   r a i s e d   b y   T e s t T o o l s ,   a n d   i s n ' t   m e r e l y   a n   e r r o r   i n   t h e   t e s t   c o d e / c o d e   b e i n g   t e s t e d   t h a t   h a p p e n s   t o   u s e   t h e   s a m e   e r r o r   n u m b e r   ( i n   w h i c h   c a s e   i t   s h o u l d   b e   t r e a t e d   a s   s u c h )
  l     �J�I�H�J  �I  �H    l     �G�F�E�G  �F  �E    l     �D�D   L F the following are set/unset by __performunittestforsuite__ as it runs    � �   t h e   f o l l o w i n g   a r e   s e t / u n s e t   b y   _ _ p e r f o r m u n i t t e s t f o r s u i t e _ _   a s   i t   r u n s  l     �C�B�A�C  �B  �A    l      j   8 <�@�@ 0 _suiteobject _suiteObject m   8 ;�?
�? 
msng � � the test suite object that was passed to `perform unit test`; assigned and cleared at start and end of `perform unit test`; may be used by assert handlers (e.g. `assert test error` uses it when calling a `call_NAME` handler)    �  �   t h e   t e s t   s u i t e   o b j e c t   t h a t   w a s   p a s s e d   t o   ` p e r f o r m   u n i t   t e s t ` ;   a s s i g n e d   a n d   c l e a r e d   a t   s t a r t   a n d   e n d   o f   ` p e r f o r m   u n i t   t e s t ` ;   m a y   b e   u s e d   b y   a s s e r t   h a n d l e r s   ( e . g .   ` a s s e r t   t e s t   e r r o r `   u s e s   i t   w h e n   c a l l i n g   a   ` c a l l _ N A M E `   h a n d l e r ) !"! l     �>�=�<�>  �=  �<  " #$# l     %&'% j   = A�;(�; 0 _testreport _testReport( m   = @�:
�: 
msng& x r a single test_NAME handler may perform multiple asserts, the result of each is recorded in TestReport object here   ' �)) �   a   s i n g l e   t e s t _ N A M E   h a n d l e r   m a y   p e r f o r m   m u l t i p l e   a s s e r t s ,   t h e   r e s u l t   o f   e a c h   i s   r e c o r d e d   i n   T e s t R e p o r t   o b j e c t   h e r e$ *+* l     �9�8�7�9  �8  �7  + ,-, l     ./0. j   B F�61�6 $0 _testhandlername _testHandlerName1 m   B E�5
�5 
msng/ R L used to generate default `call_NAME` handler name for a `test_NAME` handler   0 �22 �   u s e d   t o   g e n e r a t e   d e f a u l t   ` c a l l _ N A M E `   h a n d l e r   n a m e   f o r   a   ` t e s t _ N A M E `   h a n d l e r- 343 l     �4�3�2�4  �3  �2  4 565 l     �1�0�/�1  �0  �/  6 787 l     �.9:�.  9  -------   : �;;  - - - - - - -8 <=< l     �->?�-  > ) # execute a single test_NAME handler   ? �@@ F   e x e c u t e   a   s i n g l e   t e s t _ N A M E   h a n d l e r= ABA l     �,CD�,  C ] W (called by `osatest` via a code-generated glue handler it adds to the unittest script)   D �EE �   ( c a l l e d   b y   ` o s a t e s t `   v i a   a   c o d e - g e n e r a t e d   g l u e   h a n d l e r   i t   a d d s   t o   t h e   u n i t t e s t   s c r i p t )B FGF l     �+�*�)�+  �*  �)  G HIH i  G JJKJ I      �(L�'�( 0 __performunittestforsuite__  L MNM o      �&�& 0 suiteobject suiteObjectN O�%O J      PP QRQ o      �$�$ 0 	suitename 	suiteNameR STS o      �#�# 0 handlername handlerNameT U�"U o      �!�! 0 isstyled isStyled�"  �%  �'  K k    |VV WXW l      � YZ�   Ye_
		suiteObject : script -- test suite object
		suiteName : text -- test suite name, for reporting use
		handlerName : text -- name of the test suite handler to call
		allHandlerNames : list of text -- all handler names in this test suite; used to determine which if any fixture methods (configure_setUp, configure_tearDown, etc.) need to be called
		isStyled : boolean -- if true, the returned report will include special formatting codes (bold, underline) to improve presentation in Terminal.app and other VT100 emulators; use false if you intend to use this text elsewhere
		Result: script -- TestReport
	   Z �[[� 
 	 	 s u i t e O b j e c t   :   s c r i p t   - -   t e s t   s u i t e   o b j e c t 
 	 	 s u i t e N a m e   :   t e x t   - -   t e s t   s u i t e   n a m e ,   f o r   r e p o r t i n g   u s e 
 	 	 h a n d l e r N a m e   :   t e x t   - -   n a m e   o f   t h e   t e s t   s u i t e   h a n d l e r   t o   c a l l 
 	 	 a l l H a n d l e r N a m e s   :   l i s t   o f   t e x t   - -   a l l   h a n d l e r   n a m e s   i n   t h i s   t e s t   s u i t e ;   u s e d   t o   d e t e r m i n e   w h i c h   i f   a n y   f i x t u r e   m e t h o d s   ( c o n f i g u r e _ s e t U p ,   c o n f i g u r e _ t e a r D o w n ,   e t c . )   n e e d   t o   b e   c a l l e d 
 	 	 i s S t y l e d   :   b o o l e a n   - -   i f   t r u e ,   t h e   r e t u r n e d   r e p o r t   w i l l   i n c l u d e   s p e c i a l   f o r m a t t i n g   c o d e s   ( b o l d ,   u n d e r l i n e )   t o   i m p r o v e   p r e s e n t a t i o n   i n   T e r m i n a l . a p p   a n d   o t h e r   V T 1 0 0   e m u l a t o r s ;   u s e   f a l s e   i f   y o u   i n t e n d   t o   u s e   t h i s   t e x t   e l s e w h e r e 
 	 	 R e s u l t :   s c r i p t   - -   T e s t R e p o r t 
 	X \]\ r     ^_^ n    `a` I    �b��  0 maketestreport makeTestReportb cdc o    �� 0 	suitename 	suiteNamed efe o    �� 0 handlername handlerNamef g�g o    �� 0 isstyled isStyled�  �  a o     �� 0 _testsupport _TestSupport_ o      �� 0 _testreport _testReport] hih l   �jk�  j = 7 check if this test (or entire suite) should be skipped   k �ll n   c h e c k   i f   t h i s   t e s t   ( o r   e n t i r e   s u i t e )   s h o u l d   b e   s k i p p e di mnm Z   Cop��o n    qrq I     �s�� 0 
hashandler 
hasHandlers t�t N    uu n    vwv o    �� *0 configure_skiptests configure_skipTestsw o    �� 0 suiteobject suiteObject�  �  r o    �� 0 _support  p Q   #?xyzx k   &{{ |}| r   & -~~ n  & +��� I   ' +���� *0 configure_skiptests configure_skipTests�  �  � o   & '�� 0 suiteobject suiteObject o      �
�
 0 skipinfo skipInfo} ��� Q   . Q���� l  1 4���� r   1 4��� o   1 2�	�	 0 skipinfo skipInfo� o      �� 0 skipinfo skipInfo� > 8 make sure configure_skipTests actually returned a value   � ��� p   m a k e   s u r e   c o n f i g u r e _ s k i p T e s t s   a c t u a l l y   r e t u r n e d   a   v a l u e� R      ���
� .ascrerr ****      � ****�  � ���
� 
errn� d      �� m      ��
��  � k   < Q�� ��� R   < J���
� .ascrerr ****      � ****� m   H I�� ��� �  c o n f i g u r e _ s k i p T e s t s    d i d n  t   r e t u r n   a n y t h i n g   ( e . g .   t o   r u n   a l l   t e s t s   i n   s u i t e ,   r e t u r n    m i s s i n g   v a l u e  ) .� ���
� 
errn� m   > ?� � �?� ����
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
reco��  ��  � o   X ]���� 0 _testsupport _TestSupport� l  f ����� k   f ��� ��� r   f {��� c   f y��� l  f u������ n  f u��� I   p u������� 0 objectforkey_ objectForKey_� ���� o   p q���� 0 handlername handlerName��  ��  � l  f p������ n  f p��� I   k p������� 60 dictionarywithdictionary_ dictionaryWithDictionary_� ���� o   k l���� 0 skipinfo skipInfo��  ��  � n  f k��� o   g k���� 0 nsdictionary NSDictionary� m   f g��
�� misccura��  ��  ��  ��  � m   u x��
�� 
****� o      ���� 0 
skipreason 
skipReason� ���� Z   | �������� >  | ��� o   | }���� 0 
skipreason 
skipReason� m   } ~��
�� 
msng� k   � ��� ��� Q   � ����� r   � ���� c   � ���� o   � ����� 0 
skipreason 
skipReason� m   � ���
�� 
ctxt� o      ���� 0 
skipreason 
skipReason� R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � R   � �����
�� .ascrerr ****      � ****� b   � ���� b   � ���� m   � ��� ��� f  c o n f i g u r e _ s k i p T e s t s    d i d n  t   r e t u r n   v a l i d   r e c o r d   ( � o   � ����� 0 handlername handlerName� m   � ��� ��� h    p r o p e r t y   d o e s n  t   c o n t a i n   t e x t   o r    m i s s i n g   v a l u e  ) .� ����
�� 
errn� m   � ������\� ����
�� 
erob� o   � ����� 0 skipinfo skipInfo� �����
�� 
errt� J   � ��� ��� m   � ���
�� 
ctxt� ���� m   � ���
�� 
msng��  ��  � ��� n  � ���� I   � �������� 0 
addskipped 
addSkipped� ��� o   � ����� 0 handlername handlerName� ���� o   � ����� 0 
skipreason 
skipReason��  ��  � o   � ����� 0 _testreport _testReport� ���� L   � ��� o   � ����� 0 _testreport _testReport��  ��  ��  ��  � + % check if this test should be skipped   � ��� J   c h e c k   i f   t h i s   t e s t   s h o u l d   b e   s k i p p e d� ��� >  � ���� o   � ����� 0 skipinfo skipInfo� m   � ���
�� 
msng� ���� l  � �   k   � �  Q   � � r   � �	
	 c   � � o   � ����� 0 skipinfo skipInfo m   � ���
�� 
ctxt
 o      ���� 0 
skipreason 
skipReason R      ����
�� .ascrerr ****      � ****��   ����
�� 
errn d       m      �������   R   � ���
�� .ascrerr ****      � **** m   � � � �  c o n f i g u r e _ s k i p T e s t s    d i d n  t   r e t u r n   r e c o r d ,   t e x t ,   o r    m i s s i n g   v a l u e  . ��
�� 
errn m   � ������\ ��
�� 
erob o   � ����� 0 skipinfo skipInfo ����
�� 
errt J   � �  m   � ���
�� 
reco  m   � ���
�� 
ctxt �� m   � ���
�� 
msng��  ��     n  � �!"! I   � ���#���� 0 	skipsuite 	skipSuite# $��$ o   � ����� 0 
skipreason 
skipReason��  ��  " o   � ����� 0 _testreport _testReport  %��% L   � �&& o   � ����� 0 _testreport _testReport��     skip the whole suite    �'' *   s k i p   t h e   w h o l e   s u i t e��  ��  � L F (missing value = run test; text = skip suite; record = run/skip test)   � �(( �   ( m i s s i n g   v a l u e   =   r u n   t e s t ;   t e x t   =   s k i p   s u i t e ;   r e c o r d   =   r u n / s k i p   t e s t )��  ��  ��  y R      ��)*
�� .ascrerr ****      � ****) o      ���� 0 etext eText* ��+,
�� 
errn+ o      ���� 0 enumber eNumber, ��-.
�� 
erob- o      ���� 0 efrom eFrom. ��/0
�� 
errt/ o      ���� 
0 eto eTo0 ��1��
�� 
ptlr1 o      ���� 0 epartial ePartial��  z k  ?22 343 n 8565 I  8��7���� 0 	addbroken 	addBroken7 898 m  :: �;; & c o n f i g u r e _ s k i p T e s t s9 <=< m  >> �?? $ b r o k e   d u e   t o   e r r o r= @A@ m  BB �CC  A D��D l 	2E����E J  2FF G��G J  0HH IJI m  KK �LL   u n e x p e c t e d   e r r o rJ M��M n .NON I  #.��P���� .0 makecaughterrorrecord makeCaughtErrorRecordP QRQ o  #$���� 0 etext eTextR STS o  $%���� 0 enumber eNumberT UVU o  %&���� 0 efrom eFromV WXW o  &'���� 
0 eto eToX Y��Y o  '(���� 0 epartial ePartial��  ��  O o  #���� 0 _testsupport _TestSupport��  ��  ��  ��  ��  ��  6 o  ���� 0 _testreport _testReport4 Z��Z L  9?[[ o  9>�� 0 _testreport _testReport��  �  �  n \]\ l DD�~^_�~  ^   pre-test preparation   _ �`` *   p r e - t e s t   p r e p a r a t i o n] aba r  DKcdc o  DE�}�} 0 suiteobject suiteObjectd o      �|�| 0 _suiteobject _suiteObjectb efe r  LSghg o  LM�{�{ 0 handlername handlerNameh o      �z�z $0 _testhandlername _testHandlerNamef iji l TT�ykl�y  k)# note: while `osatest` could supply a list of found handler names to check for existence of `configure_setUp` and `configure_tearDown`, that would only work for configure_setUp/configure_tearDown handlers defined directly within the suite script, not configure_setUp/configure_tearDown handlers inherited from a parent script; thus it's necessary to resort here to some undocumented hackery to determine existence of callable configure_setUp/configure_tearDown handlers before trying to call them (see also comments on `hasHandler` in TypeSupport)   l �mmF   n o t e :   w h i l e   ` o s a t e s t `   c o u l d   s u p p l y   a   l i s t   o f   f o u n d   h a n d l e r   n a m e s   t o   c h e c k   f o r   e x i s t e n c e   o f   ` c o n f i g u r e _ s e t U p `   a n d   ` c o n f i g u r e _ t e a r D o w n ` ,   t h a t   w o u l d   o n l y   w o r k   f o r   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   d e f i n e d   d i r e c t l y   w i t h i n   t h e   s u i t e   s c r i p t ,   n o t   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   i n h e r i t e d   f r o m   a   p a r e n t   s c r i p t ;   t h u s   i t ' s   n e c e s s a r y   t o   r e s o r t   h e r e   t o   s o m e   u n d o c u m e n t e d   h a c k e r y   t o   d e t e r m i n e   e x i s t e n c e   o f   c a l l a b l e   c o n f i g u r e _ s e t U p / c o n f i g u r e _ t e a r D o w n   h a n d l e r s   b e f o r e   t r y i n g   t o   c a l l   t h e m   ( s e e   a l s o   c o m m e n t s   o n   ` h a s H a n d l e r `   i n   T y p e S u p p o r t )j non Z  T�pq�x�wp n Tcrsr I  Yc�vt�u�v 0 
hashandler 
hasHandlert u�tu N  Y_vv n  Y^wxw o  Z^�s�s "0 configure_setup configure_setUpx o  YZ�r�r 0 suiteobject suiteObject�t  �u  s o  TY�q�q 0 _support  q Q  f�yz{y n in|}| I  jn�p�o�n�p "0 configure_setup configure_setUp�o  �n  } o  ij�m�m 0 suiteobject suiteObjectz R      �l~
�l .ascrerr ****      � ****~ o      �k�k 0 etext eText �j��
�j 
errn� o      �i�i 0 enumber eNumber� �h��
�h 
erob� o      �g�g 0 efrom eFrom� �f��
�f 
errt� o      �e�e 
0 eto eTo� �d��c
�d 
ptlr� o      �b�b 0 epartial ePartial�c  { k  v��� ��� n v���� I  {��a��`�a 0 	addbroken 	addBroken� ��� m  {~�� ���  c o n f i g u r e _ s e t U p� ��� m  ~��� ��� $ b r o k e   d u e   t o   e r r o r� ��� m  ���� ���  � ��_� l 	����^�]� J  ���� ��\� J  ���� ��� m  ���� ���   u n e x p e c t e d   e r r o r� ��[� n ����� I  ���Z��Y�Z .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o  ���X�X 0 etext eText� ��� o  ���W�W 0 enumber eNumber� ��� o  ���V�V 0 efrom eFrom� ��� o  ���U�U 
0 eto eTo� ��T� o  ���S�S 0 epartial ePartial�T  �Y  � o  ���R�R 0 _testsupport _TestSupport�[  �\  �^  �]  �_  �`  � o  v{�Q�Q 0 _testreport _testReport� ��� r  ����� m  ���P
�P 
msng� o      �O�O 0 _suiteobject _suiteObject� ��N� L  ���� o  ���M�M 0 _testreport _testReport�N  �x  �w  o ��� r  ����� n ����� I  ���L��K�L  0 makecallobject makeCallObject� ��� o  ���J�J 0 handlername handlerName� ��I� m  ���H�H  �I  �K  � o  ���G�G 0 _testsupport _TestSupport� o      �F�F 0 
callobject 
callObject� ��� l ���E���E  �   do test   � ���    d o   t e s t� ��� Q  ����� n ����� I  ���D��C�D 0 dotest doTest� ��� o  ���B�B 0 suiteobject suiteObject� ��A� m  ���@
�@ 
msng�A  �C  � o  ���?�? 0 
callobject 
callObject� R      �>��
�> .ascrerr ****      � ****� o      �=�= 0 etext eText� �<��
�< 
errn� o      �;�; 0 enumber eNumber� �:��
�: 
erob� o      �9�9 0 efrom eFrom� �8��
�8 
errt� o      �7�7 
0 eto eTo� �6��5
�6 
ptlr� o      �4�4 0 epartial ePartial�5  � l ����� Z  ����3�2� H  ���� l ����1�0� F  ����� =  ����� o  ���/�/ 0 enumber eNumber� o  ���.�. 00 _abortedassertionerror _AbortedAssertionError� = ����� o  ���-�- 0 efrom eFrom� o  ���,�, 00 _abortedassertiontoken _AbortedAssertionToken�1  �0  � l ����� l ����� n ���� I  ��+��*�+ 0 
addfailure 
addFailure� ��� o  ���)�) 0 handlername handlerName� ��� m  ���� ��� j ( e . g .   e r r o r   i n   c o d e   b e i n g   t e s t e d / b u g   i n   t e s t   h a n d l e r )� ��� m  ���� ���  � ��(� l 	���'�&� J  ��� ��%� J  ��� ��� m  ���� �     u n e x p e c t e d   e r r o r� �$ n � I  �#�"�# .0 makecaughterrorrecord makeCaughtErrorRecord  o  �!�! 0 etext eText  o  � �  0 enumber eNumber 	
	 o  �� 0 efrom eFrom
  o  �� 
0 eto eTo � o  �� 0 epartial ePartial�  �"   o  ��� 0 _testsupport _TestSupport�$  �%  �'  �&  �(  �*  � o  ���� 0 _testreport _testReport��� TO DO: without stack trace support, there's no way to distinguish an error raised by the code being tested versus an error caused by a bug in the test code, so we can only say error was 'unexpected' and leave user to figure out why; allowing `call_NAME` handlers to be used by `assert test result` would give users the opportunity to box up the code being tested allowing TestTools to distinguish the cause   � �.   T O   D O :   w i t h o u t   s t a c k   t r a c e   s u p p o r t ,   t h e r e ' s   n o   w a y   t o   d i s t i n g u i s h   a n   e r r o r   r a i s e d   b y   t h e   c o d e   b e i n g   t e s t e d   v e r s u s   a n   e r r o r   c a u s e d   b y   a   b u g   i n   t h e   t e s t   c o d e ,   s o   w e   c a n   o n l y   s a y   e r r o r   w a s   ' u n e x p e c t e d '   a n d   l e a v e   u s e r   t o   f i g u r e   o u t   w h y ;   a l l o w i n g   ` c a l l _ N A M E `   h a n d l e r s   t o   b e   u s e d   b y   ` a s s e r t   t e s t   r e s u l t `   w o u l d   g i v e   u s e r s   t h e   o p p o r t u n i t y   t o   b o x   u p   t h e   c o d e   b e i n g   t e s t e d   a l l o w i n g   T e s t T o o l s   t o   d i s t i n g u i s h   t h e   c a u s e� � � check if failure was already reported, and this is the subsequent abort, in which case ignore; if not, it's an error in either the test_NAME handler or the code being tested, so report it   � �x   c h e c k   i f   f a i l u r e   w a s   a l r e a d y   r e p o r t e d ,   a n d   t h i s   i s   t h e   s u b s e q u e n t   a b o r t ,   i n   w h i c h   c a s e   i g n o r e ;   i f   n o t ,   i t ' s   a n   e r r o r   i n   e i t h e r   t h e   t e s t _ N A M E   h a n d l e r   o r   t h e   c o d e   b e i n g   t e s t e d ,   s o   r e p o r t   i t�3  �2  �   test failed   � �    t e s t   f a i l e d�  l ��     post-test clean up    � &   p o s t - t e s t   c l e a n   u p  Z  m�� n + I  !+��� 0 
hashandler 
hasHandler � N  !' n  !&  o  "&�� (0 configure_teardown configure_tearDown  o  !"�� 0 suiteobject suiteObject�  �   o  !�� 0 _support   Q  .i!"#! n 16$%$ I  26���� (0 configure_teardown configure_tearDown�  �  % o  12�� 0 suiteobject suiteObject" R      �&'
� .ascrerr ****      � ****& o      �� 0 etext eText' �
()
�
 
errn( o      �	�	 0 enumber eNumber) �*+
� 
erob* o      �� 0 efrom eFrom+ �,-
� 
errt, o      �� 
0 eto eTo- �.�
� 
ptlr. o      �� 0 epartial ePartial�  # n >i/0/ I  Ci�1� � 0 	addbroken 	addBroken1 232 m  CF44 �55 $ c o n f i g u r e _ t e a r D o w n3 676 m  FI88 �99 $ b r o k e   d u e   t o   e r r o r7 :;: m  IL<< �==  ; >��> l 	Lc?����? J  Lc@@ A��A J  LaBB CDC m  LOEE �FF   u n e x p e c t e d   e r r o rD G��G n O_HIH I  T_��J���� .0 makecaughterrorrecord makeCaughtErrorRecordJ KLK o  TU���� 0 etext eTextL MNM o  UV���� 0 enumber eNumberN OPO o  VW���� 0 efrom eFromP QRQ o  WX���� 
0 eto eToR S��S o  XY���� 0 epartial ePartial��  ��  I o  OT���� 0 _testsupport _TestSupport��  ��  ��  ��  ��  �   0 o  >C���� 0 _testreport _testReport�  �   TUT r  nuVWV m  no��
�� 
msngW o      ���� 0 _suiteobject _suiteObjectU X��X l v|YZ[Y L  v|\\ o  v{���� 0 _testreport _testReportZ�{ TO DO: wrapping all the test data (result values, error info, status, etc) in a script object and returning that preserves AS context info and AS types across the AE bridge; the script object can then be loaded into a new OSAID and its methods called to extract each bit of data in turn for formatting and final message generation  (caveat not sure what ocids and optrs will do)   [ �]]�   T O   D O :   w r a p p i n g   a l l   t h e   t e s t   d a t a   ( r e s u l t   v a l u e s ,   e r r o r   i n f o ,   s t a t u s ,   e t c )   i n   a   s c r i p t   o b j e c t   a n d   r e t u r n i n g   t h a t   p r e s e r v e s   A S   c o n t e x t   i n f o   a n d   A S   t y p e s   a c r o s s   t h e   A E   b r i d g e ;   t h e   s c r i p t   o b j e c t   c a n   t h e n   b e   l o a d e d   i n t o   a   n e w   O S A I D   a n d   i t s   m e t h o d s   c a l l e d   t o   e x t r a c t   e a c h   b i t   o f   d a t a   i n   t u r n   f o r   f o r m a t t i n g   a n d   f i n a l   m e s s a g e   g e n e r a t i o n     ( c a v e a t   n o t   s u r e   w h a t   o c i d s   a n d   o p t r s   w i l l   d o )��  I ^_^ l     ��������  ��  ��  _ `a` l     ��������  ��  ��  a bcb l     ��de��  d J D--------------------------------------------------------------------   e �ff � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -c ghg l     ��ij��  i   Unit Test Comparators   j �kk ,   U n i t   T e s t   C o m p a r a t o r sh lml l     ��������  ��  ��  m non i  K Npqp I      ��r���� 20 _ascheckobjectparameter _asCheckObjectParameterr sts o      ���� 0 checkobject checkObjectt u��u o      ���� (0 defaultcheckobject defaultCheckObject��  ��  q k     <vv wxw Z    yz����y =    {|{ o     ���� 0 checkobject checkObject| m    ��
�� 
msngz r    	}~} o    ���� (0 defaultcheckobject defaultCheckObject~ o      ���� 0 checkobject checkObject��  ��  x � r    ��� n   ��� I    ������� &0 asscriptparameter asScriptParameter� ��� o    ���� 0 checkobject checkObject� ���� m    �� ��� 
 u s i n g��  ��  � o    ���� 0 _support  � o      ���� 0 checkobject checkObject� ��� Z   9������� H    *�� n   )��� I   ! )������� 0 
hashandler 
hasHandler� ���� N   ! %�� n   ! $��� o   " $����  0 compareobjects compareObjects� o   ! "���� 0 checkobject checkObject��  ��  � o    !���� 0 _support  � R   - 5����
�� .ascrerr ****      � ****� m   3 4�� ��� � B a d    u s i n g    p a r a m e t e r   ( s c r i p t   o b j e c t   d o e s n  t   c o n t a i n   a    c o m p a r e O b j e c t s    h a n d l e r ) .� ����
�� 
errn� m   / 0�����@� �����
�� 
erob� o   1 2���� 0 checkobject checkObject��  ��  ��  � ���� L   : <�� o   : ;���� 0 checkobject checkObject��  o ��� l     ��������  ��  ��  � ��� i  O R��� I      ������� ,0 _ascheckobjectresult _asCheckObjectResult� ���� o      ���� 0 isequal isEqual��  ��  � k     �� ��� Z    ������� H     	�� E    ��� J     �� ��� m     ��
�� boovtrue� ���� m    ��
�� boovfals��  � J    �� ���� o    ���� 0 isequal isEqual��  � R    ����
�� .ascrerr ****      � ****� m    �� ��� Z C h e c k   o b j e c t   d i d   n o t   r e t u r n   a   b o o l e a n   r e s u l t .� ����
�� 
errn� m    �����Y� ����
�� 
erob� o    ���� 0 isequal isEqual� �����
�� 
errt� m    ��
�� 
bool��  ��  ��  � ���� L    �� o    ���� 0 isequal isEqual��  � ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ������  �   result checking   � ���     r e s u l t   c h e c k i n g� ��� l     ��������  ��  ��  � ��� i  S V��� I     ������
�� .���:ExEqnull��� ��� null��  ��  � h     ����� (0 exactequalitycheck ExactEqualityCheck� i    ��� I      �������  0 compareobjects compareObjects� ��� o      ���� 0 expectedvalue expectedValue� ���� o      ���� 0 actualvalue actualValue��  ��  � P     ���� k    �� ��� l   ���� Z   ������� >   ��� n    ��� m    ��
�� 
pcls� o    ���� 0 expectedvalue expectedValue� n    ��� m   	 ��
�� 
pcls� o    	���� 0 actualvalue actualValue� L    �� m    ��
�� boovfals��  ��  � l f also check types are identical, e.g. if unittest indicates a real is expected then integer is a smell   � ��� �   a l s o   c h e c k   t y p e s   a r e   i d e n t i c a l ,   e . g .   i f   u n i t t e s t   i n d i c a t e s   a   r e a l   i s   e x p e c t e d   t h e n   i n t e g e r   i s   a   s m e l l� ���� L    �� =   ��� o    ���� 0 expectedvalue expectedValue� o    ���� 0 actualvalue actualValue��  � ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  � ����
�� consnume��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� j   W ]��� .0 _defaultequalitycheck _defaultEqualityCheck� I  W \�~�}�|
�~ .���:ExEqnull��� ��� null�}  �|  � ��� l     �{�z�y�{  �z  �y  � ��� l     �x�w�v�x  �w  �v  �    l     �u�t�s�u  �t  �s    l     �r�q�p�r  �q  �p    l     �o�n�m�o  �n  �m    i  ^ a	 I     �l�k

�l .���:ExMunull��� ��� null�k  
 �j�i
�j 
Usin |�h�g�f�h  �g   o      �e�e 0 checkobject checkObject�f   l     �d�c m      �b
�b 
msng�d  �c  �i  	 Q     * k      r     I    �a�`�a 20 _ascheckobjectparameter _asCheckObjectParameter  o    �_�_ 0 checkobject checkObject �^ o    
�]�] .0 _defaultequalitycheck _defaultEqualityCheck�^  �`   o      �\�\ 0 checkobject checkObject �[ h    �Z�Z *0 multiplechoicecheck MultipleChoiceCheck i     I      �Y�X�Y  0 compareobjects compareObjects  !  o      �W�W  0 expectedvalues expectedValues! "�V" o      �U�U 0 actualvalue actualValue�V  �X   k     X## $%$ Z    $&'�T�S& G     ()( =     *+* l    	,�R�Q, I    	�P-.
�P .corecnte****       ****- J     // 0�O0 o     �N�N  0 expectedvalues expectedValues�O  . �M1�L
�M 
kocl1 m    �K
�K 
list�L  �R  �Q  + m   	 
�J�J  ) A    232 n    454 1    �I
�I 
leng5 o    �H�H  0 expectedvalues expectedValues3 m    �G�G ' R     �F67
�F .ascrerr ****      � ****6 m    88 �99 � I n v a l i d   e x p e c t e d   v a l u e s   ( m u l t i p l e   c h o i c e   c h e c k  s    u s i n g    p a r a m e t e r   r e q u i r e s   a   l i s t   o f   t w o   o r   m o r e   e x p e c t e d   v a l u e s ) .7 �E:;
�E 
errn: m    �D�D�Y; �C<�B
�C 
erob< o    �A�A 0 expectedvalue expectedValue�B  �T  �S  % =>= X   % U?�@@? Z  5 PAB�?�>A I   5 G�=C�<�= ,0 _ascheckobjectresult _asCheckObjectResultC D�;D n  6 CEFE I   ; C�:G�9�:  0 compareobjects compareObjectsG HIH n  ; >JKJ 1   < >�8
�8 
pcntK o   ; <�7�7 $0 expectedvalueref expectedValueRefI L�6L o   > ?�5�5 0 actualvalue actualValue�6  �9  F o   6 ;�4�4 0 checkobject checkObject�;  �<  B L   J LMM m   J K�3
�3 boovtrue�?  �>  �@ $0 expectedvalueref expectedValueRef@ o   ( )�2�2  0 expectedvalues expectedValues> N�1N L   V XOO m   V W�0
�0 boovfals�1  �[   R      �/PQ
�/ .ascrerr ****      � ****P o      �.�. 0 etext eTextQ �-RS
�- 
errnR o      �,�, 0 enumber eNumberS �+TU
�+ 
erobT o      �*�* 0 efrom eFromU �)V�(
�) 
errtV o      �'�' 
0 eto eTo�(   I     *�&W�%�& 
0 _error  W XYX m   ! "ZZ �[[ , n u m e r i c   e q u a l i t y   c h e c kY \]\ o   " #�$�$ 0 etext eText] ^_^ o   # $�#�# 0 enumber eNumber_ `a` o   $ %�"�" 0 efrom eFroma b�!b o   % &� �  
0 eto eTo�!  �%   cdc l     ����  �  �  d efe l     ����  �  �  f ghg i  b eiji I     ��k
� .���:NmEqnull��� ��� null�  k �l�
� 
ETypl |��m�n�  �  m o      �� (0 issametyperequired isSameTypeRequired�  n l     o��o m      �
� boovtrue�  �  �  j l    4pqrp Q     4stus k    "vv wxw Z    yz�{y n   |}| I    �~�� (0 asbooleanparameter asBooleanParameter~ � o    	�� (0 issametyperequired isSameTypeRequired� ��
� m   	 
�� ���  m a t c h i n g   t y p e s�
  �  } o    �	�	 0 _support  z r    ��� m    �
� 
doub� o      �� 0 	checktype 	checkType�  { r    ��� m    �
� 
nmbr� o      �� 0 	checktype 	checkTypex ��� h    "��� 00 numericalequalitycheck NumericalEqualityCheck� k      �� ��� j     ��� 0 _isequaldelta _isEqualDelta� m     �� =q���-�� ��� i   ��� I      � ����   0 compareobjects compareObjects� ��� o      ���� 0 expectedvalue expectedValue� ���� o      ���� 0 actualvalue actualValue��  ��  � k     ��� ��� Z    ������� =     ��� l    
������ I    
����
�� .corecnte****       ****� J     �� ��� o     ���� 0 expectedvalue expectedValue� ���� o    ���� 0 actualvalue actualValue��  � �����
�� 
kocl� m    ��
�� 
long��  ��  ��  � m   
 ���� � L    �� =    ��� o    ���� 0 expectedvalue expectedValue� o    ���� 0 actualvalue actualValue��  ��  � ��� Z   1������� >    (��� l   &������ I   &����
�� .corecnte****       ****� J    �� ��� o    ���� 0 expectedvalue expectedValue� ���� o    ���� 0 actualvalue actualValue��  � �����
�� 
kocl� o    "���� 0 	checktype 	checkType��  ��  ��  � m   & '���� � L   + -�� m   + ,��
�� boovfals��  ��  � ��� r   2 I��� J   2 :�� ��� c   2 5��� o   2 3���� 0 expectedvalue expectedValue� m   3 4��
�� 
doub� ���� c   5 8��� o   5 6���� 0 actualvalue actualValue� m   6 7��
�� 
doub��  � J      �� ��� o      ���� 0 n1  � ���� o      ���� 0 n2  ��  � ��� Z   J e������ =   J M��� o   J K���� 0 n1  � m   K L����  � r   P Y��� ]   P W��� o   P U���� 0 _isequaldelta _isEqualDelta� o   U V���� 0 n2  � o      ���� 0 d1  ��  � r   \ e��� ]   \ c��� o   \ a���� 0 _isequaldelta _isEqualDelta� o   a b���� 0 n1  � o      ���� 0 d1  � ��� r   f j��� d   f h�� o   f g���� 0 d1  � o      ���� 0 d2  � ��� Z  k �������� ?   k n��� o   k l���� 0 d1  � o   l m���� 0 d2  � r   q ���� J   q u�� ��� o   q r���� 0 d2  � ���� o   r s���� 0 d1  ��  � J      �� ��� o      ���� 0 d1  � ���� o      ���� 0 d2  ��  ��  ��  � ��� r   � ���� \   � ���� o   � ����� 0 n2  � o   � ����� 0 n1  � o      ���� 0 d  � ���� L   � ��� F   � ���� A   � ���� o   � ����� 0 d1  � o   � ����� 0 d  � A   � ���� o   � ����� 0 d  � o   � ����� 0 d2  ��  �  �  t R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  u I   * 4�� ���� 
0 _error     m   + , � , n u m e r i c   e q u a l i t y   c h e c k  o   , -���� 0 etext eText  o   - .���� 0 enumber eNumber 	
	 o   . /���� 0 efrom eFrom
 �� o   / 0���� 
0 eto eTo��  ��  q � � ignores slight differences due to floating point's limited precision when comparing real numbers -- TO DO: allow magnitude to be optionally specified?   r �.   i g n o r e s   s l i g h t   d i f f e r e n c e s   d u e   t o   f l o a t i n g   p o i n t ' s   l i m i t e d   p r e c i s i o n   w h e n   c o m p a r i n g   r e a l   n u m b e r s   - -   T O   D O :   a l l o w   m a g n i t u d e   t o   b e   o p t i o n a l l y   s p e c i f i e d ?h  l     ��������  ��  ��    l     ��������  ��  ��    i  f i I     ����
�� .���:NmRgnull��� ��� null��   ����
�� 
ETyp |��������  ��   o      ���� (0 issametyperequired isSameTypeRequired��   l     ���� m      ��
�� boovtrue��  ��  ��   Q     * k      r     !  n   "#" I    ��$���� (0 asbooleanparameter asBooleanParameter$ %&% o    	���� (0 issametyperequired isSameTypeRequired& '��' m   	 
(( �))  m a t c h i n g   t y p e s��  ��  # o    ���� 0 _support  ! o      ���� (0 issametyperequired isSameTypeRequired *��* h    ��+�� *0 numericalrangecheck NumericalRangeCheck+ i    ,-, I      ��.����  0 compareobjects compareObjects. /0/ o      ���� 0 expectedvalue expectedValue0 1��1 o      ���� 0 actualvalue actualValue��  ��  - k     �22 343 Z    656����5 G     '787 G     9:9 =     ;<; l    	=����= I    	��>?
�� .corecnte****       ****> J     @@ A��A o     ���� 0 expectedvalue expectedValue��  ? ��B��
�� 
koclB m    ��
�� 
list��  ��  ��  < m   	 
����  : >    CDC l   E����E I   ��FG
�� .corecnte****       ****F o    �� 0 expectedvalue expectedValueG �~H�}
�~ 
koclH m    �|
�| 
nmbr�}  ��  ��  D m    �{�{ 8 l   %I�z�yI ?    %JKJ n    LML 4     �xN
�x 
cobjN m    �w�w M o    �v�v 0 expectedvalue expectedValueK n    $OPO 4   ! $�uQ
�u 
cobjQ m   " #�t�t P o     !�s�s 0 expectedvalue expectedValue�z  �y  6 R   * 2�rRS
�r .ascrerr ****      � ****R m   0 1TT �UU � I n v a l i d   e x p e c t e d   v a l u e   ( n u m e r i c   e q u a l i t y   c h e c k   r e q u i r e s   t w o - i t e m   l i s t   o f   m i n i m u m   a n d   m a x i m u m   n u m b e r s ) .S �qVW
�q 
errnV m   , -�p�p�YW �oX�n
�o 
erobX o   . /�m�m 0 expectedvalue expectedValue�n  ��  ��  4 YZY r   7 G[\[ o   7 8�l�l 0 expectedvalue expectedValue\ J      ]] ^_^ o      �k�k "0 expectedminimum expectedMinimum_ `�j` o      �i�i "0 expectedmaximum expectedMaximum�j  Z aba Z   H rcd�hec o   H M�g�g (0 issametyperequired isSameTypeRequiredd k   P lff ghg Z  P fij�f�ei >  P Wklk n  P Smnm m   Q S�d
�d 
pclsn o   P Q�c�c "0 expectedminimum expectedMinimuml n  S Vopo m   T V�b
�b 
pclsp o   S T�a�a "0 expectedmaximum expectedMaximumj R   Z b�`qr
�` .ascrerr ****      � ****q m   ` ass �tt � I n v a l i d   e x p e c t e d   v a l u e   ( n u m e r i c   e q u a l i t y   c h e c k  s    m a t c h i n g   t y p e s    p a r a m e t e r   r e q u i r e s   b o t h   n u m b e r s   t o   b e   s a m e   t y p e ) .r �_uv
�_ 
errnu m   \ ]�^�^�Yv �]w�\
�] 
erobw o   ^ _�[�[ 0 expectedvalue expectedValue�\  �f  �e  h x�Zx r   g lyzy n  g j{|{ m   h j�Y
�Y 
pcls| o   g h�X�X "0 expectedminimum expectedMinimumz o      �W�W 0 	checktype 	checkType�Z  �h  e r   o r}~} m   o p�V
�V 
nmbr~ o      �U�U 0 	checktype 	checkTypeb � Z  s ����T�S� =   s ~��� l  s |��R�Q� I  s |�P��
�P .corecnte****       ****� J   s v�� ��O� o   s t�N�N 0 actualvalue actualValue�O  � �M��L
�M 
kocl� o   w x�K�K 0 	checktype 	checkType�L  �R  �Q  � m   | }�J�J  � L   � ��� m   � ��I
�I boovfals�T  �S  � ��H� L   � ��� F   � ���� B   � ���� o   � ��G�G "0 expectedminimum expectedMinimum� o   � ��F�F 0 actualvalue actualValue� B   � ���� o   � ��E�E 0 actualvalue actualValue� o   � ��D�D "0 expectedmaximum expectedMaximum�H  ��   R      �C��
�C .ascrerr ****      � ****� o      �B�B 0 etext eText� �A��
�A 
errn� o      �@�@ 0 enumber eNumber� �?��
�? 
erob� o      �>�> 0 efrom eFrom� �=��<
�= 
errt� o      �;�; 
0 eto eTo�<   I     *�:��9�: 
0 _error  � ��� m   ! "�� ��� & n u m e r i c   r a n g e   c h e c k� ��� o   " #�8�8 0 etext eText� ��� o   # $�7�7 0 enumber eNumber� ��� o   $ %�6�6 0 efrom eFrom� ��5� o   % &�4�4 
0 eto eTo�5  �9   ��� l     �3�2�1�3  �2  �1  � ��� l     �0�/�.�0  �/  �.  � ��� l     �-���-  �  -----   � ��� 
 - - - - -� ��� l     �,���,  �   error checking   � ���    e r r o r   c h e c k i n g� ��� l     �+�*�)�+  �*  �)  � ��� i  j m��� I     �(�'�
�( .���:ExErnull��� ��� null�'  � �&��%
�& 
Usin� |�$�#��"��$  �#  � o      �!�! ,0 errorattributechecks errorAttributeChecks�"  � J      � �   �%  � l    r���� k     r�� ��� Q     f���� k    P�� ��� r    ��� n   ��� I    ���� &0 asrecordparameter asRecordParameter� ��� o    	�� ,0 errorattributechecks errorAttributeChecks� ��� m   	 
�� ��� 
 u s i n g�  �  � o    �� 0 _support  � o      �� ,0 errorattributechecks errorAttributeChecks� ��� r    3��� K    1�� ���� 0 errormessage errorMessage� o    �� .0 _defaultequalitycheck _defaultEqualityCheck� ���� 0 errornumber errorNumber� o    �� .0 _defaultequalitycheck _defaultEqualityCheck� ���� 0 	fromvalue 	fromValue� o    #�� .0 _defaultequalitycheck _defaultEqualityCheck� ���� 0 totype toType� o   $ )�� .0 _defaultequalitycheck _defaultEqualityCheck� ���� 0 partialresult partialResult� o   * /�� .0 _defaultequalitycheck _defaultEqualityCheck�  � o      �� :0 defaulterrorattributechecks defaultErrorAttributeChecks� ��� r   4 9��� b   4 7��� o   4 5�� ,0 errorattributechecks errorAttributeChecks� o   5 6�� :0 defaulterrorattributechecks defaultErrorAttributeChecks� o      �� 0 checkobjects checkObjects� ��
� l  : P���� Z  : P���	�� >   : A��� n   : =��� 1   ; =�
� 
leng� o   : ;�� 0 checkobjects checkObjects� n   = @��� 1   > @�
� 
leng� o   = >�� :0 defaulterrorattributechecks defaultErrorAttributeChecks� R   D L���
� .ascrerr ****      � ****� m   J K�� ��� � I n v a l i d    u s i n g    p a r a m e t e r   ( r e c o r d   c o n t a i n s   o n e   o r   m o r e   u n r e c o g n i z e d   p r o p e r t i e s ) .� ���
� 
errn� m   F G���Y� � ���
�  
erob� o   H I���� ,0 errorattributechecks errorAttributeChecks��  �	  �  � � � (note: this doesn't bother to check each property's type or that each object has a �compareObjects� handler as any problems there will raise errors if/when those error attributes are checked)   � ����   ( n o t e :   t h i s   d o e s n ' t   b o t h e r   t o   c h e c k   e a c h   p r o p e r t y ' s   t y p e   o r   t h a t   e a c h   o b j e c t   h a s   a    c o m p a r e O b j e c t s    h a n d l e r   a s   a n y   p r o b l e m s   t h e r e   w i l l   r a i s e   e r r o r s   i f / w h e n   t h o s e   e r r o r   a t t r i b u t e s   a r e   c h e c k e d )�
  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ��� 
�� 
errn� o      ���� 0 enumber eNumber  ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��  � I   X f������ 
0 _error    m   Y \ � " e x a c t   e r r o r   c h e c k 	
	 o   \ ]���� 0 etext eText
  o   ] ^���� 0 enumber eNumber  o   ^ _���� 0 efrom eFrom �� o   _ `���� 
0 eto eTo��  ��  � �� h   g r���� "0 exacterrorcheck ExactErrorCheck i     I      ������  0 compareobjects compareObjects  o      ���� 0 expectederror expectedError �� o      ���� 0 actualerror actualError��  ��   k     �  l     ����   � note: `assert test error` normalizes the `expectedError` record prior to calling compareObjects so it will always contain the following properties; any properties that were not supplied by the test script will contain the unique script object `NoValue`    ��   n o t e :   ` a s s e r t   t e s t   e r r o r `   n o r m a l i z e s   t h e   ` e x p e c t e d E r r o r `   r e c o r d   p r i o r   t o   c a l l i n g   c o m p a r e O b j e c t s   s o   i t   w i l l   a l w a y s   c o n t a i n   t h e   f o l l o w i n g   p r o p e r t i e s ;   a n y   p r o p e r t i e s   t h a t   w e r e   n o t   s u p p l i e d   b y   t h e   t e s t   s c r i p t   w i l l   c o n t a i n   t h e   u n i q u e   s c r i p t   o b j e c t   ` N o V a l u e `  X     � ��!  k   \ �"" #$# l  \ \��%&��  % � � AS fun fact: using `set {a,b,c} to aRef` is hideously slow compared to `set {a,b,c} to contents of aRef` -- TO DO: figure out why   & �''   A S   f u n   f a c t :   u s i n g   ` s e t   { a , b , c }   t o   a R e f `   i s   h i d e o u s l y   s l o w   c o m p a r e d   t o   ` s e t   { a , b , c }   t o   c o n t e n t s   o f   a R e f `   - -   T O   D O :   f i g u r e   o u t   w h y$ ()( r   \ u*+* n   \ _,-, 1   ] _��
�� 
pcnt- o   \ ]���� 0 aref aRef+ J      .. /0/ o      ���� $0 expectedproperty expectedProperty0 121 o      ����  0 actualproperty actualProperty2 3��3 o      ���� 0 checkobject checkObject��  ) 4��4 Z   v �56����5 >  v 787 o   v w���� $0 expectedproperty expectedProperty8 n  w ~9:9 o   | ~���� 0 novalue NoValue: o   w |���� 0 _testsupport _TestSupport6 Z  � �;<����; =  � �=>= n  � �?@? I   � ���A����  0 compareobjects compareObjectsA BCB o   � ����� $0 expectedproperty expectedPropertyC D��D o   � �����  0 actualproperty actualProperty��  ��  @ o   � ����� 0 checkobject checkObject> m   � ���
�� boovfals< L   � �EE m   � ���
�� boovfals��  ��  ��  ��  ��  �� 0 aref aRef! J    PFF GHG l 	  I����I J    JJ KLK n   MNM o    ���� 0 errornumber errorNumberN o    ���� 0 expectederror expectedErrorL OPO n   	QRQ o    	���� 0 errornumber errorNumberR o    ���� 0 actualerror actualErrorP S��S n   	 TUT o    ���� 0 errornumber errorNumberU o   	 ���� 0 checkobjects checkObjects��  ��  ��  H VWV l 	  !X����X J    !YY Z[Z n   \]\ o    ���� 0 errormessage errorMessage] o    ���� 0 expectederror expectedError[ ^_^ n   `a` o    ���� 0 errormessage errorMessagea o    ���� 0 actualerror actualError_ b��b n    cdc o    ���� 0 errormessage errorMessaged o    ���� 0 checkobjects checkObjects��  ��  ��  W efe l 	 ! 0g����g J   ! 0hh iji n  ! $klk o   " $���� 0 	fromvalue 	fromValuel o   ! "���� 0 expectederror expectedErrorj mnm n  $ 'opo o   % '���� 0 	fromvalue 	fromValuep o   $ %���� 0 actualerror actualErrorn q��q n   ' .rsr o   , .���� 0 	fromvalue 	fromValues o   ' ,���� 0 checkobjects checkObjects��  ��  ��  f tut l 	 0 ?v����v J   0 ?ww xyx n  0 3z{z o   1 3���� 0 totype toType{ o   0 1���� 0 expectederror expectedErrory |}| n  3 6~~ o   4 6���� 0 totype toType o   3 4���� 0 actualerror actualError} ���� n   6 =��� o   ; =���� 0 totype toType� o   6 ;���� 0 checkobjects checkObjects��  ��  ��  u ���� l 	 ? N������ l 
 ? N������ J   ? N�� ��� n  ? B��� o   @ B���� 0 partialresult partialResult� o   ? @���� 0 expectederror expectedError� ��� n  B E��� o   C E���� 0 partialresult partialResult� o   B C���� 0 actualerror actualError� ���� n   E L��� o   J L���� 0 partialresult partialResult� o   E J���� 0 checkobjects checkObjects��  ��  ��  ��  ��  ��   ���� L   � ��� m   � ���
�� boovtrue��  ��  � q k compare two �class ����� (expected/actual error records) for equality, ignoring any placeholder attributes   � ��� �   c o m p a r e   t w o   � c l a s s   �   � � �   ( e x p e c t e d / a c t u a l   e r r o r   r e c o r d s )   f o r   e q u a l i t y ,   i g n o r i n g   a n y   p l a c e h o l d e r   a t t r i b u t e s� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� j   n v����� (0 _defaulterrorcheck _defaultErrorCheck� I  n s������
�� .���:ExErnull��� ��� null��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �   Unit Test Assertions   � ��� *   U n i t   T e s t   A s s e r t i o n s� ��� l     ��������  ��  ��  � ��� i  w z��� I      ������� .0 _compareassertresults _compareAssertResults� ��� o      ���� 0 checkobject checkObject� ��� o      ����  0 expectedresult expectedResult� ��� o      ���� 0 actualresult actualResult� ��� o      ���� 0 
assertname 
assertName� ���� o      �� 0 usernote userNote��  ��  � Q     C���� L    �� n   
��� I    
�~��}�~  0 compareobjects compareObjects� ��� o    �|�|  0 expectedresult expectedResult� ��{� o    �z�z 0 actualresult actualResult�{  �}  � o    �y�y 0 checkobject checkObject� R      �x��
�x .ascrerr ****      � ****� o      �w�w 0 etext eText� �v��
�v 
errn� o      �u�u 0 enumber eNumber� �t��
�t 
erob� o      �s�s 0 efrom eFrom� �r��
�r 
errt� o      �q�q 
0 eto eTo� �p��o
�p 
ptlr� o      �n�n 0 epartial ePartial�o  � k    C�� ��� n   2��� I    2�m��l�m 0 	addbroken 	addBroken� ��� o    �k�k 0 
assertname 
assertName� ��� m    �� ��� D b r o k e   d u e   t o   e r r o r   i n   c h e c k   o b j e c t� ��� o    �j�j 0 usernote userNote� ��i� l 	  .��h�g� J    .�� ��f� J    ,�� ��� m    �� ���   u n e x p e c t e d   e r r o r� ��e� n   *��� I   ! *�d��c�d .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o   ! "�b�b 0 etext eText� ��� o   " #�a�a 0 enumber eNumber� ��� o   # $�`�` 0 efrom eFrom� ��� o   $ %�_�_ 
0 eto eTo� ��^� o   % &�]�] 0 epartial ePartial�^  �c  � o    !�\�\ 0 _testsupport _TestSupport�e  �f  �h  �g  �i  �l  � o    �[�[ 0 _testreport _testReport� ��Z� R   3 C�Y�X�
�Y .ascrerr ****      � ****�X  � �W��
�W 
errn� o   5 :�V�V 00 _abortedassertionerror _AbortedAssertionError� �U��T
�U 
erob� o   ; @�S�S 00 _abortedassertiontoken _AbortedAssertionToken�T  �Z  � ��� l     �R�Q�P�R  �Q  �P  � ��� l     �O���O  �  -----   � ��� 
 - - - - -� ��� l     �N�M�L�N  �M  �L  � � � i  { ~ I     �K�J
�K .���:AsRenull��� ��� null�J   �I
�I 
Valu o      �H�H 0 actualresult actualResult �G
�G 
Equa o      �F�F  0 expectedresult expectedResult �E	
�E 
Summ |�D�C
�B�D  �C  
 o      �A�A 0 usernote userNote�B   l     �@�? m       �  �@  �?  	 �>�=
�> 
Usin |�<�;�:�<  �;   o      �9�9 0 checkobject checkObject�:   l     �8�7 m      �6
�6 
msng�8  �7  �=   P     � k    �  Z   �5�4 =    o    
�3�3 0 _suiteobject _suiteObject m   
 �2
�2 
msng R    �1
�1 .ascrerr ****      � **** m     �   l C a n n o t   u s e    a s s e r t   t e s t   r e s u l t    o u t s i d e   o f   u n i t   t e s t s . �0!�/
�0 
errn! m    �.�.�T�/  �5  �4   "#" Q    |$%&$ k    8'' ()( r    **+* n   (,-, I   " (�-.�,�- "0 astextparameter asTextParameter. /0/ o   " #�+�+ 0 usernote userNote0 1�*1 m   # $22 �33  n o t e�*  �,  - o    "�)�) 0 _support  + o      �(�( 0 usernote userNote) 4�'4 r   + 8565 I   + 6�&7�%�& 20 _ascheckobjectparameter _asCheckObjectParameter7 898 o   , -�$�$ 0 checkobject checkObject9 :�#: o   - 2�"�" .0 _defaultequalitycheck _defaultEqualityCheck�#  �%  6 o      �!�! 0 checkobject checkObject�'  % R      � ;<
�  .ascrerr ****      � ****; o      �� 0 etext eText< �=>
� 
errn= o      �� 0 enumber eNumber> �?@
� 
erob? o      �� 0 efrom eFrom@ �AB
� 
errtA o      �� 
0 eto eToB �C�
� 
ptlrC o      �� 0 epartial ePartial�  & k   @ |DD EFE n  @ gGHG I   E g�I�� 0 	addbroken 	addBrokenI JKJ m   E FLL �MM $ a s s e r t   t e s t   r e s u l tK NON m   F GPP �QQ . r e c e i v e d   b a d   p a r a m e t e r sO RSR o   G H�� 0 usernote userNoteS T�T l 	 H aU��U J   H aVV WXW J   H YYY Z[Z m   H I\\ �]]   u n e x p e c t e d   e r r o r[ ^�^ n  I W_`_ I   N W�a�� .0 makecaughterrorrecord makeCaughtErrorRecorda bcb o   N O�� 0 etext eTextc ded o   O P�� 0 enumber eNumbere fgf o   P Q�
�
 0 efrom eFromg hih o   Q R�	�	 
0 eto eToi j�j o   R S�� 0 epartial ePartial�  �  ` o   I N�� 0 _testsupport _TestSupport�  X k�k J   Y _ll mnm m   Y \oo �pp  e x p e c t e d   r e s u l tn q�q o   \ ]��  0 expectedresult expectedResult�  �  �  �  �  �  H o   @ E�� 0 _testreport _testReportF r�r R   h |� ��s
�  .ascrerr ****      � ****��  s ��tu
�� 
errnt o   j o���� 00 _abortedassertionerror _AbortedAssertionErroru ��v��
�� 
erobv o   r w���� 00 _abortedassertiontoken _AbortedAssertionToken��  �  # wxw r   } �yzy I   } ���{���� ,0 _ascheckobjectresult _asCheckObjectResult{ |��| I   ~ ���}���� .0 _compareassertresults _compareAssertResults} ~~ o    ����� 0 checkobject checkObject ��� o   � �����  0 expectedresult expectedResult� ��� o   � ����� 0 actualresult actualResult� ��� m   � ��� ��� $ a s s e r t   t e s t   r e s u l t� ���� o   � ����� 0 usernote userNote��  ��  ��  ��  z o      ���� 0 isequal isEqualx ��� r   � ���� J   � ��� ��� J   � ��� ��� m   � ��� ���  a c t u a l   r e s u l t� ���� o   � ����� 0 actualresult actualResult��  � ���� J   � ��� ��� m   � ��� ���  e x p e c t e d   r e s u l t� ���� o   � �����  0 expectedresult expectedResult��  ��  � o      ���� 0 testdata testData� ���� Z   � ������� o   � ����� 0 isequal isEqual� k   � ��� ��� n  � ���� I   � �������� 0 
addsuccess 
addSuccess� ��� m   � ��� ��� $ a s s e r t   t e s t   r e s u l t� ��� o   � ����� 0 usernote userNote� ���� o   � ����� 0 testdata testData��  ��  � o   � ����� 0 _testreport _testReport� ���� L   � �����  ��  ��  � k   � ��� ��� n  � ���� I   � �������� 0 
addfailure 
addFailure� ��� m   � ��� ��� $ a s s e r t   t e s t   r e s u l t� ��� m   � ��� ��� 2 r e c e i v e d   i n c o r r e c t   r e s u l t� ��� o   � ����� 0 usernote userNote� ���� o   � ����� 0 testdata testData��  ��  � o   � ����� 0 _testreport _testReport� ���� R   � ������
�� .ascrerr ****      � ****��  � ����
�� 
errn� o   � ����� 00 _abortedassertionerror _AbortedAssertionError� �����
�� 
erob� o   � ����� 00 _abortedassertiontoken _AbortedAssertionToken��  ��  ��   ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��   ����
�� consnume��    ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i   ���� I     �����
�� .���:AsErnull��� ��� null��  � ����
�� 
Hand� |����������  ��  � o      ���� "0 callhandlername callHandlerName��  � l     ������ m      �� ���  ��  ��  � ����
�� 
Args� |����������  ��  � o      ����  0 parametervalue parameterValue��  � l     ������ m      ��
�� 
���!��  ��  � ����
�� 
Equa� o      ���� 0 expectederror expectedError� ����
�� 
Summ� |����������  ��  � o      ���� 0 usernote userNote��  � l     ������ m      �� ���  ��  ��  � �����
�� 
Usin� |����������  ��  � o      ���� 0 checkobject checkObject��  � l     ������ m      ��
�� 
msng��  ��  ��  � P    X���� k   W�� ��� Z   ������� =   ��� o    
���� 0 _suiteobject _suiteObject� m   
 ��
�� 
msng� R    ����
�� .ascrerr ****      � ****� m    �� ��� j C a n n o t   u s e    a s s e r t   t e s t   e r r o r    o u t s i d e   o f   u n i t   t e s t s .� �����
�� 
errn� m    �����T��  ��  ��  � ��� Q    ����� k    a��    r    * n   ( I   " (������ "0 astextparameter asTextParameter  o   " #���� "0 callhandlername callHandlerName 	��	 m   # $

 �  i n��  ��   o    "���� 0 _support   o      ���� "0 callhandlername callHandlerName  r   + 8 n  + 6 I   0 6������ &0 asrecordparameter asRecordParameter  o   0 1���� 0 expectederror expectedError �� m   1 2 �  i s��  ��   o   + 0���� 0 _support   o      ���� 0 expectederror expectedError  r   9 E n  9 C I   > C������ <0 normalizeexpectederrorrecord normalizeExpectedErrorRecord �� o   > ?���� 0 expectederror expectedError��  ��   o   9 >���� 0 _testsupport _TestSupport o      ���� 0 expectederror expectedError  !  l  F F��"#��  " � � TO DO: what about checking expectedError record's properties are valid types (e.g. error number should be integer, message should be text, etc.), and abort with broken test if not   # �$$h   T O   D O :   w h a t   a b o u t   c h e c k i n g   e x p e c t e d E r r o r   r e c o r d ' s   p r o p e r t i e s   a r e   v a l i d   t y p e s   ( e . g .   e r r o r   n u m b e r   s h o u l d   b e   i n t e g e r ,   m e s s a g e   s h o u l d   b e   t e x t ,   e t c . ) ,   a n d   a b o r t   w i t h   b r o k e n   t e s t   i f   n o t! %&% r   F S'(' n  F Q)*) I   K Q��+���� "0 astextparameter asTextParameter+ ,-, o   K L���� 0 usernote userNote- .��. m   L M// �00  n o t e��  ��  * o   F K�� 0 _support  ( o      �~�~ 0 usernote userNote& 1�}1 r   T a232 I   T _�|4�{�| 20 _ascheckobjectparameter _asCheckObjectParameter4 565 o   U V�z�z 0 checkobject checkObject6 7�y7 o   V [�x�x (0 _defaulterrorcheck _defaultErrorCheck�y  �{  3 o      �w�w 0 checkobject checkObject�}  � R      �v89
�v .ascrerr ****      � ****8 o      �u�u 0 etext eText9 �t:;
�t 
errn: o      �s�s 0 enumber eNumber; �r<=
�r 
erob< o      �q�q 0 efrom eFrom= �p>?
�p 
errt> o      �o�o 
0 eto eTo? �n@�m
�n 
ptlr@ o      �l�l 0 epartial ePartial�m  � k   i �AA BCB n  i �DED I   n ��kF�j�k 0 	addbroken 	addBrokenF GHG m   n oII �JJ " a s s e r t   t e s t   e r r o rH KLK m   o rMM �NN . r e c e i v e d   b a d   p a r a m e t e r sL OPO o   r s�i�i 0 usernote userNoteP Q�hQ l 	 s �R�g�fR J   s �SS T�eT J   s �UU VWV m   s vXX �YY   u n e x p e c t e d   e r r o rW Z�dZ n  v �[\[ I   { ��c]�b�c .0 makecaughterrorrecord makeCaughtErrorRecord] ^_^ o   { |�a�a 0 etext eText_ `a` o   | }�`�` 0 enumber eNumbera bcb o   } ~�_�_ 0 efrom eFromc ded o   ~ �^�^ 
0 eto eToe f�]f o    ��\�\ 0 epartial ePartial�]  �b  \ o   v {�[�[ 0 _testsupport _TestSupport�d  �e  �g  �f  �h  �j  E o   i n�Z�Z 0 _testreport _testReportC g�Yg R   � ��X�Wh
�X .ascrerr ****      � ****�W  h �Vij
�V 
errni o   � ��U�U 00 _abortedassertionerror _AbortedAssertionErrorj �Tk�S
�T 
erobk o   � ��R�R 00 _abortedassertiontoken _AbortedAssertionToken�S  �Y  � lml l  � ��Qno�Q  n G A code-generate a script object to invoke the `call_NAME` handler�   o �pp �   c o d e - g e n e r a t e   a   s c r i p t   o b j e c t   t o   i n v o k e   t h e   ` c a l l _ N A M E `   h a n d l e r &m qrq P   � �s�Pts Z   � �uvw�Ou =  � �xyx o   � ��N�N "0 callhandlername callHandlerNamey m   � �zz �{{  v l  � �|}~| r   � �� b   � ���� m   � ��� ���  c a l l� l  � ���M�L� n   � ���� 7  � ��K��
�K 
ctxt� m   � ��J�J � m   � ��I�I��� o   � ��H�H $0 _testhandlername _testHandlerName�M  �L  � o      �G�G "0 callhandlername callHandlerName} | v if `for` parameter is omitted, automatically call a `call_NAME` handler with the same NAME as the `test_NAME` handler   ~ ��� �   i f   ` f o r `   p a r a m e t e r   i s   o m i t t e d ,   a u t o m a t i c a l l y   c a l l   a   ` c a l l _ N A M E `   h a n d l e r   w i t h   t h e   s a m e   N A M E   a s   t h e   ` t e s t _ N A M E `   h a n d l e rw ��� H   � ��� C   � ���� o   � ��F�F "0 callhandlername callHandlerName� m   � ��� ��� 
 c a l l _� ��E� r   � ���� b   � ���� m   � ��� ��� 
 c a l l _� o   � ��D�D "0 callhandlername callHandlerName� o      �C�C "0 callhandlername callHandlerName�E  �O  �P  t �B�A
�B conscase�A  r ��� Z   ����@�� =  � ���� o   � ��?�?  0 parametervalue parameterValue� m   � ��>
�> 
���!� r   � ���� n  � ���� I   � ��=��<�=  0 makecallobject makeCallObject� ��� o   � ��;�; "0 callhandlername callHandlerName� ��:� m   � ��9�9  �:  �<  � o   � ��8�8 0 _testsupport _TestSupport� o      �7�7 0 
callobject 
callObject�@  � r   ���� n  �
��� I  
�6��5�6  0 makecallobject makeCallObject� ��� o  �4�4 "0 callhandlername callHandlerName� ��3� m  �2�2 �3  �5  � o   ��1�1 0 _testsupport _TestSupport� o      �0�0 0 
callobject 
callObject� ��� l �/���/  �   �then call it   � ���    & t h e n   c a l l   i t� ��� l >���� r  >��� J  "�� ��� n ��� o  �.�. 0 novalue NoValue� o  �-�- 0 _testsupport _TestSupport� ��� n ��� o  �,�, 0 novalue NoValue� o  �+�+ 0 _testsupport _TestSupport� ��*� m   �)
�) boovfals�*  � J      �� ��� o      �(�( 0 actualerror actualError� ��� o      �'�' 0 actualresult actualResult� ��&� o      �%�% 0 isequal isEqual�&  � \ V TO DO: rename isEqual to isSuccess once 'is equal' test code is moved to Check object   � ��� �   T O   D O :   r e n a m e   i s E q u a l   t o   i s S u c c e s s   o n c e   ' i s   e q u a l '   t e s t   c o d e   i s   m o v e d   t o   C h e c k   o b j e c t� ��� Q  ?���� l BO���� r  BO��� n BM��� I  CM�$��#�$ 0 dotest doTest� ��� o  CH�"�" 0 _suiteobject _suiteObject� ��!� o  HI� �   0 parametervalue parameterValue�!  �#  � o  BC�� 0 
callobject 
callObject� o      �� 0 actualresult actualResult� n h note: this may return literal 'no value' due to AS's schlonky design - this will be accounted for below   � ��� �   n o t e :   t h i s   m a y   r e t u r n   l i t e r a l   ' n o   v a l u e '   d u e   t o   A S ' s   s c h l o n k y   d e s i g n   -   t h i s   w i l l   b e   a c c o u n t e d   f o r   b e l o w� R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo� ���
� 
ptlr� o      �� 0 epartial ePartial�  � k  W�� ��� l WW����  � y s compare expected vs actual error info, ignoring any actual error info that user-supplied record doesn't care about   � ��� �   c o m p a r e   e x p e c t e d   v s   a c t u a l   e r r o r   i n f o ,   i g n o r i n g   a n y   a c t u a l   e r r o r   i n f o   t h a t   u s e r - s u p p l i e d   r e c o r d   d o e s n ' t   c a r e   a b o u t� ��� r  Wi��� n Wg��� I  \g���� .0 makecaughterrorrecord makeCaughtErrorRecord� ��� o  \]�� 0 etext eText� ��� o  ]^�� 0 enumber eNumber� ��� o  ^_�� 0 efrom eFrom� ��� o  _`�� 
0 eto eTo� ��� o  `a�
�
 0 epartial ePartial�  �  � o  W\�	�	 0 _testsupport _TestSupport� o      �� 0 actualerror actualError� ��� r  j��� I  j}�	 �� ,0 _ascheckobjectresult _asCheckObjectResult	  	�	 I  ky�	�� .0 _compareassertresults _compareAssertResults	 			 o  lm�� 0 checkobject checkObject	 			 o  mn� �  0 expectederror expectedError	 			 o  no���� 0 actualerror actualError	 			
		 m  or		 �		 " a s s e r t   t e s t   e r r o r	
 	��	 o  rs���� 0 usernote userNote��  �  �  �  � o      ���� 0 isequal isEqual�  � 	��	 Z  �W		��		 o  ������ 0 isequal isEqual	 l ��				 k  ��		 			 n ��			 I  ����	���� 0 
addsuccess 
addSuccess	 			 m  ��		 �		 " a s s e r t   t e s t   e r r o r	 		 	 o  ������ 0 usernote userNote	  	!��	! J  ��	"	" 	#	$	# J  ��	%	% 	&	'	& m  ��	(	( �	)	)  a c t u a l   e r r o r	' 	*��	* o  ������ 0 actualerror actualError��  	$ 	+��	+ J  ��	,	, 	-	.	- m  ��	/	/ �	0	0  e x p e c t e d   e r r o r	. 	1��	1 o  ������ 0 expectederror expectedError��  ��  ��  ��  	 o  ������ 0 _testreport _testReport	 	2��	2 L  ������  ��  	   success   	 �	3	3    s u c c e s s��  	 l �W	4	5	6	4 k  �W	7	7 	8	9	8 Q  ��	:	;	<	: l ��	=	>	?	= l ��	@	A	B	@ r  ��	C	D	C o  ������ 0 actualresult actualResult	D o      ���� 0 actualresult actualResult	A � z this variable lookup fails if call_NAME returned nothing (i.e. `null`, which AS literally treats as 'no value at all')...   	B �	E	E �   t h i s   v a r i a b l e   l o o k u p   f a i l s   i f   c a l l _ N A M E   r e t u r n e d   n o t h i n g   ( i . e .   ` n u l l ` ,   w h i c h   A S   l i t e r a l l y   t r e a t s   a s   ' n o   v a l u e   a t   a l l ' ) . . .	> g a kludge-around for AS's dumb commands-are-not-expressions-so-do-not-have-to-return-results design   	? �	F	F �   k l u d g e - a r o u n d   f o r   A S ' s   d u m b   c o m m a n d s - a r e - n o t - e x p r e s s i o n s - s o - d o - n o t - h a v e - t o - r e t u r n - r e s u l t s   d e s i g n	; R      ����	G
�� .ascrerr ****      � ****��  	G ��	H��
�� 
errn	H d      	I	I m      ����
���  	< l ��	J	K	L	J r  ��	M	N	M n ��	O	P	O o  ������ 0 novalue NoValue	P o  ������ 0 _testsupport _TestSupport	N o      ���� 0 actualresult actualResult	K a [ ... in which case replace it with a 'no value placeholder' object that AS can actually see   	L �	Q	Q �   . . .   i n   w h i c h   c a s e   r e p l a c e   i t   w i t h   a   ' n o   v a l u e   p l a c e h o l d e r '   o b j e c t   t h a t   A S   c a n   a c t u a l l y   s e e	9 	R	S	R Z ��	T	U����	T > ��	V	W	V o  ������ 0 actualerror actualError	W n ��	X	Y	X o  ������ 0 novalue NoValue	Y o  ������ 0 _testsupport _TestSupport	U r  ��	Z	[	Z J  ��	\	\ 	]	^	] m  ��	_	_ �	`	` 0 r e c e i v e d   i n c o r r e c t   e r r o r	^ 	a��	a J  ��	b	b 	c	d	c J  ��	e	e 	f	g	f m  ��	h	h �	i	i  a c t u a l   e r r o r	g 	j��	j o  ������ 0 actualerror actualError��  	d 	k��	k J  ��	l	l 	m	n	m m  ��	o	o �	p	p  e x p e c t e d   e r r o r	n 	q��	q o  ������ 0 expectederror expectedError��  ��  ��  	[ J      	r	r 	s	t	s o      ���� 0 problemtype problemType	t 	u��	u o      ���� 0 testdata testData��  ��  ��  	S 	v	w	v Z �0	x	y����	x > �	z	{	z o  ������ 0 actualresult actualResult	{ n �	|	}	| o  ����� 0 novalue NoValue	} o  ������ 0 _testsupport _TestSupport	y r  ,	~		~ J  	�	� 	�	�	� m  		�	� �	�	� " r e c e i v e d   n o   e r r o r	� 	���	� J  		�	� 	�	�	� J  		�	� 	�	�	� m  		�	� �	�	� " u n e x p e c t e d   r e s u l t	� 	���	� o  ���� 0 actualresult actualResult��  	� 	���	� J  	�	� 	�	�	� m  	�	� �	�	�  e x p e c t e d   e r r o r	� 	���	� o  ���� 0 expectederror expectedError��  ��  ��  	 J      	�	� 	�	�	� o      ���� 0 problemtype problemType	� 	���	� o      ���� 0 testdata testData��  ��  ��  	w 	�	�	� n 1B	�	�	� I  6B��	����� 0 
addfailure 
addFailure	� 	�	�	� m  69	�	� �	�	� " a s s e r t   t e s t   e r r o r	� 	�	�	� o  9:���� 0 problemtype problemType	� 	�	�	� o  :;���� 0 usernote userNote	� 	���	� o  ;<���� 0 testdata testData��  ��  	� o  16���� 0 _testreport _testReport	� 	���	� R  CW����	�
�� .ascrerr ****      � ****��  	� ��	�	�
�� 
errn	� o  EJ���� 00 _abortedassertionerror _AbortedAssertionError	� ��	���
�� 
erob	� o  MR���� 00 _abortedassertiontoken _AbortedAssertionToken��  ��  	5 2 , raised wrong error or didn't raise an error   	6 �	�	� X   r a i s e d   w r o n g   e r r o r   o r   d i d n ' t   r a i s e   a n   e r r o r��  � ��	�
�� conscase	� ��	�
�� consdiac	� ��	�
�� conshyph	� ��	�
�� conspunc	� ����
�� conswhit��  � ����
�� consnume��  � 	�	�	� l     ��������  ��  ��  	� 	�	�	� l     ��������  ��  ��  	� 	�	�	� l     ��	�	���  	�  -----   	� �	�	� 
 - - - - -	� 	�	�	� l     ��������  ��  ��  	� 	�	�	� i  � �	�	�	� I      ��	�����  0 _genericassert _genericAssert	� 	�	�	� o      ���� 0 
assertname 
assertName	� 	�	�	� o      ���� 0 
didsucceed 
didSucceed	� 	�	�	� o      ���� 0 actualresult actualResult	� 	���	� o      ���� 0 usernote userNote��  ��  	� P     �	�	�	�	� k    �	�	� 	�	�	� Z   	�	�����	� =   	�	�	� o    
���� 0 _suiteobject _suiteObject	� m   
 ��
�� 
msng	� R    ��	�	�
�� .ascrerr ****      � ****	� b    	�	�	� b    	�	�	� m    	�	� �	�	�  C a n n o t   u s e   	� o    ���� 0 
assertname 
assertName	� m    	�	� �	�	� 0    o u t s i d e   o f   u n i t   t e s t s .	� ��	���
�� 
errn	� m    �����T��  ��  ��  	� 	�	�	� Q    h	�	�	�	� r   ! .	�	�	� n  ! ,	�	�	� I   & ,��	����� "0 astextparameter asTextParameter	� 	�	�	� o   & '���� 0 usernote userNote	� 	���	� m   ' (	�	� �	�	�  n o t e��  ��  	� o   ! &���� 0 _support  	� o      ���� 0 usernote userNote	� R      ��	�	�
�� .ascrerr ****      � ****	� o      ���� 0 etext eText	� ��	�	�
�� 
errn	� o      ���� 0 enumber eNumber	� ��	�	�
�� 
erob	� o      ���� 0 efrom eFrom	� ��	�	�
�� 
errt	� o      ���� 
0 eto eTo	� ��	���
�� 
ptlr	� o      ���� 0 epartial ePartial��  	� k   6 h	�	� 	�	�	� n  6 U	�	�	� I   ; U��	����� 0 	addbroken 	addBroken	� 	�	�	� o   ; <���� 0 
assertname 
assertName	� 	�	�	� m   < =
 
  �

 . r e c e i v e d   b a d   p a r a m e t e r s	� 


 o   = >���� 0 usernote userNote
 
��
 l 	 > Q
��~
 J   > Q

 
�}
 J   > O

 
	


	 m   > ?

 �

   u n e x p e c t e d   e r r o r

 
�|
 n  ? M


 I   D M�{
�z�{ .0 makecaughterrorrecord makeCaughtErrorRecord
 


 o   D E�y�y 0 etext eText
 


 o   E F�x�x 0 enumber eNumber
 


 o   F G�w�w 0 efrom eFrom
 


 o   G H�v�v 
0 eto eTo
 
�u
 o   H I�t�t 0 epartial ePartial�u  �z  
 o   ? D�s�s 0 _testsupport _TestSupport�|  �}  �  �~  ��  ��  	� o   6 ;�r�r 0 _testreport _testReport	� 
�q
 R   V h�p�o

�p .ascrerr ****      � ****�o  
 �n


�n 
errn
 o   X ]�m�m 00 _abortedassertionerror _AbortedAssertionError
 �l
�k
�l 
erob
 o   ` e�j�j 00 _abortedassertiontoken _AbortedAssertionToken�k  �q  	� 

 
 Z   i �
!
"�i
#
! =  i n
$
%
$ o   i j�h�h 0 actualresult actualResult
% m   j m�g
�g 
���!
" r   q u
&
'
& J   q s�f�f  
' o      �e�e 0 testdata testData�i  
# r   x �
(
)
( J   x �
*
* 
+�d
+ J   x ~
,
, 
-
.
- m   x {
/
/ �
0
0  a c t u a l   r e s u l t
. 
1�c
1 o   { |�b�b 0 actualresult actualResult�c  �d  
) o      �a�a 0 testdata testData
  
2�`
2 Z   � �
3
4�_
5
3 o   � ��^�^ 0 
didsucceed 
didSucceed
4 k   � �
6
6 
7
8
7 n  � �
9
:
9 I   � ��]
;�\�] 0 
addsuccess 
addSuccess
; 
<
=
< o   � ��[�[ 0 
assertname 
assertName
= 
>
?
> o   � ��Z�Z 0 usernote userNote
? 
@�Y
@ o   � ��X�X 0 testdata testData�Y  �\  
: o   � ��W�W 0 _testreport _testReport
8 
A�V
A L   � ��U�U  �V  �_  
5 k   � �
B
B 
C
D
C n  � �
E
F
E I   � ��T
G�S�T 0 
addfailure 
addFailure
G 
H
I
H o   � ��R�R 0 
assertname 
assertName
I 
J
K
J m   � �
L
L �
M
M  
K 
N
O
N o   � ��Q�Q 0 usernote userNote
O 
P�P
P o   � ��O�O 0 testdata testData�P  �S  
F o   � ��N�N 0 _testreport _testReport
D 
Q�M
Q R   � ��L�K
R
�L .ascrerr ****      � ****�K  
R �J
S
T
�J 
errn
S o   � ��I�I 00 _abortedassertionerror _AbortedAssertionError
T �H
U�G
�H 
erob
U o   � ��F�F 00 _abortedassertiontoken _AbortedAssertionToken�G  �M  �`  	� �E
V
�E conscase
V �D
W
�D consdiac
W �C
X
�C conshyph
X �B
Y
�B conspunc
Y �A�@
�A conswhit�@  	� �?�>
�? consnume�>  	� 
Z
[
Z l     �=�<�;�=  �<  �;  
[ 
\
]
\ l     �:�9�8�:  �9  �8  
] 
^
_
^ l     �7�6�5�7  �6  �5  
_ 
`
a
` i  � �
b
c
b I     �4�3
d
�4 .���:AsPanull��� ��� null�3  
d �2
e
f
�2 
Valu
e |�1�0
g�/
h�1  �0  
g o      �.�. 0 actualresult actualResult�/  
h l     
i�-�,
i m      �+
�+ 
���!�-  �,  
f �*
j�)
�* 
Summ
j |�(�'
k�&
l�(  �'  
k o      �%�% 0 usernote userNote�&  
l l     
m�$�#
m m      
n
n �
o
o  �$  �#  �)  
c l    	
p
q
r
p I     	�"
s�!�"  0 _genericassert _genericAssert
s 
t
u
t m    
v
v �
w
w $ a s s e r t   t e s t   p a s s e d
u 
x
y
x m    � 
�  boovtrue
y 
z
{
z o    �� 0 actualresult actualResult
{ 
|�
| o    �� 0 usernote userNote�  �!  
q 9 3 TO DO: optional param for passing expected result?   
r �
}
} f   T O   D O :   o p t i o n a l   p a r a m   f o r   p a s s i n g   e x p e c t e d   r e s u l t ?
a 
~

~ l     ����  �  �  
 
�
�
� l     ����  �  �  
� 
�
�
� i  � �
�
�
� I     ��
�
� .���:AsFanull��� ��� null�  
� �
�
�
� 
Valu
� |��
��
��  �  
� o      �� 0 actualresult actualResult�  
� l     
���
� m      �
� 
���!�  �  
� �
��
� 
Summ
� |�
�	
��
��
  �	  
� o      �� 0 usernote userNote�  
� l     
���
� m      
�
� �
�
�  �  �  �  
� l    	
�
�
�
� I     	�
���  0 _genericassert _genericAssert
� 
�
�
� m    
�
� �
�
� $ a s s e r t   t e s t   f a i l e d
� 
�
�
� m    �
� boovfals
� 
�
�
� o    �� 0 actualresult actualResult
� 
�� 
� o    ���� 0 usernote userNote�   �  
� 9 3 TO DO: optional param for passing expected result?   
� �
�
� f   T O   D O :   o p t i o n a l   p a r a m   f o r   p a s s i n g   e x p e c t e d   r e s u l t ?
� 
�
�
� l     ��������  ��  ��  
� 
�
�
� l     ��
�
���  
�  -----   
� �
�
� 
 - - - - -
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
� I     ������
�� .���:TRPanull��� ��� null��  ��  
� Q     0
�
�
�
� l   
�
�
�
� Q    
�
�
�
� L    
�
� c    
�
�
� l   
�����
� I   ��
�
�
�� .sysorpthalis        TEXT
� m    
�
� �
�
�  o s a t e s t
� ��
���
�� 
in D
� m    	
�
� �
�
�  b i n��  ��  ��  
� m    ��
�� 
furl
� R      ����
�
�� .ascrerr ****      � ****��  
� ��
���
�� 
errn
� d      
�
� m      ����
���  
� l   
�
�
�
� R    ��
�
�
�� .ascrerr ****      � ****
� m    
�
� �
�
� 0 A   r e s o u r c e   w a s n  t   f o u n d .
� ��
���
�� 
errn
� m    �����@��  
� R L returned 'nothing' instead of raising 'resource not found' error (very odd)   
� �
�
� �   r e t u r n e d   ' n o t h i n g '   i n s t e a d   o f   r a i s i n g   ' r e s o u r c e   n o t   f o u n d '   e r r o r   ( v e r y   o d d )
� I C shouldn't fail unless TestTools library has been incorrectly built   
� �
�
� �   s h o u l d n ' t   f a i l   u n l e s s   T e s t T o o l s   l i b r a r y   h a s   b e e n   i n c o r r e c t l y   b u i l t
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
� I   & 0��
����� 
0 _error  
� 
�
�
� m   ' (
�
� �
�
�   u n i t   t e s t   r u n n e r
� 
�
�
� o   ( )���� 0 etext eText
� 
�
�
� o   ) *���� 0 enumber eNumber
� 
�
�
� o   * +���� 0 efrom eFrom
� 
���
� o   + ,���� 
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
� i   � �
�
�
� I     ��
���
�� .���:RunTnull���     file
� o      ���� 0 testfile testFile��  
� l    5
�
�
�
� Q     5
�
�
�
� L    #
�
� I   "��
�
�
�� .sysoexecTEXT���     TEXT
� b    
�
�
� b    
�
�
� l   
�����
� n    
�
�
� 1   
 ��
�� 
strq
� n    

�
�
� 1    
��
�� 
psxp
� l   
�����
� I   ������
�� .���:TRPanull��� ��� null��  ��  ��  ��  ��  ��  
� l 
  
�����
� 1    ��
�� 
spac��  ��  
� l   
�����
� n    
� 
� 1    ��
�� 
strq  n    I    ������ ,0 asposixpathparameter asPOSIXPathParameter  o    ���� 0 testfile testFile �� m     �  ��  ��   o    ���� 0 _support  ��  ��  
� ��	��
�� 
alen	 m    ��
�� boovfals��  
� R      ��

�� .ascrerr ****      � ****
 o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��  
� I   + 5������ 
0 _error    m   , - �  r u n   u n i t   t e s t s  o   - .���� 0 etext eText  o   . /���� 0 enumber eNumber  o   / 0���� 0 efrom eFrom �� o   0 1���� 
0 eto eTo��  ��  
� . ( e.g. for running tests in Script Editor   
� � P   e . g .   f o r   r u n n i n g   t e s t s   i n   S c r i p t   E d i t o r
� �� l     ��������  ��  ��  ��       �� !"#$��%������&'()*+,-./01234567��   ��������������������������������������������������������
�� 
pimr�� 0 _support  �� 
0 _error  �� 0 _testsupport _TestSupport
�� .���:MTmrnull��� ��� ctxt�� 00 _abortedassertionerror _AbortedAssertionError�� 00 _abortedassertiontoken _AbortedAssertionToken�� 0 _suiteobject _suiteObject�� 0 _testreport _testReport�� $0 _testhandlername _testHandlerName�� 0 __performunittestforsuite__  �� 20 _ascheckobjectparameter _asCheckObjectParameter�� ,0 _ascheckobjectresult _asCheckObjectResult
�� .���:ExEqnull��� ��� null�� .0 _defaultequalitycheck _defaultEqualityCheck
�� .���:ExMunull��� ��� null
�� .���:NmEqnull��� ��� null
�� .���:NmRgnull��� ��� null
�� .���:ExErnull��� ��� null�� (0 _defaulterrorcheck _defaultErrorCheck�� .0 _compareassertresults _compareAssertResults
�� .���:AsRenull��� ��� null
�� .���:AsErnull��� ��� null��  0 _genericassert _genericAssert
�� .���:AsPanull��� ��� null
�� .���:AsFanull��� ��� null
�� .���:TRPanull��� ��� null
�� .���:RunTnull���     file  �8� 8  9:9 �~;�}
�~ 
cobj; <<   �| 
�| 
frmk�}  : �{=�z
�{ 
cobj= >>   �y
�y 
osax�z  ! ??   �x -
�x 
scpt" �w 5�v�u@A�t�w 
0 _error  �v �sB�s B  �r�q�p�o�n�r 0 handlername handlerName�q 0 etext eText�p 0 enumber eNumber�o 0 efrom eFrom�n 
0 eto eTo�u  @ �m�l�k�j�i�m 0 handlername handlerName�l 0 etext eText�k 0 enumber eNumber�j 0 efrom eFrom�i 
0 eto eToA  E�h�g�h �g &0 throwcommanderror throwCommandError�t b  ࠡ����+ # CC   �f \
�f 
scpt$ �e r�d�cDE�b
�e .���:MTmrnull��� ��� ctxt�d {�a�` w�a 0 nametext nameText�`  �c  D �_�^�_ 0 nametext nameText�^ 0 timerobject TimerObjectE �] yF�] 0 timerobject TimerObjectF �\G�[�ZHI�Y
�\ .ascrinit****      � ****G k     'JJ  �KK  �LL  �MM  �NN  �OO  �PP  �QQ  �RR  ��X�X  �[  �Z  H 	�W�V�U�T�S�R�Q�P�O
�W 
pimr�V 0 
_starttime 
_startTime�U 0 _totalseconds _totalSeconds�T 0 
_isrunning 
_isRunning�S 0 	timername 	timerName�R 0 
starttimer 
startTimer�Q 0 	stoptimer 	stopTimer�P 0 elapsedtime elapsedTime�O 0 	totaltime 	totalTimeI �N�M ��L�K ��J�ISTUVW
�N 
cobj
�M 
frmk
�L 
msng�K 0 
_starttime 
_startTime�J 0 _totalseconds _totalSeconds�I 0 
_isrunning 
_isRunningS �H ��G�FXY�E�H 0 	timername 	timerName�G  �F  X  Y  �E b   T �D ��C�BZ[�A�D 0 
starttimer 
startTimer�C  �B  Z  [ �@�?�>
�@ misccura�? 0 nsdate NSDate�> @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�A (b   hY hOeEc  O��,j+ Ec  O)U �= ��<�;\]�:�= 0 	stoptimer 	stopTimer�<  �;  \ �9�9 0 elapsedtime elapsedTime] �8�7�6
�8 misccura�7 0 nsdate NSDate�6 @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�: 9b   jY hO��,j+ b  E�Ob  �Ec  OfEc  O�V �5 ��4�3^_�2�5 0 elapsedtime elapsedTime�4  �3  ^ �1�1 0 nsdate NSDate_ �0�0 @0 timeintervalsincereferencedate timeIntervalSinceReferenceDate�2 b   �j+  b  Y jW �/ ��.�-`a�,�/ 0 	totaltime 	totalTime�.  �-  `  a �+�+ 0 elapsedtime elapsedTime�, b   b  *j+  Y b  �Y (�*��/lkv��O�Of�OL OL 	OL 
OL OL �b ��K S���A% �*  b�* 00 _abortedassertiontoken _AbortedAssertionTokenb  cc  
�� 
msng
�� 
msng
�� 
msng& �)K�(�'de�&�) 0 __performunittestforsuite__  �( �%f�% f  �$g�$ 0 suiteobject suiteObjectg �#h�# h  �"�!� �" 0 	suitename 	suiteName�! 0 handlername handlerName�  0 isstyled isStyled�'  d ������������� 0 suiteobject suiteObject� 0 	suitename 	suiteName� 0 handlername handlerName� 0 isstyled isStyled� 0 skipinfo skipInfo� 0 
skipreason 
skipReason� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 0 epartial ePartial� 0 
callobject 
callObjecte 6����i������
�	��������j���� ����k:>BK���������������������������48<E�  0 maketestreport makeTestReport� *0 configure_skiptests configure_skipTests� 0 
hashandler 
hasHandler�  i ������
�� 
errn���?��  
� 
errn��?
� 
erob
� 
errt
� 
reco
�
 
ctxt
�	 
msng� � 0 istype isType
� misccura� 0 nsdictionary NSDictionary� 60 dictionarywithdictionary_ dictionaryWithDictionary_� 0 objectforkey_ objectForKey_
� 
****j ������
�� 
errn���\��  ��\�  0 
addskipped 
addSkipped�� 0 	skipsuite 	skipSuite�� 0 etext eTextk ����l
�� 
errn�� 0 enumber eNumberl ����m
�� 
erob�� 0 efrom eFromm ����n
�� 
errt�� 
0 eto eTon ������
�� 
ptlr�� 0 epartial ePartial��  �� �� .0 makecaughterrorrecord makeCaughtErrorRecord�� �� 0 	addbroken 	addBroken�� "0 configure_setup configure_setUp��  0 makecallobject makeCallObject�� 0 dotest doTest
�� 
bool�� 0 
addfailure 
addFailure�� (0 configure_teardown configure_tearDown�&}b  ���m+  Ec  Ob  ��,k+ ! �j+ E�O �E�W X  )�������mv��Ob  O�� �b  ��l+  _�a ,�k+ �k+ a &E�O�� ? 
��&E�W X  )�a ����lv�a �%a %Ob  ��l+ Ob  Y hY @�� 9 
��&E�W X  )�a �����mv�a Ob  �k+ Ob  Y hY hW 9X  b  a a a a  b  �����a !+ "lvkva #+ $Ob  Y hO�Ec  O�Ec  	Ob  �a %,k+  O 
�j+ %W AX  b  a &a 'a (a )b  �����a !+ "lvkva #+ $O�Ec  Ob  Y hOb  �jl+ *E�O ���l+ +W MX  �b   	 �b   a ,& .b  �a -a .a /b  �����a !+ "lvkva #+ 0Y hOb  �a 1,k+  @ 
�j+ 1W 2X  b  a 2a 3a 4a 5b  �����a !+ "lvkva #+ $Y hO�Ec  Ob  ' ��q����op���� 20 _ascheckobjectparameter _asCheckObjectParameter�� ��q�� q  ������ 0 checkobject checkObject�� (0 defaultcheckobject defaultCheckObject��  o ������ 0 checkobject checkObject�� (0 defaultcheckobject defaultCheckObjectp 
������������������
�� 
msng�� &0 asscriptparameter asScriptParameter��  0 compareobjects compareObjects�� 0 
hashandler 
hasHandler
�� 
errn���@
�� 
erob�� �� =��  �E�Y hOb  ��l+ E�Ob  ��,k+  )�����Y hO�( �������rs���� ,0 _ascheckobjectresult _asCheckObjectResult�� ��t�� t  ���� 0 isequal isEqual��  r ���� 0 isequal isEquals �������������
�� 
errn���Y
�� 
erob
�� 
errt
�� 
bool�� �� eflv�kv )�������Y hO�) �������uv��
�� .���:ExEqnull��� ��� null��  ��  u ���� (0 exactequalitycheck ExactEqualityCheckv ���w�� (0 exactequalitycheck ExactEqualityCheckw ��x����yz��
�� .ascrinit****      � ****x k     {{ �����  ��  ��  y ����  0 compareobjects compareObjectsz || �������}~����  0 compareobjects compareObjects�� ����   ������ 0 expectedvalue expectedValue�� 0 actualvalue actualValue��  } ������ 0 expectedvalue expectedValue�� 0 actualvalue actualValue~ ����
�� 
pcls�� �� ��,��, fY hO�� V�� L  �� ��K S�* ���  ��� (0 exactequalitycheck ExactEqualityCheck� ��y|��  + ��	��������
�� .���:ExMunull��� ��� null��  �� �����
�� 
Usin� {�������� 0 checkobject checkObject��  
�� 
msng��  � �������������� 0 checkobject checkObject�� *0 multiplechoicecheck MultipleChoiceCheck�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� 	��������Z������ 20 _ascheckobjectparameter _asCheckObjectParameter�� *0 multiplechoicecheck MultipleChoiceCheck� �����������
�� .ascrinit****      � ****� k     �� ����  ��  ��  � ����  0 compareobjects compareObjects� �� ������������  0 compareobjects compareObjects�� ����� �  ������  0 expectedvalues expectedValues�� 0 actualvalue actualValue��  � ����������  0 expectedvalues expectedValues�� 0 actualvalue actualValue�� 0 expectedvalue expectedValue�� $0 expectedvalueref expectedValueRef� ������������������8����~�}
�� 
kocl
�� 
list
�� .corecnte****       ****
�� 
leng
�� 
bool
�� 
errn���Y
�� 
erob�� 
�� 
cobj
� 
pcnt�~  0 compareobjects compareObjects�} ,0 _ascheckobjectresult _asCheckObjectResult�� Y�kv��l j 
 	��,l�& )�����Y hO /�[��l kh *b   ��,�l+ k+  eY h[OY��Of�� L  �� 0 etext eText� �|�{�
�| 
errn�{ 0 enumber eNumber� �z�y�
�z 
erob�y 0 efrom eFrom� �x�w�v
�x 
errt�w 
0 eto eTo�v  �� �� 
0 _error  �� + *�b  l+  E�O��K S�W X  *梣���+ , �uj�t�s���r
�u .���:NmEqnull��� ��� null�t  �s �q��p
�q 
ETyp� {�o�n�m�o (0 issametyperequired isSameTypeRequired�n  
�m boovtrue�p  � �l�k�j�i�h�g�f�l (0 issametyperequired isSameTypeRequired�k 0 	checktype 	checkType�j 00 numericalequalitycheck NumericalEqualityCheck�i 0 etext eText�h 0 enumber eNumber�g 0 efrom eFrom�f 
0 eto eTo� ��e�d�c�b���a��`�_�e (0 asbooleanparameter asBooleanParameter
�d 
doub
�c 
nmbr�b 00 numericalequalitycheck NumericalEqualityCheck� �^��]�\���[
�^ .ascrinit****      � ****� k     �� ��� ��Z�Z  �]  �\  � �Y�X�Y 0 _isequaldelta _isEqualDelta�X  0 compareobjects compareObjects� ��W��W 0 _isequaldelta _isEqualDelta� �V��U�T���S�V  0 compareobjects compareObjects�U �R��R �  �Q�P�Q 0 expectedvalue expectedValue�P 0 actualvalue actualValue�T  � �O�N�M�L�K�J�I�O 0 expectedvalue expectedValue�N 0 actualvalue actualValue�M 0 n1  �L 0 n2  �K 0 d1  �J 0 d2  �I 0 d  � �H�G�F�E�D�C
�H 
kocl
�G 
long
�F .corecnte****       ****
�E 
doub
�D 
cobj
�C 
bool�S ���lv��l l  	�� Y hO��lv�b  l l fY hO��&��&lvE[�k/E�Z[�l/E�ZO�j  b   � E�Y b   � E�O�'E�O�� ��lvE[�k/E�Z[�l/E�ZY hO��E�O��	 ���&�[ �OL �a 0 etext eText� �B�A�
�B 
errn�A 0 enumber eNumber� �@�?�
�@ 
erob�? 0 efrom eFrom� �>�=�<
�> 
errt�= 
0 eto eTo�<  �` �_ 
0 _error  �r 5 $b  ��l+  �E�Y �E�O��K S�W X  *飤���+ - �;�:�9���8
�; .���:NmRgnull��� ��� null�:  �9 �7��6
�7 
ETyp� {�5�4�3�5 (0 issametyperequired isSameTypeRequired�4  
�3 boovtrue�6  � �2�1�0�/�.�-�2 (0 issametyperequired isSameTypeRequired�1 *0 numericalrangecheck NumericalRangeCheck�0 0 etext eText�/ 0 enumber eNumber�. 0 efrom eFrom�- 
0 eto eTo� 
(�,�++��*���)�(�, (0 asbooleanparameter asBooleanParameter�+ *0 numericalrangecheck NumericalRangeCheck� �'��&�%���$
�' .ascrinit****      � ****� k     �� +�#�#  �&  �%  � �"�"  0 compareobjects compareObjects� �� �!-� �����!  0 compareobjects compareObjects�  ��� �  ��� 0 expectedvalue expectedValue� 0 actualvalue actualValue�  � ������ 0 expectedvalue expectedValue� 0 actualvalue actualValue� "0 expectedminimum expectedMinimum� "0 expectedmaximum expectedMaximum� 0 	checktype 	checkType� ����������T�s
� 
kocl
� 
list
� .corecnte****       ****
� 
nmbr
� 
bool
� 
cobj
� 
errn��Y
� 
erob� 
� 
pcls� ��kv��l j 
 ���l l�&
 ��k/��l/�& )�����Y hO�E[�k/E�Z[�l/E�ZOb    !��,��, )�����Y hO��,E�Y �E�O�kv�l j  fY hO��	 ���&�$ L  �* 0 etext eText� �
�	�
�
 
errn�	 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  �) �( 
0 _error  �8 + b  ��l+ E�O��K S�W X  *碣���+ 	. ������� 
� .���:ExErnull��� ��� null�  � �����
�� 
Usin� {�������� ,0 errorattributechecks errorAttributeChecks��  ��  ��  � ������������������ ,0 errorattributechecks errorAttributeChecks�� :0 defaulterrorattributechecks defaultErrorAttributeChecks�� 0 checkobjects checkObjects�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� "0 exacterrorcheck ExactErrorCheck� �������������������������������������� &0 asrecordparameter asRecordParameter�� 0 errormessage errorMessage�� 0 errornumber errorNumber�� 0 	fromvalue 	fromValue�� 0 totype toType�� 0 partialresult partialResult�� 

�� 
leng
�� 
errn���Y
�� 
erob�� �� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� "0 exacterrorcheck ExactErrorCheck� �����������
�� .ascrinit****      � ****� k     �� ����  ��  ��  � ����  0 compareobjects compareObjects� �� ������������  0 compareobjects compareObjects�� ����� �  ������ 0 expectederror expectedError�� 0 actualerror actualError��  � �������������� 0 expectederror expectedError�� 0 actualerror actualError�� 0 aref aRef�� $0 expectedproperty expectedProperty��  0 actualproperty actualProperty�� 0 checkobject checkObject� �������������������������� 0 errornumber errorNumber�� 0 errormessage errorMessage�� 0 	fromvalue 	fromValue�� 0 totype toType�� 0 partialresult partialResult�� 
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pcnt�� 0 novalue NoValue��  0 compareobjects compareObjects�� � ���,��,b  �,mv��,��,b  �,mv��,��,b  �,mv��,��,b  �,mv��,��,b  �,mv�v[��l kh ��,E[�k/E�Z[�l/E�Z[�m/E�ZO�b  �, ���l+ f  fY hY h[OY��Oe�� L  �  s Rb  ��l+ E�O�b  �b  �b  �b  �b  �E�O��%E�O��,��, )�����Y hW X  *a ����a + Oa a K S�/ ��  ��� "0 exacterrorcheck ExactErrorCheck� ���� 
 ������������/� ������  ��  � ��*��� 0 errormessage errorMessage� ��*��� 0 errornumber errorNumber� ��*��� 0 	fromvalue 	fromValue� ��*��� 0 totype toType� ��*���� 0 partialresult partialResult��  ��  ��  ��  ��  0 ������������� .0 _compareassertresults _compareAssertResults�� ����� �  ������������ 0 checkobject checkObject��  0 expectedresult expectedResult�� 0 actualresult actualResult�� 0 
assertname 
assertName�� 0 usernote userNote��  � 
���������������������� 0 checkobject checkObject��  0 expectedresult expectedResult�� 0 actualresult actualResult�� 0 
assertname 
assertName�� 0 usernote userNote�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 epartial ePartial� ���������������������  0 compareobjects compareObjects�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� �����
�� 
errt�� 
0 eto eTo� ������
�� 
ptlr�� 0 epartial ePartial��  �� �� .0 makecaughterrorrecord makeCaughtErrorRecord�� �� 0 	addbroken 	addBroken
�� 
errn
�� 
erob�� D ���l+  W 7X  b  ���b  ������+ lvkv�+ O)�b  �b  �h1 ����������
�� .���:AsRenull��� ��� null��  �� �����
�� 
Valu�� 0 actualresult actualResult� �����
�� 
Equa��  0 expectedresult expectedResult� ����
�� 
Summ� {������ 0 usernote userNote��  � ���~
� 
Usin� {�}�|�{�} 0 checkobject checkObject�|  
�{ 
msng�~  � �z�y�x�w�v�u�t�s�r�q�p�z 0 actualresult actualResult�y  0 expectedresult expectedResult�x 0 usernote userNote�w 0 checkobject checkObject�v 0 etext eText�u 0 enumber eNumber�t 0 efrom eFrom�s 
0 eto eTo�r 0 epartial ePartial�q 0 isequal isEqual�p 0 testdata testData� �o�n�m2�l�k�j�LP\�i�ho�g�f�e��d�c����b���a
�o 
msng
�n 
errn�m�T�l "0 astextparameter asTextParameter�k 20 _ascheckobjectparameter _asCheckObjectParameter�j 0 etext eText� �`�_�
�` 
errn�_ 0 enumber eNumber� �^�]�
�^ 
erob�] 0 efrom eFrom� �\�[�
�\ 
errt�[ 
0 eto eTo� �Z�Y�X
�Z 
ptlr�Y 0 epartial ePartial�X  �i �h .0 makecaughterrorrecord makeCaughtErrorRecord�g �f 0 	addbroken 	addBroken
�e 
erob�d .0 _compareassertresults _compareAssertResults�c ,0 _ascheckobjectresult _asCheckObjectResult�b 0 
addsuccess 
addSuccess�a 0 
addfailure 
addFailure�� ��� �b  �  )��l�Y hO  b  ��l+ E�O*�b  l+ E�W CX 	 
b  ���b  ������+ lva �lvlva + O)�b  a b  a hO**���a ��+ k+ E�Oa �lva �lvlvE�O� b  a ��m+ OhY *b  a a ��a + O)�b  a b  a hV2 �W��V�U���T
�W .���:AsErnull��� ��� null�V  �U �S��
�S 
Hand� {�R�Q��R "0 callhandlername callHandlerName�Q  � �P��
�P 
Args� {�O�N�M�O  0 parametervalue parameterValue�N  
�M 
���!� �L�K�
�L 
Equa�K 0 expectederror expectedError� �J��
�J 
Summ� {�I�H��I 0 usernote userNote�H  � �G��F
�G 
Usin� {�E�D�C�E 0 checkobject checkObject�D  
�C 
msng�F  � �B�A�@�?�>�=�<�;�:�9�8�7�6�5�4�3�B "0 callhandlername callHandlerName�A  0 parametervalue parameterValue�@ 0 expectederror expectedError�? 0 usernote userNote�> 0 checkobject checkObject�= 0 etext eText�< 0 enumber eNumber�; 0 efrom eFrom�: 
0 eto eTo�9 0 epartial ePartial�8 0 
callobject 
callObject�7 0 actualerror actualError�6 0 actualresult actualResult�5 0 isequal isEqual�4 0 problemtype problemType�3 0 testdata testData� 3���2�1�0�
�/�.�-/�,�+�IMX�*�)�(�'�&tz��%���$�#�"�!� 	��		(	/���	_	h	o	�	�	�	��
�2 
msng
�1 
errn�0�T�/ "0 astextparameter asTextParameter�. &0 asrecordparameter asRecordParameter�- <0 normalizeexpectederrorrecord normalizeExpectedErrorRecord�, 20 _ascheckobjectparameter _asCheckObjectParameter�+ 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo� ���
� 
ptlr� 0 epartial ePartial�  �* �) .0 makecaughterrorrecord makeCaughtErrorRecord�( �' 0 	addbroken 	addBroken
�& 
erob
�% 
ctxt
�$ 
���!�#  0 makecallobject makeCallObject�" 0 novalue NoValue
�! 
cobj�  0 dotest doTest� .0 _compareassertresults _compareAssertResults� ,0 _ascheckobjectresult _asCheckObjectResult� 0 
addsuccess 
addSuccess�  � ���
� 
errn��?�  � 0 
addfailure 
addFailure�TY��Ub  �  )��l�Y hO Ib  ��l+ E�Ob  ��l+ 	E�Ob  �k+ 
E�Ob  ��l+ E�O*�b  l+ E�W CX  b  �a �a b  �����a + lvkva + O)�b  a b  a hOga  ;�a   a b  	[a \[Za \Zi2%E�Y �a  a �%E�Y hVO�a   b  �jl+ E�Y b  �kl+ E�Ob  a ,b  a ,fmvE[a  k/E�Z[a  l/E�Z[a  m/E�ZO �b  �l+ !E�W /X  b  �����a + E�O**���a "�a + #k+ $E�O� #b  a %�a &�lva '�lvlvm+ (OhY � �E�W X ) *b  a ,E�O�b  a , +a +a ,�lva -�lvlvlvE[a  k/E�Z[a  l/E�ZY hO�b  a , +a .a /�lva 0�lvlvlvE[a  k/E�Z[a  l/E�ZY hOb  a 1���a + 2O)�b  a b  a hV3 �	�������  0 _genericassert _genericAssert� �
��
 �  �	����	 0 
assertname 
assertName� 0 
didsucceed 
didSucceed� 0 actualresult actualResult� 0 usernote userNote�  � 
������ ��������� 0 
assertname 
assertName� 0 
didsucceed 
didSucceed� 0 actualresult actualResult� 0 usernote userNote� 0 etext eText�  0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�� 0 epartial ePartial�� 0 testdata testData� 	�	�������	�	�	������
 
������������
/��
L��
�� 
msng
�� 
errn���T�� "0 astextparameter asTextParameter�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� �����
�� 
errt�� 
0 eto eTo� ������
�� 
ptlr�� 0 epartial ePartial��  �� �� .0 makecaughterrorrecord makeCaughtErrorRecord�� �� 0 	addbroken 	addBroken
�� 
erob
�� 
���!�� 0 
addsuccess 
addSuccess�� 0 
addfailure 
addFailure� ��� �b  �  )��l�%�%Y hO b  ��l+ E�W 9X 	 
b  ���b  ������+ lvkv�+ O)�b  a b  �hO�a   	jvE�Y a �lvkvE�O� b  ���m+ OhY $b  �a ���+ O)�b  a b  �hV4 ��
c��������
�� .���:AsPanull��� ��� null��  �� ����
�� 
Valu� {�������� 0 actualresult actualResult��  
�� 
���!� �����
�� 
Summ� {����
n�� 0 usernote userNote��  ��  � ������ 0 actualresult actualResult�� 0 usernote userNote� 
v������ ��  0 _genericassert _genericAssert�� 
*�e���+ 5 ��
���������
�� .���:AsFanull��� ��� null��  �� ����
�� 
Valu� {�������� 0 actualresult actualResult��  
�� 
���!� �����
�� 
Summ� {����
��� 0 usernote userNote��  ��  � ������ 0 actualresult actualResult�� 0 usernote userNote� 
������� ��  0 _genericassert _genericAssert�� 
*�f���+ 6 ��
���������
�� .���:TRPanull��� ��� null��  ��  � ���������� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� 
���
������������
����
�����
�� 
in D
�� .sysorpthalis        TEXT
�� 
furl��  � ������
�� 
errn���5��  
�� 
errn���@�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� 1   ���l �&W X  )��l�W X 
 *젡���+ 7 ��
���������
�� .���:RunTnull���     file�� 0 testfile testFile��  � ������������ 0 testfile testFile�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ���������������� ����
�� .���:TRPanull��� ��� null
�� 
psxp
�� 
strq
�� 
spac�� ,0 asposixpathparameter asPOSIXPathParameter
�� 
alen
�� .sysoexecTEXT���     TEXT�� 0 etext eText  ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� 6 %*j  �,�,�%b  ��l+ �,%�fl W X  	*ꡢ���+ ascr  ��ޭ