function varargout = Image_Classify(varargin)
% IMAGE_CLASSIFY MATLAB code for Image_Classify.fig
%      IMAGE_CLASSIFY, by itself, creates a new IMAGE_CLASSIFY or raises the existing
%      singleton*.
%
%      H = IMAGE_CLASSIFY returns the handle to a new IMAGE_CLASSIFY or the handle to
%      the existing singleton*.
%
%      IMAGE_CLASSIFY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_CLASSIFY.M with the given input arguments.
%
%      IMAGE_CLASSIFY('Property','Value',...) creates a new IMAGE_CLASSIFY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Image_Classify_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Image_Classify_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Image_Classify

% Last Modified by GUIDE v2.5 12-Aug-2019 15:16:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Image_Classify_OpeningFcn, ...
                   'gui_OutputFcn',  @Image_Classify_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Image_Classify is made visible.
function Image_Classify_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Image_Classify (see VARARGIN)

% Choose default command line output for Image_Classify
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Image_Classify wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Image_Classify_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, ~, ~)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
global y;
global predicted;
x1=x(:,1:end-1);
x2=x(:,end);
y1=y(:,1:end);
global knn;
knn=4;
%[predicted]=knneval(x1,x2,y1,knn);
k=1;
for i=1:size(y1,1)
    for j=1:size(x1,1)
        res=y1(i,:)-x1(j,:);
        p=res.^2;
        p=sum(p);
        p=sqrt(p);
        list(k,:)=[p];
         k=k+1;
    end
     size(list);
    k=1;
    list=[list x2];
    list=sortrows(list,1);
    if knn==1
      predicted(i,:)=[list(1,2)];
    else
        predicted(i,:)=[mode(list(knn,2))];
    end
    list=0;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(~, ~, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global predicted;
global a;
if(a==1)
    if(predicted==1)
        res='Rose';
set(handles.edit1,'string',res);
    elseif(predicted==2)
         res='Dandelion';
set(handles.edit1,'string',res);
elseif(predicted==3)
         res='Daisy';
set(handles.edit1,'string',res);
elseif(predicted==4)
         res='Sunflower';
set(handles.edit1,'string',res);
elseif(predicted==5)
         res='Tulip';
set(handles.edit1,'string',res);
    end
elseif(a==2)
    if(predicted==1)
        res='Apple';
set(handles.edit1,'string',res);
    elseif(predicted==2)
         res='Mandarin';
set(handles.edit1,'string',res);
elseif(predicted==3)
         res='Orange';
set(handles.edit1,'string',res);
elseif(predicted==4)
         res='Lemon';
set(handles.edit1,'string',res);
    end
end




% --- Executes on selection change in listbox1.
function listbox1_Callback(~, ~, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
global x;
global a;
a=get(handles.listbox1,'Value');
if(a==1)   
x=load('C:/Users/Kartik My Pride/Desktop/09-08-2019/traindata.txt');
elseif(a==2)
x=load('C:/Users/Kartik My Pride/Desktop/09-08-2019/trainfruits.txt');
end    


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, ~, ~)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(~, ~, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
global y;
if(a==1)
[filename, pathname]=uigetfile({'*.jpg'});
image=strcat(pathname,filename);
axes(handles.axes1)
imshow(image)
y1=imread(image);
r1=mean2(y1(:,:,1));
g1=mean2(y1(:,:,2));
b1=mean2(y1(:,:,3));
y=[r1,g1,b1];
elseif(a==2)
[filename, pathname]=uigetfile({'*.jpg'});
image=strcat(pathname,filename);
axes(handles.axes1)
imshow(image)  
y=load('C:/Users/Kartik My Pride/Desktop/09-08-2019/testfruits.txt');
end


function edit1_Callback(~, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
