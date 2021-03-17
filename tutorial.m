format compact
clc;
% Remove the semicolons to see the outputs
c1 = 'A';
class(c1);
s1 = "A";
class(s1);

% logicals
5>2;
b1 = true;

% max and min values of datatypes
intmin('int8');
intmax('int8');
realmax;
realmax('single');

% maintaining readability of large 
% expressions
v1 = 1 + 2 + 3 ...
    + 4;

% type-casting
v2 = 8;
class(v2);
v3 = int8(v2);
class(v3);
v4 = double('A');
v5 = char(64);

% random number generator
randi([10, 20]);

% precision is accurate upto 15 decimal
% places by default
bF = 1.1111111111111111;
bF2 = bF + 0.1111111111111111;
% fprintf("bf2 = %0.16f\n", bF2);

% different math functions
% Enter the command "help elfun" in the
% command window

% conditionals
% Relational operators: > < >= <= == ~=
% logical operators: || && ~
age = 12;
% if age >=5 && age <= 6
%     disp('you''re in Kindergarten')
% elseif age >= 7 && age <= 13
%     disp("You're in middle school")
% elseif age >=14 && age <= 18
%     disp("You're in High School")
% end

% Vectors
vt1 = [5 3 2 1];
vL = length(vt1);
vt1 = sort(vt1, 'descend');
vt2 = 5 : 10;
vt3 = 2 : 2 : 10;
vt4 = [vt1 vt2];
vt4(1);
vtEnd = vt4(end);
vt4(1) = 12;
vt4(11) = 33;
vt4(1:3);
vt4([2 4 6]);

vt5 = [2;3;4];
vt6 = [1 2 3];
vtMult = vt5 * vt6;

vt7 = [4 5 6];
% Dot product can be calculated in the
% following two ways
vtDotP = vt6 * vt7';
vtDotP2 = dot(vt6, vt7);
% cross product
vtCross = cross(vt6, vt7);

% Matrices

m1 = [2 3 4; 4 6 8];
% no. of elements per row
mNRV = length(m1);
% total no. of elements
mNV = numel(m1);
% size in the format [m n]
mS = size(m1);
[nRows, nCols] = size(m1);
% square matrix containing random elements
m2 = randi([10, 20], 3);
m2(1, 2) = 22;
% set all columns of 1st row to 25
m2(1, :) = 25;
% set 1st column of all rows to 36
m2(:, 1) = 36;
% Last row first column
LR1C = m2(end, 1);
% Second Row last column
SRLC = m2(2, end);
% delete second column of all rows
m2(:, 2) = [];

%%%%%%%% for loops %%%%%%%%

% for i = 1: 10
% for i = 10:-1:0
% for i = [2 3 4]
%     disp(i);
% end

% m4 = [2 3 4; 4 6 8];
% for i = 1: 2
%     for j = 1: 3
%         disp(m4(i, j));
%     end
% end
% 
% Ivect = [6 7 8];
% for i=1: length(Ivect)
%     disp(Ivect(i));
% end

%%%%% while loops %%%%%
% i = 1;
% while i < 20
%     if mod(i, 2) == 0
%         disp(i);
%     end
%     i = i + 1;
% end

%%%%% matrix functions %%%%%
m4 = [1:3; 4:6];
m5 = [2:4; 5:7];

m4 + m5;
m4.* m5;
sqrt(m4);
m4 = m4 * 2;
sum(m5);
cumsum(m5);
isequal(m4, m5);
find(m5 > 4);
prod(m5);
cumprod(m5);

%%%%% cells %%%%%
cA1 = {'Doug Smith', 34, [25 8 19]};
cA2 = cell(3);
% Use () to get the cell and {} to get the
% element inside the cell
cA1{1};
cA1{3}(2);
cA1{4} = 'Patty Smith';
length(cA1);
cA1(4) = [];
% for i = 1:length(cA1)
%     disp(cA1{i});
% end

%%%%% strings %%%%%
str1 = 'I am a string';
length(str1);
str1(1);
str1(3:4);
str2 = strcat(str1, ' that''s longer');
strfind(str2, 'a');

%%%%% structures %%%%%
doug = struct('name', 'Doug Smith', ...
    'age', 34, 'purchases', [12, 23]);
% disp(doug.age)
doug.wife = 'Patty Smith';
doug = rmfield(doug, 'wife');
isfield(doug, 'wife');
fieldnames(doug);
customers(1) = doug;
sally = struct('name', 'Sally Smith', ...
    'age', 34, 'purchases', [12, 23]);
customers(2) = sally;
customers;

%%%%% tables %%%%%
name = {'Jim'; 'Pam'; 'Dwight'};
age = [28; 27; 31];
salary = [35000; 26000; 70000];
id = {'1' '2' '3'};

employees = table(name, age, salary, ...
    'RowName', id);
meanSalary = mean(employees.salary);
employees.vDays = [10; 14; 16];
employees('1', :);
isMemberArray = ismember(employees.name,...
    {'Jim', 'Dwight'});
employees(isMemberArray, :);

%%%%% saving and loading file data %%%%%
% randM = randi([10 50], 8)
% save sampdata1.dat randM -ascii
% load sampdata1.dat
% disp(sampdata1)
% type sampdata1.dat

% save myData1
% load myData1
% who
% v4 = 123
% save -append myData1 v4

%%%%% functions %%%%%
% cylinderVol(20, 30);

%%% local variables inside a function
% changeMe = 5;
% changeVal()
% disp(['outside function, changeMe = ', ...
%     num2str(changeMe)])
%%% Note: functions with no arguments can be
%%% called and declared without ()

%%% Return more than one value
% [coneV, cylV] = getVols(10, 20);

%%% Function that accepts variable number of
%%% arguments
% theSum = getSum(1, 2, 3, 4)

%%% Function that returns variable number of
%%% values
% listOfNums = getNumbers(10)

%%% Anonymous functions
cubeVol = @ (l, w, h) l * w * h;
cV = cubeVol(2, 2, 2);

%%% Passing a function as a parameter to
%%% another function
mult3 = @ (x) x*3;
sol = doMath(mult3, 4);




function ans = doMath(func, num)
ans = func(num);
end

function numList = getNumbers(howMany)
for k = 1:howMany
    numList(k) = k;
end
end

function sum = getSum(varargin)
sum=0;
for k = 1:length(varargin)
    sum = sum + varargin{k};
end
end

function [coneVol, cylVol] = ...
    getVols(radius, height)
    cylVol = pi * radius^2 * height;
    coneVol = (1/3) * cylVol;
end

function changeVal()
    changeMe = 10;
    weirdArray = [...
        'inside function, changeMe = ', ...
        num2str(changeMe)]
    disp(weirdArray)
end

function vol = cylinderVol(radius, height)
vol = pi * radius^2 * height;
end