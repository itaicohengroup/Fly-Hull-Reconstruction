% set path for experiment folder wherein analysis is still needed
pathToWatch = 'D:\Fly Data\VNC Motor Lines\63_19042019\' ;

% do full analysis or just angles?
justAnglesFlag = true ;

% get experiment number from folder name--too lazy to re-enter each time
pathStruct = generatePathStruct(pathToWatch) ;
pathSplit = strsplit(pathToWatch,'\') ;
folderSplit = strsplit(pathSplit{end-1},'_') ;
ExprNum = str2double(folderSplit{1}) ;

% set movie numbers that need to be analyzed
MovNum = [2 7 8 9] ;
Nmovies = length(MovNum) ;

% run analysis of movies
for k = 1:Nmovies
    tic
    if justAnglesFlag
        analysisPath = findMovAnalysisPath(pathStruct, MovNum(k)) ;
        if isempty(analysisPath)
            continue
        end
        analysisPath_split = strsplit(analysisPath,'\') ;
        savePath = strjoin({analysisPath_split{1:end-1}},'\') ;
        try
            estimateFlyAngles(ExprNum, MovNum(k), savePath) ;
        catch
            fprintf('Failed to analyze movie %d \n', MovNum(k))
        end
    else
        flyAnalysisMain(MovNum(k), ExprNum, pathStruct) ;
    end
    toc
    disp(MovNum(k))
end

% sort analysis folders into proper directories
moveEmptyExprFolders(pathToWatch)
