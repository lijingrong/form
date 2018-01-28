USE form;
INSERT INTO t_control(id, name, type, label, view_name,is_common,rule_group_id) VALUES
(1,'name',NULL ,'姓名','text.ftl',TRUE,5),
(2,'gender',NULL ,'性别','radio.ftl',TRUE,8),
(3,'telephone','telephone','手机号','text.ftl',TRUE,7),
(4,'idCard','idCard','身份证','text.ftl',TRUE,6),
(5,'education',NULL ,'学历','select.ftl',TRUE,10),
(6,'description','textarea','简介','textarea.ftl',TRUE,5),
(7,'hobby',NULL ,'兴趣','checkbox.ftl',TRUE,9),
(8,'email','email','邮箱','text.ftl',TRUE,1),
(9,'url','url','网址','text.ftl',TRUE,2);
INSERT INTO t_control_data(id, control_id, name, value) VALUES
(1,2,'男','0'),
(2,2,'女','1'),
(3,5,'博士','0'),
(4,5,'研究生','1'),
(5,5,'本科','2'),
(6,5,'专科','3'),
(7,5,'高中','4'),
(8,7,'足球','0'),
(9,7,'篮球','1'),
(10,7,'乒乓球','2'),
(11,7,'滑雪','3'),
(12,7,'垂钓','4');

INSERT INTO t_validate_rule(id, name,label,type) VALUES
(1,'required','必填','checkbox'),
(2,'minlength','至少字符数','text'),
(3,'maxlength','最多字符数','text'),
(4,'min','最小值','text'),
(5,'max','最大值','text');

INSERT INTO t_validate_rule_group(id, group_name, group_label) VALUES
(1,'email','邮箱'),
(2,'url','网址'),
(3,'number','数值类型'),
(4,'digits','数字'),
(5,'string','字符串'),
(6,'idCard','身份证'),
(7,'telephone','手机'),
(8,'radio','单选'),
(9,'checkbox','多选'),
(10,'select','下拉');

INSERT INTO t_validate_rule_group_rule(rule_id, rule_group_id) VALUES
(1,1),(1,2),(1,3),(4,3),(5,3),(1,4),(2,4),(3,4),(1,5),(2,5),
(3,5),(1,6),(1,7),(1,8),(1,9),(1,10);

INSERT INTO t_form(id, title, description) VALUES (1,'第一个表单','坚持就是胜利');