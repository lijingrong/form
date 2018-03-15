USE form;

INSERT INTO t_component_prototype (name, label, view_page, edit_page, data, validate_rules, is_common, type) VALUES
  ('name', '姓名', 'text.ftl', 'stringEdit.ftl', '', '', TRUE, 'string'),
  ('gender', '性别', 'radio.ftl', 'multipleValueEdit.ftl', '["男","女"]', '', TRUE, 'radio'),
  ('telephone', '手机号', 'text.ftl', 'stringEdit.ftl', '', '{telephone:true}', TRUE, 'telephone'),
  ('idCard', '身份证', 'text.ftl', 'stringEdit.ftl', '', '{idCard:true}', TRUE, 'idCard'),
  ('education', '学历', 'select.ftl', 'multipleValueEdit.ftl', '["本科","研究生","博士","专科"]', '', TRUE, 'select'),
  ('description', '简介', 'textarea.ftl', 'stringEdit.ftl', '', '', TRUE, 'string'),
  ('hobby', '兴趣', 'checkbox.ftl', 'multipleValueEdit.ftl', '["运动","音乐","唱歌","旅游"]', '', TRUE, 'checkbox'),
  ('email', '邮箱', 'text.ftl', 'stringEdit.ftl', '', '', TRUE, 'email'),
  ('url', '网址', 'text.ftl', 'stringEdit.ftl', '', '', TRUE, 'url'),
  ('compositeAddress', '地址', 'compositeAddress.ftl', 'compositeAddressEdit.ftl', '', '', TRUE, 'address'),
  ('birthday', '生日', 'date.ftl', 'stringEdit.ftl', '', '', TRUE, 'date'),
  ('text', '单行文本', 'text.ftl', 'stringEdit.ftl', '', '', FALSE, 'string'),
  ('textarea', '多行文本', 'textarea.ftl', 'stringEdit.ftl', '', '', FALSE, 'string'),
  ('radio', '单选', 'radio.ftl', 'multipleValueEdit.ftl', '["选项一","选项二","选项三"]', '', FALSE, 'radio'),
  ('checkbox', '多选', 'checkbox.ftl', 'multipleValueEdit.ftl', '["选项一","选项二","选项三"]', '', FALSE, 'checkbox'),
  ('select', '下拉选择', 'select.ftl', 'multipleValueEdit.ftl', '["选项一","选项二","选项三"]', '', FALSE, 'select'),
  ('date', '日期', 'date.ftl', 'stringEdit.ftl', '', '', FALSE, 'date'),
  ('datetime', '日期时间', 'date.ftl', 'stringEdit.ftl', '', '', FALSE, 'datetime'),
  ('time', '时间', 'date.ftl', 'stringEdit.ftl', '', '', FALSE, 'time'),
  ('position', '职位', 'text.ftl', 'stringEdit.ftl', '', '', TRUE, 'string'),
  ('number', '数字', 'text.ftl', 'stringEdit.ftl', '', '', FALSE, 'number');

INSERT INTO t_component_control (component_name, control_label, control_name) VALUES
  ('compositeAddress', '省', 'province'),
  ('compositeAddress', '市', 'city'),
  ('compositeAddress', '区', 'area'),
  ('compositeAddress', '详细地址', 'address');

INSERT INTO t_form (id, title,creator,status, description) VALUES (1, '第一个表单','user','DRAFT', '<p>坚持就是胜利</p>');

insert into users (username, password, enabled,telephone) values ('user', '47bce5c74f589f4867dbd57e9ca9f808', true,'15951076347');
insert into authorities (username, authority) values ('user', 'ROLE_ADMIN');

