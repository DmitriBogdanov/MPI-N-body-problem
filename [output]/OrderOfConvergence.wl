(* ::Package:: *)

(* ::Input:: *)
(*(* ---------------------- *)*)
(*(* --- Parse positions --- *)*)
(*(* ---------------------- *)*)
(*SetDirectory[NotebookDirectory[]];*)
(**)
(*filenames\[FilledSmallSquare]1=FileNames[All,"{order_test_1}[positions]"];*)
(*filenames\[FilledSmallSquare]2=FileNames[All,"{order_test_2}[positions]"];*)
(*filenames\[FilledSmallSquare]3=FileNames[All,"{order_test_3}[positions]"];*)
(*filenames\[FilledSmallSquare]precise=FileNames[All,"{4_body_test}[positions]"];  (* Filenames are sorted lexicographically *)*)
(**)
(*\[CapitalNu]=Length@filenames\[FilledSmallSquare]precise; (* Number of bodies is the same as number of files containing positions *)*)
(**)
(*(* --------------------- *)*)
(*(* --- Difference between serial and parallel solutions --- *)*)
(**)
(*(* We use 1st body for error computation *)*)
(*bodynum=1;*)
(**)
(*positionsWithTime\[FilledSmallSquare]1=ReadList[filenames\[FilledSmallSquare]1[[bodynum]],{Real,Real,Real,Real}];*)
(*positionsWithTime\[FilledSmallSquare]2=ReadList[filenames\[FilledSmallSquare]2[[bodynum]],{Real,Real,Real,Real}];*)
(*positionsWithTime\[FilledSmallSquare]3=ReadList[filenames\[FilledSmallSquare]3[[bodynum]],{Real,Real,Real,Real}];*)
(*positionsWithTime\[FilledSmallSquare]precise=ReadList[filenames\[FilledSmallSquare]precise[[bodynum]],{Real,Real,Real,Real}];*)
(**)
(*timeLayers=Length@positionsWithTime\[FilledSmallSquare]precise;*)
(**)
(*Row@{"\[CapitalNu] = ",\[CapitalNu]}*)
(*Row@{"layers = ",timeLayers}*)
(**)
(*(* ------------------------------------------- *)*)
(*(* --- Separate data into time and positions  --- *)*)
(*(* ------------------------------------------- *)*)
(*times=Table[positionsWithTime\[FilledSmallSquare]precise[[j,1]],{k,1,\[CapitalNu]},{j,1,timeLayers}];*)
(**)
(*positions\[FilledSmallSquare]1=Table[positionsWithTime\[FilledSmallSquare]1[[j,2;;4]],{j,1,timeLayers}];*)
(*positions\[FilledSmallSquare]2=Table[positionsWithTime\[FilledSmallSquare]2[[j,2;;4]],{j,1,timeLayers}];*)
(*positions\[FilledSmallSquare]3=Table[positionsWithTime\[FilledSmallSquare]3[[j,2;;4]],{j,1,timeLayers}];*)
(*positions\[FilledSmallSquare]precise=Table[positionsWithTime\[FilledSmallSquare]precise[[j,2;;4]],{j,1,timeLayers}];*)
(**)
(*SolNorm[points_]:=Sum[Abs@points[[k,1]]+Abs@points[[k,2]]+Abs@points[[k,3]],{k,1,Length@points}];*)
(*SolNormDifference[points1_,points2_]:=Sum[Abs@(points1[[k,1]]-points2[[k,1]])+Abs@(points1[[k,2]]-points2[[k,2]])+Abs@(points1[[k,2]]-points2[[k,2]]),{k,1,Length@points1}];*)
(**)
(*(* ------------- *)*)
(*(* --- Error  --- *)*)
(*(* ------------- *)*)
(*relativeError=SolNormDifference[positions\[FilledSmallSquare]1,positions\[FilledSmallSquare]precise]/SolNorm[positions\[FilledSmallSquare]precise];*)
(**)
(*Print@Row@{"Rel. error = ",relativeError};*)
(**)
(*SolNormDifference[positions\[FilledSmallSquare]2,positions\[FilledSmallSquare]precise]/SolNorm[positions\[FilledSmallSquare]precise];*)
(**)
(*(* ------------------------- *)*)
(*(* --- Convergence Order  --- *)*)
(*(* ------------------------- *)*)
(*index=20;*)
(*coord=2;*)
(**)
(*convergenceOrder=Log[2,*)
(*(positions\[FilledSmallSquare]1[[index,coord]]-positions\[FilledSmallSquare]2[[index,coord]])*)
(*/*)
(*(positions\[FilledSmallSquare]2[[index,coord]]-positions\[FilledSmallSquare]3[[index,coord]])*)
(*];*)
(**)
(*Print@Row@{"(Eitkin rule) Convergence order = ",convergenceOrder};*)
(**)
(*convergenceOrder=Log[2,(positions\[FilledSmallSquare]1[[index,coord]]-positions\[FilledSmallSquare]precise[[index,coord]])/(positions\[FilledSmallSquare]2[[index,coord]]-positions\[FilledSmallSquare]precise[[index,coord]])];*)
(**)
(*Print@Row@{"(Using 'precise' solution) Convergence order = ",convergenceOrder};*)
(**)
