-- Note: start node /home/giffy/wallet
declare
  l_xml varchar2(4000);
begin

  apex_web_service.g_request_headers(1).name := 'Content-Type';
  apex_web_service.g_request_headers(1).value := 'application/x-www-form-urlencoded';

  l_xml :=
  apex_web_service.make_rest_request(
--    p_url => 'http://localhost:9000/twilio?url='
--      || apex_util.url_encode(''),
    p_url => 'http://localhost:9000/twilio',
    p_http_method => 'POST',
    -- p_scheme => ,
    -- p_proxy_override => ,
    -- p_transfer_timeout => ,
    -- Test number: 15005550006
    p_body => 'From=%2B16475566390' || chr(38) || 'To=%2B1TODO' || chr(38) ||'Body=From+SQLDev (new)'
    -- p_body_blob => ,
    -- p_parm_name => ,
    -- p_parm_value => ,
    -- p_wallet_path => ,
    -- p_wallet_pwd => ,
  );

--  dbms_output.put_line(l_xml);
  logger.log(l_xml, 'sms');
end;
/
