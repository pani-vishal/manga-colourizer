===================================================================

  A Robust Panel Extraction Method for Manga
  v 1.0
  
  Xufang PANG
  Department of Computer Science
  City University of Hong Kong

  Copyright (c) by Xufang PANG, 2015-12-12.

===================================================================



==== DESCRIPTION =====
This is the code for automatically extracting frames/panels from digital comic/manga pages. 
Example manga pages can be found in folder "Code/Data/naruto_514".
Code can be found in folder "Code/". 

 
==== INSTALLATION ==== 
1. Run "Code/install.m"
2. Run "Code/BatTestPanelExtration.m": 
   [The input are the digital manga pages.]
   [The output are the extracted panel polygons in each manga page, which are described as X,Y coordinates and saved in file "PagePanels.mat".]
 
 
 

==== Code CONTENTS ====

The contents of our code are listed below.  Here only the important functions for
the user are highlighted.  

 --- main functions ("Code/") ---
    install.m                 -- set path for the programme. 
    ExtractPanelShape.m       -- extract panel shapes from a single manga page. 
    BatTestPanelExtration.m   -- extract panel shapes for a set of manga pages, and draw the extracted panels.   

 --- functions in folder "Code/func/"---
    GenerateBinary.m          -- Generate the binary mask for panels on each manga page.  
    RemoveSmallObjects.m      -- Remove small objects on mask, and fill the holes on panel mask.  
    MaskToPanel.m             -- Segment the panel mask to individual panel shapes.  
   
	  
==== REFERENCES ====

If you use this code, please cite the ACM Multimedia paper [1].

[1] Xufang Pang, Ying Cao, Rynson Lau, and Antoni Chan. "A Robust Panel Extraction Method for Manga", Proc. ACM Multimedia, pp. 1125-1128, Nov. 2014. 

[2] Ying Cao, Rynson Lau, and Antoni Chan, "Look Over Here: Attention-Directing Composition of Manga Elements", ACM Trans. on Graphics (Proc. ACM SIGGRAPH 2014), 33(4), Article 94, Aug. 2014.

[3] Ying Cao, Antoni Chan, and Rynson Lau, "Automatic Stylistic Manga Layout", ACM Trans. on Graphics (Proc. ACM SIGGRAPH Asia 2012), 31(6), Article 141, Nov. 2012. 


==== CONTACT INFO ====

Please send comments, bug reports, feature requests to Xufang PANG (xpang4-c at my dot cityu dot edu.hk).

==== CHANGE LOG ====

2015-12-12: v1.0
 

