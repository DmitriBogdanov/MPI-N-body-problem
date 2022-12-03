(* ::Package:: *)

(* ---------------------- *)
(* --- Parse positions --- *)
(* ---------------------- *)
SetDirectory[NotebookDirectory[]];
filenames\[FilledSmallSquare]serial=FileNames[All,"[positions]"];
filenames\[FilledSmallSquare]mpi=FileNames[All,"{mpi}[positions]"];

\[CapitalNu]=Length@filenames\[FilledSmallSquare]serial; (* Number of bodies is the same as number of files containing positions *)

bodynum=1;

positionsWithTime\[FilledSmallSquare]serial=ReadList[filenames\[FilledSmallSquare]serial[[bodynum]],{Real,Real,Real,Real}];
positionsWithTime\[FilledSmallSquare]mpi=ReadList[filenames\[FilledSmallSquare]mpi[[bodynum]],{Real,Real,Real,Real}];

timeLayers=Length@positionsWithTime\[FilledSmallSquare]serial;

positions\[FilledSmallSquare]serial=Table[positionsWithTime\[FilledSmallSquare]serial[[j,2;;4]],{j,1,timeLayers}];
positions\[FilledSmallSquare]mpi=Table[positionsWithTime\[FilledSmallSquare]mpi[[j,2;;4]],{j,1,timeLayers}];

(* ---------------------- *)
(* --- Chech corectness --- *)
(* ---------------------- *)
Row@{"||Serial-Parallel||_max = ",Max[positions\[FilledSmallSquare]serial-positions\[FilledSmallSquare]mpi]}
