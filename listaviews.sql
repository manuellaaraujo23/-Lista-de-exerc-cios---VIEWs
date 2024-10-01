/*
1. Exibir lista de alunos e seus cursos
Crie uma view que mostre o nome dos alunos e as disciplinas em que estão matriculados, incluindo o nome do curso.
*/

create view Lista_Alunos_Cursos as
select a.nome as Nome_Aluno, d.nome as Nome_Disciplina, c.nome as Nome_Curso
from Alunos a
join Matriculas m on a.id = m.aluno_id
join Disciplinas d on m.disciplina_id = d.id
join Cursos c on d.curso_id = c.id;

/*
2. Exibir total de alunos por disciplina
Crie uma view que mostre o nome das disciplinas e a quantidade de alunos matriculados em cada uma.
*/
create view Total_Alunos_Por_Disciplina as
select d.nome as Nome_Disciplina, COUNT(m.aluno_id) as Total_Alunos
from Matriculas m
join Disciplinas d on m.disciplina_id = d.id
group by d.nome;

/*
3. Exibir alunos e status das suas matrículas
Crie uma view que mostre o nome dos alunos, suas disciplinas e o status da matrícula (Ativo, Concluído, Trancado).
*/
create view Alunos_Status_Matricula as
select a.nome as Nome_Aluno, d.nome as Nome_Disciplina, m. status as Status_Matricula
from Alunos a
join Matriculas m on a.id = m.aluno_id
join Disciplinas d on m.disciplina_id = d.id;

/*
4. Exibir professores e suas turmas
Crie uma view que mostre o nome dos professores e as disciplinas que eles lecionam, com os horários das turmas.
*/
create view Professores_Turmas as
select p.nome as Nome_Professor, d.nome as Nome_Disciplina, t.horario as Horario_Turma
from Professores p
join Turmas t on p.id = t.professor_id
join Disciplinas d on t.disciplina_id = d.id;

/*
5. Exibir alunos maiores de 20 anos
Crie uma view que exiba o nome e a data de nascimento dos alunos que têm mais de 20 anos.
*/
create view Alunos_Maiores_20 as
select nome as Nome_Aluno, data_nascimento
from Alunos
where timestampdiff (year, data_nascimento, curdate()) > 20;

/*
6. Exibir disciplinas e carga horária total por curso
Crie uma view que exiba o nome dos cursos, a quantidade de disciplinas associadas e a carga horária total de cada curso.
*/
create view Carga_Horaria_Curso as
select c.nome as Nome_Curso, COUNT(d.id) as Total_Disciplinas, sum(d.carga_horaria) as Carga_Horaria_Total
from Cursos c
join Disciplinas d on c.id = d.curso_id
group by c.nome;

/*
7. Exibir professores e suas especialidades
Crie uma view que exiba o nome dos professores e suas especialidades.
*/
create view Professores_Especialidades as
select nome as Nome_Professor, especialidade
from Professores;

/*
8. Exibir alunos matriculados em mais de uma disciplina
Crie uma view que mostre os alunos que estão matriculados em mais de uma disciplina.
*/
create view Alunos_Multiplas_Matriculas as
select a.nome as Nome_Aluno, count(m.disciplina_id) as Total_Disciplinas
from Alunos a
join Matriculas m on a.id = m.aluno_id
group by a.nome
having count (m.disciplina_id) > 1;

/*
9. Exibir alunos e o número de disciplinas que concluíram
Crie uma view que exiba o nome dos alunos e o número de disciplinas que eles concluíram.
*/ 
create view Alunos_Disciplinas_Concluidas as
select a.nome as Nome_Aluno, COUNT(m.disciplina_id) as Total_Disciplinas_Concluidas
from Alunos a
join Matriculas m on a.id = m.aluno_id
where m.status = 'Concluído'
group by a.nome;

/*
10. Exibir todas as turmas de um semestre específico
Crie uma view que exiba todas as turmas que ocorrem em um determinado semestre (ex.: 2024.1).
*/
create view Turmas_Semestre as
select t.*
from Turmas t
where t.semestre = '2024.1';

/*
11. Exibir alunos com matrículas trancadas
Crie uma view que exiba o nome dos alunos que têm matrículas no status "Trancado".
*/
create view vw_alunos_matriculas_trancadas as
select A.nome
from Aluno A
join Matricula M on A.id_aluno = M.id_aluno
where M.status_matricula = 'Trancado';

/*
12. Exibir disciplinas que não têm alunos matriculados
Crie uma view que exiba as disciplinas que não possuem alunos matriculados.
*/
create view vw_disciplinas_sem_alunos as
select D.nome_disciplina
from Disciplina D
left join Matricula M on D.id_disciplina = M.id_disciplina
where M.id_aluno is null;

/*
13. Exibir a quantidade de alunos por status de matrícula
Crie uma view que exiba a quantidade de alunos para cada status de matrícula (Ativo, Concluído, Trancado).
*/
create view vw_alunos_por_status_matricula as
select M.status_matricula, count(M.id_aluno) as total_alunos
from Matricula M
group by M.status_matricula;

/*
14. Exibir o total de professores por especialidade
Crie uma view que exiba a quantidade de professores por especialidade (ex.: Engenharia de Software, Ciência da Computação).
*/
create view vw_professores_por_especialidade as
select especialidade, COUNT(id_professor) as total_professores
from Professor
group by especialidade;

/*
15. Exibir lista de alunos e suas idades
Crie uma view que exiba o nome dos alunos e suas idades com base na data de nascimento.
*/
create view vw_alunos_e_idades as
select nome, EXTRACT(year from AGE(data_nascimento)) as idade
from Aluno;

/*
16. Exibir alunos e suas últimas matrículas
Crie uma view que exiba o nome dos alunos e a data de suas últimas matrículas.
*/
create view vw_alunos_ultimas_matriculas as
select A.nome, mas(M.data_matricula) as ultima_matricula
from Aluno A
join Matricula M on A.id_aluno = M.id_aluno
group by A.nome;

/*
17. Exibir todas as disciplinas de um curso específico
Crie uma view que exiba todas as disciplinas pertencentes a um curso específico, como "Engenharia de Software".
*/
create view vw_disciplinas_por_curso as
select D.nome_disciplina
from Disciplina D
join Curso C on D.id_curso = C.id_curso
where C.nome_curso = 'Engenharia de Software';

/*
18. Exibir os professores que não têm turmas
Crie uma view que exiba os professores que não estão lecionando em nenhuma turma.
*/
create view vw_professores_sem_turmas as
select P.nome
from Professor P
left join Turma T on P.id_professor = T.id_professor
where T.id_turma is null;

/*
19. Exibir lista de alunos com CPF e email
Crie uma view que exiba o nome dos alunos, CPF e email.
*/
create view vw_alunos_cpf_email as
select nome, cpf, email
from Aluno;

/*
20. Exibir o total de disciplinas por professor
Crie uma view que exiba o nome dos professores e o número de disciplinas que cada um leciona.
*/
create view vw_total_disciplinas_por_professor as
select P.nome, count(T.id_disciplina) AS total_disciplinas
from Professor P
join Turma T on P.id_professor = T.id_professor
group by P.nome;
