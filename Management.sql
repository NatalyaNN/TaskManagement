drop database if exists Management;
create database if not exists Management;
use Management;

create table if not exists Users
(
	Id int primary key auto_increment,
    Username varchar(20) unique not null
);

create table if not exists Projects
(
	Id int primary key auto_increment,
    Title varchar(50),
    Description text,
    Creation_Date timestamp not null default now(),
    Start_Date datetime not null default now(),
    Plan_Finish_Date datetime,
    Finished bool default false,
    Finished_Date timestamp
);

create table if not exists Tasks
(
	Id int primary key auto_increment,
    Project_Id int,
    Title varchar(200),
    Description text,
    Status enum("To do", "In progress", "Done", "Not done", "Won\'t be done"),
    Creation_Date timestamp not null default now(),
    Plan_Finish_Date timestamp,
    Finished bool default false,
    Finished_Date timestamp,
    constraint tasks_projects_fk
    foreign key (Project_Id) references Projects(Id)
    on delete cascade
);

create table if not exists Assigned_Tasks
(
	User_Id int,
    Task_Id int,
    primary key (User_Id, Task_Id),
    foreign key (User_Id) references Users (Id)
    on delete cascade
    on update cascade,
    constraint assigned_tasks_fk
    foreign key (Task_Id) references Tasks (Id)
    on delete cascade
    on update cascade
);

create table if not exists Users_Projects
(
	User_Id int,
    Project_Id int,
    primary key (User_Id, Project_Id),
    constraint users_projects_userId_fk
    foreign key (User_Id) references Users (Id)
    on delete cascade
    on update cascade,
    constraint users_projects_projectId_fk
    foreign key (Project_Id) references Projects (Id)
    on delete cascade
    on update cascade
);