insert Users(Username)
values ('User1'), ('User2'), ('User3'), ('User4'), ('User5');

insert Projects(Title, Description, Start_Date, Plan_Finish_Date, Finished)
values ('Project 1', 'First project', '2024-02-01 09:00', '2024-03-30 18:00', false),
	('Project 2', 'Second project', '2023-04-02 15:30', '2024-01-30 19:00', true),
	('Project 3', 'Third project', '2023-06-05 09:00', '2024-07-05 18:00', false),
	('Project 4', 'Fourth project', '2024-05-11 08:00', '2024-08-20 14:00', false),
	('Project 5', 'Fifth project', '2025-03-10 09:00', '2025-04-30 20:00', false);

insert Tasks(Project_Id, Title, Description, Status, Plan_Finish_Date)
values (1, 'Task 1', 'First task for first project', 'Done', '2024-02-10 18:00'),
	(1, 'Task 2', 'Second task for first project', 'Done', '2024-02-20 15:00'),
	(2, 'Task 3', 'Third task for second project', 'Done', '2024-12-20 18:00'),
	(3, 'Task 4', 'Fourth task for third project', 'In progress', '2024-03-10 18:00'),
	(3, 'Task 5', 'Fifth task for third project', 'To do', '2024-04-11 15:00'),
	(3, 'Task 6', 'Sixth task for third project', 'Not done', '2024-02-01 12:00'),
	(4, 'Task 7', 'Seventh task for fourth project', 'To do', '2024-06-10 16:00'),
	(4, 'Task 8', 'Eight task for fourth project', 'Won\'t be done', '2024-07-19 20:00'),
	(5, 'Task 9', 'Ninth task for fifth project', 'To do', '2025-03-30 11:00'),
	(5, 'Task 10', 'Tenth task for fifth project', 'To do', '2025-04-20 14:00');

insert Assigned_Tasks(User_Id, Task_Id)
values
(
	(SELECT Id FROM Users WHERE Username='User1'),
    (SELECT Id FROM Tasks WHERE Title='Task 1')
),
(
	(SELECT Id FROM Users WHERE Username='User1'),
    (SELECT Id FROM Tasks WHERE Title='Task 3')
),
(
	(SELECT Id FROM Users WHERE Username='User2'),
    (SELECT Id FROM Tasks WHERE Title='Task 2')
),
(
	(SELECT Id FROM Users WHERE Username='User3'),
    (SELECT Id FROM Tasks WHERE Title='Task 4')
),
(
	(SELECT Id FROM Users WHERE Username='User3'),
    (SELECT Id FROM Tasks WHERE Title='Task 5')
),
(
	(SELECT Id FROM Users WHERE Username='User4'),
    (SELECT Id FROM Tasks WHERE Title='Task 6')
),
(
	(SELECT Id FROM Users WHERE Username='User5'),
    (SELECT Id FROM Tasks WHERE Title='Task 8')
),
(
	(SELECT Id FROM Users WHERE Username='User5'),
    (SELECT Id FROM Tasks WHERE Title='Task 7')
),
(
	(SELECT Id FROM Users WHERE Username='User1'),
    (SELECT Id FROM Tasks WHERE Title='Task 9')
),
(
	(SELECT Id FROM Users WHERE Username='User3'),
    (SELECT Id FROM Tasks WHERE Title='Task 10')
);

insert into Users_Projects(User_Id, Project_Id)
select distinct Users.Id, Projects.Id from Users, Projects, Assigned_Tasks, Tasks
where Users.Id=Assigned_Tasks.User_Id and Tasks.Id=Assigned_Tasks.Task_Id and Projects.Id=Tasks.Project_Id;

delete from Users
where Username='User5';

delete from Projects
where Finished=true;

delete from Tasks
where Status='Won\'t be done';

update Tasks
set Tasks.Finished=true
where Tasks.Status='Done';

select Users.Username, Tasks.Title, Tasks.Status from Users, Tasks, Assigned_Tasks
where Users.Username='User3' and Users.Id=Assigned_Tasks.User_Id and Tasks.Id=Assigned_Tasks.Task_Id;

select Projects.Title, Tasks.Title from Projects, Tasks
where Projects.Id=Tasks.Project_Id;

select Projects.Title as Project_Title, Projects.Plan_Finish_Date as Projects_Plan_Finish_Date,
	Tasks.Title as Task_Title, Tasks.Status as Task_Status, Tasks.Plan_Finish_Date as Tasks_Plan_Finish_Date
from Projects, Tasks
where Projects.Id=Tasks.Project_Id
order by Tasks.Plan_Finish_Date;

select * from Users;
select * from Projects;
select * from Tasks;
select * from Assigned_Tasks;
select * from Users_Projects;