(* Content-type: application/vnd.wolfram.mathematica *)

(*** Wolfram Notebook File ***)
(* http://www.wolfram.com/nb *)

(* CreatedBy='Mathematica 12.1' *)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[       158,          7]
NotebookDataLength[     59582,       1319]
NotebookOptionsPosition[     57666,       1277]
NotebookOutlinePosition[     58122,       1294]
CellTagsIndexPosition[     58079,       1291]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["\:0412\:0438\:0437\:0443\:0430\:043b\:0438\:0437\:0430\:0446\:0438\:044f\
 \:0434\:0430\:043d\:043d\:044b\:0445 \:0434\:043b\:044f \:0437\:0430\:0434\
\:0430\:0447\:0438 N \:0442\:0435\:043b", "Subsection",
 CellChangeTimes->{{3.8782910796789303`*^9, 3.8782910932352123`*^9}, {
  3.8783068032238436`*^9, 
  3.878306808947959*^9}},ExpressionUUID->"052ea176-76b6-40ef-8296-\
7031208be896"],

Cell[CellGroupData[{

Cell["\:0421\:0447\:0438\:0442\:044b\:0432\:0430\:043d\:0438\:0435", \
"Subsubsection",
 CellChangeTimes->{{3.8783068219892087`*^9, 
  3.8783068293009443`*^9}},ExpressionUUID->"92c2de94-43af-4bca-88e3-\
0b50de7612d8"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"SetDirectory", "[", 
   RowBox[{"NotebookDirectory", "[", "]"}], "]"}], " ", 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"n", " ", "=", " ", "4"}], ";"}], " ", 
  RowBox[{"(*", 
   RowBox[{
   "\:041a\:0430\:043a", " ", "\:043c\:043d\:043e\:0433\:043e", " ", 
    "\:0442\:0435\:043b", " ", "\:0443", " ", 
    RowBox[{"\:043d\:0430\:0441", "?"}]}], "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"foldertest", " ", "=", " ", "\"\<test/\>\""}], ";"}], 
  RowBox[{"(*", 
   RowBox[{
    RowBox[{
    "\:041f\:0443\:0442\:044c", " ", "\:043a", " ", 
     "\:0442\:043e\:043c\:0443"}], ",", " ", 
    RowBox[{
    "\:0441", " ", "\:0447\:0435\:043c", " ", 
     "\:0441\:0440\:0430\:0432\:043d\:0438\:0432\:0430\:0435\:043c"}]}], 
   "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"foldercalc", "=", "\"\<test/4body_calc/\>\""}], ";", 
  RowBox[{"(*", 
   RowBox[{
   "\:041f\:0443\:0442\:044c", " ", "\:043a", " ", 
    "\:0440\:0430\:0441\:0447\:0435\:0442\:0443"}], "*)"}], 
  "\[IndentingNewLine]", 
  RowBox[{"testdatanames", " ", "=", " ", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"foldertest", "<>", "\"\<traj\>\"", "<>", 
      RowBox[{"ToString", "[", "i", "]"}], "<>", "\"\<.txt\>\""}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", "n"}], "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"calcdatanames", " ", "=", " ", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"foldercalc", "<>", "\"\<traj_\>\"", "<>", 
      RowBox[{"ToString", "[", "i", "]"}], "<>", "\"\<.txt\>\""}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", "n"}], "}"}]}], "]"}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.8782912551645193`*^9, 3.8782912561385946`*^9}, {
   3.8782912865687637`*^9, 3.878291377249305*^9}, {3.8782914427746143`*^9, 
   3.8782915154522924`*^9}, {3.8782915689774666`*^9, 
   3.8782915767557387`*^9}, {3.87829169131313*^9, 3.8782917270271983`*^9}, {
   3.878291819334962*^9, 3.878291866153302*^9}, 3.878292050045622*^9, {
   3.878306774164349*^9, 
   3.878306791725619*^9}},ExpressionUUID->"5b25e8f3-8b22-4be9-927c-\
0feaeca9cd04"]
}, Open  ]],

Cell[CellGroupData[{

Cell["\:0424\:043e\:0440\:043c\:0438\:0440\:043e\:0432\:0430\:043d\:0438\:0435\
 \:043d\:0443\:0436\:043d\:043e\:0433\:043e \:0432\:0438\:0434\:0430 \:0434\
\:0430\:043d\:043d\:044b\:0445 ", "Subsubsection",
 CellChangeTimes->{{3.8783068336828938`*^9, 
  3.878306863504328*^9}},ExpressionUUID->"a63540ee-6954-4bf7-adbf-\
ca686e39bed1"],

Cell[BoxData[
 RowBox[{"(*", 
  RowBox[{
  "\:0412\:0438\:0434", " ", "\:0434\:0430\:043d\:043d\:044b\:0445", " ", 
   "\:043f\:043e\:0441\:043b\:0435", " ", 
   "\:043f\:0440\:0438\:043c\:0435\:043d\:0435\:043d\:0438\:044f", " ", 
   "\:0444\:0443\:043d\:043a\:0446\:0438\:0438", " ", 
   RowBox[{"convert", ":", " ", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", "t", "}"}], ",", " ", 
      RowBox[{"{", 
       RowBox[{"x", ",", " ", "y", ",", " ", "z"}], "}"}]}], "}"}]}]}], 
  "*)"}]], "Input",
 CellChangeTimes->{{3.878306889637723*^9, 
  3.8783069348495693`*^9}},ExpressionUUID->"27cb126b-7323-47ec-b58f-\
63090377d257"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"convert", "[", "filename_", "]"}], ":=", 
   RowBox[{
    RowBox[{
     RowBox[{"(", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"#", "[", 
          RowBox[{"[", "1", "]"}], "]"}], "}"}], ",", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"#", "[", 
           RowBox[{"[", "2", "]"}], "]"}], ",", 
          RowBox[{"#", "[", 
           RowBox[{"[", "3", "]"}], "]"}], ",", 
          RowBox[{"#", "[", 
           RowBox[{"[", "4", "]"}], "]"}]}], "}"}]}], "}"}], ")"}], "&"}], "/@", 
    RowBox[{"Partition", "[", 
     RowBox[{
      RowBox[{
       RowBox[{"Interpreter", "[", 
        RowBox[{"DelimitedSequence", "[", "\"\<Number\>\"", "]"}], "]"}], "[", 
       RowBox[{"Import", "[", "filename", "]"}], "]"}], ",", "4"}], "]"}]}]}],
   ";"}]], "Input",
 CellChangeTimes->{{3.8782939362697306`*^9, 3.8782939820110645`*^9}, {
  3.878294083782586*^9, 3.8782940994804564`*^9}, {3.8782941608114395`*^9, 
  3.878294183388467*^9}},
 CellLabel->"In[8]:=",ExpressionUUID->"05886a18-528a-412f-af04-4d9a3f4472ef"],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"testdata", " ", "=", " ", 
    RowBox[{"Table", "[", 
     RowBox[{
      RowBox[{"convert", "[", 
       RowBox[{"testdatanames", "[", 
        RowBox[{"[", "i", "]"}], "]"}], "]"}], ",", 
      RowBox[{"{", 
       RowBox[{"i", ",", "1", ",", 
        RowBox[{"Length", "@", "testdatanames"}]}], "}"}]}], "]"}]}], ";"}], 
  " ", 
  RowBox[{"(*", 
   RowBox[{
   "\:041d\:0435\:043a\:043e\:0435", " ", 
    "\:0438\:0434\:0435\:0430\:043b\:044c\:043d\:043e\:0435", " ", 
    "\:0440\:0435\:0448\:0435\:043d\:0438\:0435"}], 
   "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"calcdata", " ", "=", " ", 
    RowBox[{"Table", "[", 
     RowBox[{
      RowBox[{"convert", "[", 
       RowBox[{"calcdatanames", " ", "[", 
        RowBox[{"[", "i", "]"}], "]"}], "]"}], ",", 
      RowBox[{"{", 
       RowBox[{"i", ",", "1", ",", 
        RowBox[{"Length", "@", "calcdatanames"}]}], " ", "}"}]}], "]"}]}], 
   ";"}], 
  RowBox[{"(*", 
   RowBox[{
   "\:041d\:0430\:0448\:0435", " ", 
    "\:0440\:0435\:0448\:0435\:043d\:0438\:0435"}], 
   "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"timelayers", " ", "=", " ", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"testdata", "[", 
      RowBox[{"[", 
       RowBox[{"1", ",", "timelayer", ",", "1", ",", "1"}], "]"}], "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"timelayer", ",", " ", "1", ",", " ", 
       RowBox[{"Length", "@", 
        RowBox[{"testdata", "[", 
         RowBox[{"[", "1", "]"}], "]"}]}]}], "}"}]}], "]"}]}], ";", 
  RowBox[{"(*", 
   RowBox[{
   "\:041c\:0430\:0441\:0441\:0438\:0432", " ", 
    "\:0432\:0440\:0435\:043c\:0435\:043d\:043d\:044b\:0445", " ", 
    "\:0441\:043b\:043e\:0435\:0432"}], "*)"}]}]}], "Input",
 CellChangeTimes->{
  3.878291277835511*^9, {3.87829156140613*^9, 3.8782915655046363`*^9}, {
   3.8782918765145774`*^9, 3.878291899213791*^9}, {3.8782919802089767`*^9, 
   3.878292024778837*^9}, {3.8782921353988233`*^9, 3.878292142738686*^9}, {
   3.878292633835215*^9, 3.878292670337002*^9}, {3.878292778089675*^9, 
   3.878292787170658*^9}, {3.8782940019242945`*^9, 3.8782940166430855`*^9}, {
   3.8783069428019414`*^9, 3.87830702983086*^9}, {3.8783070626680684`*^9, 
   3.8783070662473993`*^9}, {3.8783079407839613`*^9, 3.878307942345352*^9}},
 CellLabel->
  "In[196]:=",ExpressionUUID->"b43426dd-5408-4f1a-ac9f-71de2a8bcdac"]
}, Open  ]],

Cell[CellGroupData[{

Cell["\:0410\:043d\:0438\:043c\:0430\:0446\:0438\:044f", "Subsubsection",
 CellChangeTimes->{{3.8783068729119396`*^9, 
  3.8783068797192326`*^9}},ExpressionUUID->"28eb9d12-1ad7-4c95-95c7-\
be1fc6fa3d30"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"L", " ", "=", " ", "3"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"DataPlot", "[", "timelayer_", "]"}], ":=", " ", 
   RowBox[{
    RowBox[{"Table", "[", 
     RowBox[{
      RowBox[{"testdata", "[", 
       RowBox[{"[", 
        RowBox[{"i", ",", "timelayer", ",", "2"}], "]"}], "]"}], ",", 
      RowBox[{"{", 
       RowBox[{"i", ",", "1", ",", 
        RowBox[{"Length", "@", "testdata"}]}], "}"}]}], "]"}], "~", "Join", 
    "~", 
    RowBox[{"Table", "[", 
     RowBox[{
      RowBox[{"calcdata", "[", 
       RowBox[{"[", 
        RowBox[{"i", ",", "timelayer", ",", "2"}], "]"}], "]"}], ",", 
      RowBox[{"{", 
       RowBox[{"i", ",", "1", ",", 
        RowBox[{"Length", "@", "calcdata"}]}], "}"}]}], "]"}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"DataArea", "=", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"-", "L"}], ",", "L"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"-", "L"}], ",", "L"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"-", "L"}], ",", "L"}], "}"}]}], "}"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"DataColors", "=", 
   RowBox[{
    RowBox[{"Table", "[", 
     RowBox[{"Blue", ",", 
      RowBox[{"{", 
       RowBox[{"i", ",", "1", ",", 
        RowBox[{"Length", "@", "testdata"}]}], "}"}]}], "]"}], "~", "Join", 
    "~", 
    RowBox[{"Table", "[", 
     RowBox[{"Red", ",", 
      RowBox[{"{", 
       RowBox[{"i", ",", "1", ",", 
        RowBox[{"Length", "@", "calcdata"}]}], "}"}]}], "]"}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"DataTimeLayerLabel", "[", "timelayer_", "]"}], ":=", 
   RowBox[{"Style", "[", 
    RowBox[{
     RowBox[{"Framed", "[", 
      RowBox[{
       RowBox[{"ToString", "@", 
        RowBox[{"NumberForm", "[", 
         RowBox[{
          RowBox[{"timelayers", " ", "[", 
           RowBox[{"[", "timelayer", "]"}], "]"}], ",", 
          RowBox[{"{", 
           RowBox[{"3", ",", "1"}], "}"}]}], "]"}]}], "<>", "\"\<sec\>\""}], 
      "]"}], ",", "16", ",", "Black", ",", 
     RowBox[{"Background", "\[Rule]", 
      RowBox[{"Lighter", "[", "Yellow", "]"}]}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"Manipulate", "[", 
  RowBox[{
   RowBox[{"ListPointPlot3D", "[", 
    RowBox[{
     RowBox[{"DataPlot", "[", "timelayer", "]"}], ",", 
     RowBox[{"PlotLabel", "\[Rule]", 
      RowBox[{"DataTimeLayerLabel", "[", "timelayer", "]"}]}], ",", 
     RowBox[{"PlotRange", "\[Rule]", "DataArea"}], ",", 
     RowBox[{"PlotStyle", "\[Rule]", "DataColors"}]}], "]"}], ",", 
   RowBox[{"{", 
    RowBox[{"timelayer", ",", "1", ",", 
     RowBox[{"Length", "@", 
      RowBox[{"testdata", "[", 
       RowBox[{"[", "1", "]"}], "]"}]}], ",", "1"}], "}"}]}], "]"}]}], "Input",
 CellChangeTimes->CompressedData["
1:eJxTTMoPSmViYGAQB2IQvUrTJMDx6RvHtfP4A0H0H+GNYSBa2OF4FIh+/qM3
G0TfkT0CprdwtE4F0f86F8wE0QdPWMwD0bY8J8H0rBfXl4HoM4rGy0G0i2bg
GhB9SuU7mFYrbXsOos+1bwTTX9NY3oDo41YcYHqe8R4HJyDNOPE9mN480zvL
GUg/UmwpAtH/CwPKQPSJOrMGEM10Lb4NRG8r0+kB0eza5hNAdEX436kgell9
1EIQPW9b9RIQzRwgcd8dSKfxVTwE0eqnd38F0atsIn+D6DNySf9B9I13M8F0
/mNePg8gzcAiIAyiN9f1SoPo69vY5EH0vkWJ0SD635z3JWA6et5sEB3yNnIB
iE6QnsHtCaQN9uvwgGgAaVXJhA==
  "],
 CellLabel->
  "In[199]:=",ExpressionUUID->"a0754f5e-bee4-41cc-888c-a0ea46689f11"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`timelayer$$ = 201, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{
      Hold[$CellContext`timelayer$$], 1, 201, 1}}, Typeset`size$$ = {
    288., {151., 155.8296262354034}}, Typeset`update$$ = 0, 
    Typeset`initDone$$, Typeset`skipInitDone$$ = True}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, "Variables" :> {$CellContext`timelayer$$ = 1}, 
      "ControllerVariables" :> {}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> ListPointPlot3D[
        $CellContext`DataPlot[$CellContext`timelayer$$], 
        PlotLabel -> \
$CellContext`DataTimeLayerLabel[$CellContext`timelayer$$], 
        PlotRange -> $CellContext`DataArea, 
        PlotStyle -> $CellContext`DataColors], 
      "Specifications" :> {{$CellContext`timelayer$$, 1, 201, 1}}, 
      "Options" :> {}, "DefaultOptions" :> {}],
     ImageSizeCache->{327., {187.0076923076923, 191.9923076923077}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",
 CellChangeTimes->{{3.8782920994043913`*^9, 3.878292105152886*^9}, {
   3.8782921440309467`*^9, 3.87829218339193*^9}, 3.8782923185917673`*^9, {
   3.878292655098817*^9, 3.878292676979151*^9}, 3.8782927267224383`*^9, 
   3.878292794532161*^9, 3.878293310741332*^9, 3.8782933447749596`*^9, 
   3.8782940238949494`*^9, 3.87829418635503*^9, 3.8782963929377685`*^9, {
   3.8782964703833876`*^9, 3.8782965000650415`*^9}, {3.8782965339267235`*^9, 
   3.8782965861109967`*^9}, {3.878296654212069*^9, 3.878296678707743*^9}, {
   3.8782967534267197`*^9, 3.8782967612797236`*^9}, {3.878296868490827*^9, 
   3.878296875653016*^9}, 3.878305548339616*^9, {3.878305719118183*^9, 
   3.8783057551679287`*^9}, {3.8783057892207117`*^9, 3.878305798396311*^9}, {
   3.878305910552847*^9, 3.8783059543140492`*^9}, {3.878306014781404*^9, 
   3.878306044601182*^9}, {3.8783066504329557`*^9, 3.878306675975038*^9}, 
   3.8783067320609927`*^9, 3.8783070450840535`*^9, 3.8783070934569435`*^9, 
   3.8783079463883486`*^9},
 CellLabel->
  "Out[204]=",ExpressionUUID->"5059c4ff-653b-4809-bd01-341212afafdc"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["\:0421\:0440\:0430\:0432\:043d\:0435\:043d\:0438\:0435 \:0442\:0440\
\:0430\:0435\:043a\:0442\:043e\:0440\:0438\:0439 \:0447\:0430\:0441\:0442\
\:0438\:0446", "Subsubsection",
 CellChangeTimes->{{3.8783071164473677`*^9, 
  3.878307123911833*^9}},ExpressionUUID->"ac335788-80a0-4d58-894e-\
c796c0aa4996"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"difference", "[", 
    RowBox[{"timelayer_", ",", "numberofbody_"}], "]"}], ":=", " ", 
   RowBox[{"Norm", "[", 
    RowBox[{
     RowBox[{"testdata", "[", 
      RowBox[{"[", 
       RowBox[{"numberofbody", ",", "timelayer", ",", "2"}], "]"}], "]"}], 
     "-", 
     RowBox[{"calcdata", "[", 
      RowBox[{"[", 
       RowBox[{"numberofbody", ",", "timelayer", ",", "2"}], "]"}], "]"}]}], 
    "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"relerror", "[", 
    RowBox[{"timelayer_", ",", "numberofbody_"}], "]"}], ":=", " ", 
   RowBox[{
    RowBox[{"Norm", "[", 
     RowBox[{
      RowBox[{"testdata", "[", 
       RowBox[{"[", 
        RowBox[{"numberofbody", ",", "timelayer", ",", "2"}], "]"}], "]"}], 
      "-", 
      RowBox[{"calcdata", "[", 
       RowBox[{"[", 
        RowBox[{"numberofbody", ",", "timelayer", ",", "2"}], "]"}], "]"}]}], 
     "]"}], "/", 
    RowBox[{"Norm", "[", 
     RowBox[{"testdata", "[", 
      RowBox[{"[", 
       RowBox[{"numberofbody", ",", "timelayer", ",", "2"}], "]"}], "]"}], 
     "]"}]}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"DataPlotDiff", "[", "numberofbody_", "]"}], ":=", " ", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"timelayers", "[", 
        RowBox[{"[", "i", "]"}], "]"}], ",", " ", 
       RowBox[{"difference", "[", 
        RowBox[{"i", ",", " ", "numberofbody"}], "]"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", 
       RowBox[{"Length", "@", "timelayers"}]}], "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"DataPlotRelErr", "[", "numberofbody_", "]"}], ":=", " ", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"timelayers", "[", 
        RowBox[{"[", "i", "]"}], "]"}], ",", " ", 
       RowBox[{"relerror", "[", 
        RowBox[{"i", ",", " ", "numberofbody"}], "]"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", 
       RowBox[{"Length", "@", "timelayers"}]}], "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"ListLogPlot", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"DataPlotDiff", "[", "1", "]"}], ",", 
     RowBox[{"DataPlotDiff", "[", "2", "]"}], ",", 
     RowBox[{"DataPlotDiff", "[", "3", "]"}], ",", 
     RowBox[{"DataPlotDiff", "[", "4", "]"}]}], "}"}], ",", 
   RowBox[{"Joined", "\[Rule]", "True"}], ",", 
   RowBox[{"PlotStyle", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"Red", ",", "Green", ",", "Blue", ",", "Purple"}], "}"}]}], ",", 
   RowBox[{
   "PlotLabel", "\[Rule]", 
    "\"\<\:0410\:0431\:0441\:043e\:043b\:044e\:0442\:043d\:0430\:044f \:043e\
\:0448\:0438\:0431\:043a\:0430\>\""}]}], "]"}], "\[IndentingNewLine]", 
 RowBox[{"ListLogPlot", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"DataPlotRelErr", "[", "1", "]"}], ",", 
     RowBox[{"DataPlotRelErr", "[", "2", "]"}], ",", 
     RowBox[{"DataPlotRelErr", "[", "3", "]"}], ",", 
     RowBox[{"DataPlotRelErr", "[", "4", "]"}]}], "}"}], ",", 
   RowBox[{"Joined", "\[Rule]", "True"}], ",", 
   RowBox[{"PlotStyle", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"Red", ",", "Green", ",", "Blue", ",", "Purple"}], "}"}]}], ",", 
   RowBox[{
   "PlotLabel", "\[Rule]", 
    "\"\<\:041e\:0442\:043d\:043e\:0441\:0438\:0442\:0435\:043b\:044c\:043d\
\:0430\:044f \:043e\:0448\:0438\:0431\:043a\:0430\>\""}]}], "]"}]}], "Input",
 CellChangeTimes->{{3.8783071278714685`*^9, 3.878307533748022*^9}, {
   3.878307589332676*^9, 3.878307663713628*^9}, 3.878307694801676*^9, {
   3.878307726203442*^9, 3.878307749628317*^9}, {3.8783077925346336`*^9, 
   3.8783078354906626`*^9}, {3.878307902000431*^9, 3.878307920939267*^9}, {
   3.878307955656431*^9, 3.8783079989912586`*^9}, {3.878308037195691*^9, 
   3.878308077956682*^9}, {3.8783081092502036`*^9, 3.8783082219806285`*^9}, {
   3.878308256043231*^9, 3.8783082865517735`*^9}},
 CellLabel->
  "In[256]:=",ExpressionUUID->"b0944d7e-99a6-459e-8b62-7d14bd64476b"],

Cell[BoxData[
 GraphicsBox[{{}, {{}, {}, 
    {RGBColor[1, 0, 0], PointSize[0.007333333333333334], AbsoluteThickness[
     1.6], LineBox[CompressedData["
1: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
      "]]}, 
    {RGBColor[0, 1, 0], PointSize[0.007333333333333334], AbsoluteThickness[
     1.6], LineBox[CompressedData["
1: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
      "]]}, 
    {RGBColor[0, 0, 1], PointSize[0.007333333333333334], AbsoluteThickness[
     1.6], LineBox[CompressedData["
1:eJw11As0lekex/FNSUS5h703+2Zvt82+RHSZ90erSZfTMM0g3Uc0ayqZUqek
UZPbVBoNUanjNJEak1KcikOMmYqDdkwTTUa66IKQLpI4NT3/Z6293vWu93k+
/+/a612v+It1n0bo83i8q+9+76+HDr5fF7nhPUYXOp+6VX64r+HSzj9oncq5
VU7Svl9NXHXSzlNtyS7seQs3y7b/4TWNSyXv73WH+13vo9WlJc5s/z3O6I/Z
23SOzpWrIt+vDk5x/uHrFJ4zO/+YE67Z0X0qUVFZX/d+dXGKgLgBc28F83o5
W4twf6N2Odvfx9WHJIuX5MqZ388tvPv87O5wOTv/nHt7XhkR6yVn815yFqsO
P3uU7sS8AS4htfyhfaYT815zgVXfv8p59/yD94aTpLYnrvNwYt4Q5zr19IXy
Ihnzhrke3ZDqbKqMeTz8dqdd2hIsY/t5WDeQsWVrnIz5eoid66py0NB5fZyR
d/kEmMnYvFF41Nwm8WuRMm80dlV9Zdh7Qsq80Wj4Lmd+QYKUeQZYcsMh2GWF
lHljsGG+nfHVtVLmGWIk7dfiQi15Y5GSILMcpUfeWBRslsVHDkiYZ4RPml7u
uNYpYZ4xbk4OeSE6JWHeOLQc3F829wcJ80zQqgzsHrVVwjwTzDhm6hcaSZ4p
Tj+T/iXcRN547B29sOrsYvImoL76qFDPlTwz8G8XZP5PSfvNUN0sKFwpIt8M
ddU55pt7xJV/H9ea4+1z31O/dIvZPHP8aJ284HKNmHkWUMarSsbWiplnAeng
+hjLfDHzLFC8LsV/So6Y9VjC0KIsd+oe8izhumtffG0ieVZIlz0xaEoizwrr
3VoMWyPIs8KzA85mJUHkWeNb/yPhaZ+SZw13v2LrVx7k2aC6QD6Y4k6eDVbr
x+xcLyHPBhM67E2OmZM3EbqLJU+zTcibiCe8YpMZRuTZ4qe6T5Slb0TMs0We
0auZAT0i5tnCeHw/b9JNEfPsMOjbr+jUiZhnh4TpLhHjakTMs8cSh7T821Xk
2aPdqHxw6kny7DGQ/CU6TpLHBzf7cHtDFnl8zF9o3HjpEHkC5M1cERqVQp4A
T6ZN2pkcT54A+d38bV6byBMit+tP68VryBOiN8MqxDicPAfEz6hpfR1KngOO
cWe7m4LIc0C5Ls5uzSzyHCGw8vbz5shzRLW/734vH/JE+OytZ+ABDxF7v0RY
7hLYku5EvggfpWddPCmk8yIEf/Hqr0YbmidC2JZbBX6m5InR8tPNW+1jyBMj
bktfn9lbR+aJoW+yjL+2z5F5YnBeMakZ9x2ZJ8YVq0Wdm645Mk+CaJOGqsIK
R+ZJ0LvXIMq8mDwJHs8J0nPPI0+C6cv+iLXeT54EZWnyaUGp5ElxfGnc5NzN
juz/kWJeW9p3t6PIk2K7mdorJZw8Kbq91/oNhpInhbwxTHxjBnkyPKiJTB32
IU+GtOspczd7kCfDiY7c/I9l5MnQOX5D19AE8mT4cUWtdZEBeU6IDp6eF/Da
gXlOmB6qn1fV7cA8Jzzsv6N3u82BeU54plg2b7XOgXlOuMLbui2w1oF5cvhM
tky9XEGeHMOd90rOFJInxwvdfWHBMfLkqN2wrUd9hDw57gc1/uy3lzwFjCb4
2jnuIE+B4ba+hw82kKdAxNfFNesjyVNgTtJK7zfLyVOgJih8dFQoec5ofpq0
++nH5DkjdqPNm+s+5DlDt9S3pmkKec44E+Oy+zclec6w+NmuxlZAngve/Lfa
Kt6SPBc4+4b4n9EjzwWtsYsnjuOR54JdMy/rX+kVMs8FRZ5PhKlPhMxzRaB2
UqKyTcg8V+z/h0FYzk0h81xx1VGcafSLkHmuONr855KiC+S5IrRuYfnQOfLc
sFQbNVSaR54b4k0s3Z4eIc8NUeUZL2/sI88Ny7P7630SyHODYdp2TvEtee44
mBhywn0jee7I0hWs8F5DnjsiM5esOhRGnjs8Pq8aLA8mzx2Chj3/LAN5SniZ
3q0/8RF5Skzbt9w5VEueElYxpxdkychTIvb64+0JIvKUmBudU3HfhDwPZGZs
8h/SJ88D3sbHw6a9FjDPA8pfow8c6xUwzwOmn48eCb8rYJ4HcvwuWG5oFDDP
EyNTkkLO6QTM88TlMf33rCvJ88S/ePp7B4rI84QsJztxUT55nri/Lya9P5s8
FVyfDc2qTWP77VTIPX1E1JMsYN8bFYo0wZLBrez8PBW+Fux7LommeSokjWm4
XLGSedtV2C/XurWG0nwVVnx141bAPOadU8Gi8Et+HKhHhcXpwfU2WuZ1qKC0
XT5Rp6A+NdKM47pP2FOfGgXl069kmlKfGrkN/8k7zKM+Ne6VlW5/+ZzP+tSY
bxWbOechn/WpUXpq1ijrFj7rU+NB4eMFwjo+61Ojq2Jg5tJLfNanxslxvocM
zjKvQw3TvpHmyfnM42lw7chI9vdZzLPT4HajcWjXHuZpNZh29EDS1m3Mm6dB
+tU9FQHR1KdBjtuloYhw6tNg2aosE/lC6tOgqWGvx93Z1KdBSfaIIoujPg1a
sl+E9qipTwP1rbKARXLq06InV7HOgE99WnxjHlq40ozP3h8tPltVWTfZkPq0
iPY1G/xm2J71abFRHp8045U969MiY2qzb0uvPevT4vih3zO4TvsP3jktjhqu
/veWDnvWp8VSv6aAR/eY16HF3Gpde+ld5vEmIap3Y1j5u/v/A6uUSik=
      "]]}, 
    {RGBColor[0.5, 0, 0.5], PointSize[0.007333333333333334], 
     AbsoluteThickness[1.6], LineBox[CompressedData["
1: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
      "]]}}, {{}, {}}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{0, -14.533622203129966`},
  DisplayFunction->Identity,
  Frame->{{False, False}, {False, False}},
  FrameLabel->{{None, None}, {None, None}},
  FrameTicks->{{
     Charting`ScaledTicks[{Log, Exp}], 
     Charting`ScaledFrameTicks[{Identity, Identity}]}, {Automatic, Automatic}},
  GridLines->{None, None},
  GridLinesStyle->Directive[
    GrayLevel[0.5, 0.4]],
  Method->{
   "OptimizePlotMarkers" -> True, "OptimizePlotMarkers" -> True, 
    "CoordinatesToolOptions" -> {"DisplayFunction" -> ({
        Identity[
         Part[#, 1]], 
        Exp[
         Part[#, 2]]}& ), "CopiedValueFunction" -> ({
        Identity[
         Part[#, 1]], 
        Exp[
         Part[#, 2]]}& )}},
  PlotLabel->FormBox[
   "\"\:0410\:0431\:0441\:043e\:043b\:044e\:0442\:043d\:0430\:044f \:043e\
\:0448\:0438\:0431\:043a\:0430\"", TraditionalForm],
  PlotRange->{{0, 20.}, {-14.533622203129966`, -6.7214160235873175`}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.02], 
     Scaled[0.05]}},
  Ticks->FrontEndValueCache[{Automatic, 
     Charting`ScaledTicks[{Log, Exp}]}, {Automatic, {{-13.815510557964274`, 
       FormBox[
        TemplateBox[{"10", 
          RowBox[{"-", "6"}]}, "Superscript", SyntaxForm -> SuperscriptBox], 
        TraditionalForm], {0.01, 0.}}, {-11.512925464970229`, 
       FormBox[
        TemplateBox[{"10", 
          RowBox[{"-", "5"}]}, "Superscript", SyntaxForm -> SuperscriptBox], 
        TraditionalForm], {0.01, 0.}}, {-9.210340371976182, 
       FormBox[
        TemplateBox[{"10", 
          RowBox[{"-", "4"}]}, "Superscript", SyntaxForm -> SuperscriptBox], 
        TraditionalForm], {0.01, 0.}}, {-6.907755278982137, 
       FormBox["0.001`", TraditionalForm], {0.01, 0.}}, {-16.11809565095832, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-15.424948470398375`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-15.01948336229021, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-14.73180128983843, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-14.508657738524219`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-14.326336181730264`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-14.172185501903007`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-14.038654109278484`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-13.9208710736221, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-13.122363377404328`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-12.716898269296165`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-12.429216196844383`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-12.206072645530174`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-12.02375108873622, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-11.86960040890896, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-11.736069016284437`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-11.618285980628055`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-10.819778284410283`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-10.41431317630212, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-10.126631103850338`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-9.903487552536127, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-9.721165995742174, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-9.567015315914915, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-9.433483923290392, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-9.315700887634009, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-8.517193191416238, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-8.111728083308073, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.824046010856292, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.600902459542082, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.418580902748128, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.264430222920869, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.1308988302963465`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.013115794639964, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-6.214608098422191, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-5.809142990314028, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-5.521460917862246, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-5.298317366548036, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-5.115995809754082, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.961845129926823, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.8283137373023015`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.710530701645918, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.605170185988091, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.509860006183766, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.422848629194137, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}}}]]], "Output",
 CellChangeTimes->{
  3.8783072403781695`*^9, {3.8783073201211853`*^9, 3.8783074380133357`*^9}, {
   3.8783074696560507`*^9, 3.878307534606882*^9}, {3.878307614425537*^9, 
   3.878307664328005*^9}, {3.878307723110769*^9, 3.878307750157426*^9}, {
   3.878307794617388*^9, 3.8783078401059*^9}, 3.878307922031799*^9, {
   3.8783079722850113`*^9, 3.8783079995423164`*^9}, {3.8783080478284225`*^9, 
   3.8783080790108924`*^9}, 3.878308137141679*^9, 3.8783081703837357`*^9, {
   3.878308210713419*^9, 3.8783082228781834`*^9}, {3.878308261107669*^9, 
   3.8783082888818607`*^9}},
 CellLabel->
  "Out[260]=",ExpressionUUID->"25c7ffa2-ec3c-471f-b453-ae3afeaebe2b"],

Cell[BoxData[
 GraphicsBox[{{}, {{}, {}, 
    {RGBColor[1, 0, 0], PointSize[0.007333333333333334], AbsoluteThickness[
     1.6], LineBox[CompressedData["
1:eJw11AlQFGcWB/BhwKACyqXAMMPcw8BwzAEKSNl/EVRcvAkGDZhIRDzwQsYY
FW/FCItnDC6KxCPCghhZ41XEiRJBAUUUD4gHoIOGiKBIiBjcGL73qrq6vur3
fu9fXV0tnb146hw+j8er+Pv6cN+f/aHOcc4XTEWZLzWmvvNVbmTrsmTTKI0p
wPChbnHWqozaNZle7Pl9ri3Uwr841MvE+6cec8Pyf3RoK1Oz/mbu5tyrRdMC
1aa5iR/KzBl0/NBQkZrNP+eC/xhx+eMCT1N11Yf6nfNP88uKSfBkXjsX2SOx
WeHiyfo7uDM5geLEJyrmv+ZGBeWM31akYvOdXEBB0fribSq2r4tLyS2euumV
knndnG2FmzH4vZJ5f3KD8avzJGvyerig4s2G4kIl895xkkWl2RtClMzr5VxE
q2a2SMjjIXTvp6bPOxWsn4eGoWt1AQryLVAVkJb8sFnB5vlYNyM2pLlSwfZZ
IjMz89mWgwrmWWHBr0uEJ1aQZ4W1H0WnFH2qYF4/pAskg0PCyPsIVt+edflh
OnnWsPHlGYNV5PXHlzVj73b3yJnXH+llKRU7/j73eQNgenR5RHeXnHkDMdV3
Ya6jSc48G/wr5puMm4Vy5tliinjvi+c55NnimbPPrAVZ5NnB3tqrV3OMvEFo
W320/Ovd5A3GyWHyrmVzybPHktNOwceXUr89FHk54rT55Nuj4uP8L/I4uemf
cYMDDm/a9/7GaNrngIGVqsoMJXmOWJPasCpeQ54jlLVnT92wI88RZSILQaAN
5XGC+nmV18S/ZMxzQprNg1PXe2TMc4ZStaz6sAV5zqjpslTHPJUxzxnuq48p
SupkzBsCtd24e+315A3B4fBU8bcXyBsKufPjrMhSGfOGIi+SP11/hryh2Ld/
08awAvJcUCqME707Tp4L3K9cKozIJ88VP3dGZI/KJc8V9q+ilw3/hjxXVNlJ
jYvWk+eGpvCId9Fp5LnB02g/fNtK8gQI3/zXvmmp5AlgVhz5fucs8gQwTE65
yEsgzx1Ra/td2DONPHc4BOT0uMSSJ8SL0kNaRJInhDmpsOp8GHlCyIbciD01
gjwRYl/f49sEkCfCVx7e6ts+5HmgQxJ3rlxBngekM0+PyxKT5wHb2OUlvUPJ
EyPt4XzJ1/bkiTG6y8oy0IY8CYKnTK/ztZSx70uC3EsrQgp6pMyX4I2w7rXm
jZTNS1BWsVxR+FLK9klQm7n1s7gWKfOkaJxm2KlpkjJPitj0trbWevKkCMlY
my++Q54UY8a1Ox2tIU+KufVess4r5MnQ/VNH8IyL5Mngmj5Pdek8eTJcLmnZ
9qqEPBk0rxvfGgvJk2F2+8iRDvnkyXHfcdVDea6UvR85Vj/4T/fe/eTJ4T6A
t99vL3lynN+zcpLLDvLkeP9OH5u3mTwF/jDP3MetI0+B5IjRba++Ik+BO9e3
bihNJU8Bwe6MN0kLyFPAnHJgJC+RPCXmpAYPMc4iT4l5PRuXRcaSp8TbN8NH
1k8hT4mgE0H+uyLJU6IntqWoMYI8FX5+MlmcyJGngsdShfXOYeSpEF1/d6ZW
S54Kx2YMd+L7kKeC9TyLqE1y8jyxvHZ32H138jzBM4YcH+RMnicE7eZ8R1vy
PPF26dvb763J88R2jwezJ/DJU2PSvKRrtt0S5qlh9/LG/KSXEuapkWsXcbm0
TcI8NayNf8anmiXMU8NP9fan8gYJ87zA3Yufk1lHnhdazx7tyLtGnhciSgZ8
+b9y8rxQELE47nEpeV7QPLp4d+VZ8rwhH6Pan3SSPG+c2tNQ51lAnjc+k50/
fC2HPG/8Lgn0TdlLnjdG7aoaGL2DPA0GTbmbHL2FPA3GuxwyL19LngZm+6vX
o43kaXDw1uSGmIXkaTBGEV7JTyLPB8G3x14UxZPng2bTwBpRDHk+uLVg5edF
keT5YJn0dUrvaPJ8MCV5w79FgeT5wjLoTo+zljxfHMj2Fk1QkeeL2B1XRIUC
8nyxePywaDiT54tzPZVprf3I80NTZ2TNgW4x8/yQZrQyhT8VM88PY7Zsyauo
FTPPD+IEz6LY82Lm+cGpLD2rNVfMPH9UH/F5Er+bPH+E78qo/W4Fef7gC8V6
p3jy/BHWGKY5MZY8f3BfSIwqLXla5J85krHRlfW7afGsuPJmLV/M/jdaTG3R
+hc89+ibj9LiUtnEQK7Gg+3TotzNwerpjx593jotvj95yyc/x4Pt1yJjTfua
6PUefV6JFmn1dUtmJTKvSotNs1PDkiKZZ9bilzPn/qvwYx5PB+n2Wyv22DPP
TQebI45Rha9ELJ8OB/uXX150W8Ty6VA9/fAblzMilk+HktCKpon7RCyfDna6
7dqdRhHLp8PEHblNx2OYV6KD5ObSqD3DmFelA7/hkeuWIcwz6zDO3nJCfpeQ
5dPjkyvV9w/VClk+PXIaK3+IKRGyfHpUD1w4oV+WkOXTI27iBY+KhUKWT4+W
PGNo2XjmrdMj4VSWX4KGedl6pG7ld7paM69ED1dzXKLFM3eWT49Ho/WZv/3i
zvLpEfZd47jkY+4snwHrx+v6NW51Z/kMCBC1PXox3519PwakdzxftXUy86IM
eK+csP7pcOYlGtA+Z9ZvkTLmrTPAqWPANgxmXrYBzXVpit5eQZ9XYkCQKKH1
dIeA5TPg6FXrpI5nApbPgDlPi6t6mwUsXwD8bko+KW0SmP4PPq03dA==
      "]]}, 
    {RGBColor[0, 1, 0], PointSize[0.007333333333333334], AbsoluteThickness[
     1.6], LineBox[CompressedData["
1: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
      "]]}, 
    {RGBColor[0, 0, 1], PointSize[0.007333333333333334], AbsoluteThickness[
     1.6], LineBox[CompressedData["
1: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
      "]]}, 
    {RGBColor[0.5, 0, 0.5], PointSize[0.007333333333333334], 
     AbsoluteThickness[1.6], LineBox[CompressedData["
1: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
      "]]}}, {{}, {}}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{0, -14.534953820582682`},
  DisplayFunction->Identity,
  Frame->{{False, False}, {False, False}},
  FrameLabel->{{None, None}, {None, None}},
  FrameTicks->{{
     Charting`ScaledTicks[{Log, Exp}], 
     Charting`ScaledFrameTicks[{Identity, Identity}]}, {Automatic, Automatic}},
  GridLines->{None, None},
  GridLinesStyle->Directive[
    GrayLevel[0.5, 0.4]],
  Method->{
   "OptimizePlotMarkers" -> True, "OptimizePlotMarkers" -> True, 
    "CoordinatesToolOptions" -> {"DisplayFunction" -> ({
        Identity[
         Part[#, 1]], 
        Exp[
         Part[#, 2]]}& ), "CopiedValueFunction" -> ({
        Identity[
         Part[#, 1]], 
        Exp[
         Part[#, 2]]}& )}},
  PlotLabel->FormBox[
   "\"\:041e\:0442\:043d\:043e\:0441\:0438\:0442\:0435\:043b\:044c\:043d\:0430\
\:044f \:043e\:0448\:0438\:0431\:043a\:0430\"", TraditionalForm],
  PlotRange->{{0, 20.}, {-14.534953820582682`, -6.721425415995595}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.02], 
     Scaled[0.05]}},
  Ticks->FrontEndValueCache[{Automatic, 
     Charting`ScaledTicks[{Log, Exp}]}, {Automatic, {{-13.815510557964274`, 
       FormBox[
        TemplateBox[{"10", 
          RowBox[{"-", "6"}]}, "Superscript", SyntaxForm -> SuperscriptBox], 
        TraditionalForm], {0.01, 0.}}, {-11.512925464970229`, 
       FormBox[
        TemplateBox[{"10", 
          RowBox[{"-", "5"}]}, "Superscript", SyntaxForm -> SuperscriptBox], 
        TraditionalForm], {0.01, 0.}}, {-9.210340371976182, 
       FormBox[
        TemplateBox[{"10", 
          RowBox[{"-", "4"}]}, "Superscript", SyntaxForm -> SuperscriptBox], 
        TraditionalForm], {0.01, 0.}}, {-6.907755278982137, 
       FormBox["0.001`", TraditionalForm], {0.01, 0.}}, {-16.11809565095832, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-15.424948470398375`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-15.01948336229021, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-14.73180128983843, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-14.508657738524219`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-14.326336181730264`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-14.172185501903007`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-14.038654109278484`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-13.9208710736221, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-13.122363377404328`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-12.716898269296165`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-12.429216196844383`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-12.206072645530174`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-12.02375108873622, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-11.86960040890896, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-11.736069016284437`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-11.618285980628055`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-10.819778284410283`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-10.41431317630212, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-10.126631103850338`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-9.903487552536127, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-9.721165995742174, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-9.567015315914915, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-9.433483923290392, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-9.315700887634009, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-8.517193191416238, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-8.111728083308073, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.824046010856292, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.600902459542082, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.418580902748128, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.264430222920869, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.1308988302963465`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-7.013115794639964, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-6.214608098422191, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-5.809142990314028, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-5.521460917862246, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-5.298317366548036, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-5.115995809754082, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.961845129926823, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.8283137373023015`, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.710530701645918, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.605170185988091, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.509860006183766, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}, {-4.422848629194137, 
       FormBox[
        TemplateBox[{0., 0.}, "Spacer2"], TraditionalForm], {0.005, 
       0.}}}}]]], "Output",
 CellChangeTimes->{
  3.8783072403781695`*^9, {3.8783073201211853`*^9, 3.8783074380133357`*^9}, {
   3.8783074696560507`*^9, 3.878307534606882*^9}, {3.878307614425537*^9, 
   3.878307664328005*^9}, {3.878307723110769*^9, 3.878307750157426*^9}, {
   3.878307794617388*^9, 3.8783078401059*^9}, 3.878307922031799*^9, {
   3.8783079722850113`*^9, 3.8783079995423164`*^9}, {3.8783080478284225`*^9, 
   3.8783080790108924`*^9}, 3.878308137141679*^9, 3.8783081703837357`*^9, {
   3.878308210713419*^9, 3.8783082228781834`*^9}, {3.878308261107669*^9, 
   3.878308288981594*^9}},
 CellLabel->
  "Out[261]=",ExpressionUUID->"3fa33214-426e-4ede-8b95-f0a98038f9ea"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
},
WindowSize->{1052.8615384615384`, 520.0615384615385},
WindowMargins->{{0, Automatic}, {Automatic, 0}},
Magnification:>0.8 Inherited,
FrontEndVersion->"12.1 for Microsoft Windows (64-bit) (June 19, 2020)",
StyleDefinitions->"Default.nb",
ExpressionUUID->"221c8660-9d23-464d-a464-64de08a2da8f"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[580, 22, 393, 6, 44, "Subsection",ExpressionUUID->"052ea176-76b6-40ef-8296-7031208be896"],
Cell[CellGroupData[{
Cell[998, 32, 217, 4, 35, "Subsubsection",ExpressionUUID->"92c2de94-43af-4bca-88e3-0b50de7612d8"],
Cell[1218, 38, 2185, 55, 139, "Input",ExpressionUUID->"5b25e8f3-8b22-4be9-927c-0feaeca9cd04"]
}, Open  ]],
Cell[CellGroupData[{
Cell[3440, 98, 335, 5, 35, "Subsubsection",ExpressionUUID->"a63540ee-6954-4bf7-adbf-ca686e39bed1"],
Cell[3778, 105, 634, 16, 23, "Input",ExpressionUUID->"27cb126b-7323-47ec-b58f-63090377d257"],
Cell[4415, 123, 1105, 30, 35, "Input",ExpressionUUID->"05886a18-528a-412f-af04-4d9a3f4472ef"],
Cell[5523, 155, 2399, 62, 109, "Input",ExpressionUUID->"b43426dd-5408-4f1a-ac9f-71de2a8bcdac"]
}, Open  ]],
Cell[CellGroupData[{
Cell[7959, 222, 203, 3, 35, "Subsubsection",ExpressionUUID->"28eb9d12-1ad7-4c95-95c7-be1fc6fa3d30"],
Cell[CellGroupData[{
Cell[8187, 229, 3373, 96, 180, "Input",ExpressionUUID->"a0754f5e-bee4-41cc-888c-a0ea46689f11"],
Cell[11563, 327, 2809, 51, 394, "Output",ExpressionUUID->"5059c4ff-653b-4809-bd01-341212afafdc"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[14421, 384, 309, 5, 35, "Subsubsection",ExpressionUUID->"ac335788-80a0-4d58-894e-c796c0aa4996"],
Cell[CellGroupData[{
Cell[14755, 393, 4071, 105, 235, "Input",ExpressionUUID->"b0944d7e-99a6-459e-8b62-7d14bd64476b"],
Cell[18829, 500, 19382, 385, 199, "Output",ExpressionUUID->"25c7ffa2-ec3c-471f-b453-ae3afeaebe2b"],
Cell[38214, 887, 19412, 385, 199, "Output",ExpressionUUID->"3fa33214-426e-4ede-8b95-f0a98038f9ea"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}
]
*)

