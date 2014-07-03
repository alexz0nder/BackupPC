#!/usr/bin/perl

#my %lang;
#use strict;
use utf8;
# --------------------------------

$Lang{Start_Archive} = "Начать Архивирование";
$Lang{Stop_Dequeue_Archive} = "Остановить/снять с очереди архивирование";
$Lang{Start_Full_Backup} = "Начать ПОЛНОЕ резервирование";
$Lang{Start_Incr_Backup} = "Начать РАЗНОСТНОЕ резервирование";
$Lang{Stop_Dequeue_Backup} = "Остановить/снять с очереди резервирование";
$Lang{Restore} = "Восстановить";

$Lang{Type_full} = "полный";
$Lang{Type_incr} = "разностный";

# -----

$Lang{Only_privileged_users_can_view_admin_options} = "Только привелегированые пользователи могут видеть опции администратора.";
$Lang{H_Admin_Options} = "Сервер BackupPC: Опции Администратора";
$Lang{Admin_Options} = "Опции Администратора";
$Lang{Admin_Options_Page} = <<EOF;
\${h1(qq{$Lang{Admin_Options}})}
<br>
\${h2("Управление сервером")}
<form name="ReloadForm" action="\$MyURL" method="get">
<input type="hidden" name="action" value="">
<table class="tableStnd">
  <tr><td>Перезагрузить конфигурацию сервера:<td><input type="button" value="Перезагрузить"
     onClick="document.ReloadForm.action.value='Reload';
              document.ReloadForm.submit();">
</table>
</form>
<!--
\${h2("Конфигурация сервера")}
<ul>
  <li><i>За дрегими опциями сюда... ,</i>
  <li>Редактировать конфигурацию сервера
</ul>
-->
EOF

$Lang{Unable_to_connect_to_BackupPC_server} = "Не могу установить соединение с сервером BackupPC";
$Lang{Unable_to_connect_to_BackupPC_server_error_message} = <<EOF;
CGI-скрипт (\$MyURL) не может установить сединение с BackupPC сервером
\$Conf{ServerHost} на порт \$Conf{ServerPort}.<br>
Ошибка: \$err.<br>
Возможно сервер BackupPC не запущен или имеет место быть ошибка в файле конфигурации.
Пожалуйста обратитесь к вашему СисАдмину.
EOF

$Lang{Admin_Start_Server} = <<EOF;
\${h1(qq{$Lang{Unable_to_connect_to_BackupPC_server}})}
<form action="\$MyURL" method="get">
Сервер BackupPC по адресу <tt>\$Conf{ServerHost}</tt> порт  <tt>\$Conf{ServerPort}</tt>
не запущен (возможно он остановлен или  еще не запущен).<br>
Запустить его?
<input type="hidden" name="action" value="Запустить сервер">
<input type="submit" value="Запустить сервер" name="ignore">
</form>
EOF

# -----

$Lang{H_BackupPC_Server_Status} = "Состояние сервера BackupPC";

$Lang{BackupPC_Server_Status_General_Info}= <<EOF;
\${h2(\"Основные параметры сервера\")}

<ul>
<li> Персональный ИДентификатор (PID) сервиса \$Info{pid},  на сервере \$Conf{ServerHost},
     версия \$Info{Version}, запущен в \$serverStartTime.
<li> Данная страница сгенерирована в \$now.
<li> Конфигурация в последний раз была загружена в \$configLoadTime.
<li> Резервирование в следующий раз будет запущено в \$nextWakeupTime.
</ul> 

\${h2(\"Дополнительные параметры сервера\")}
    <ul>
        <li>\$numBgQueue ожидающих запросов на резервирование с последнего запланированного пробуждения,
        <li>\$numUserQueue ожидающих запросов пользователя,
        <li>\$numCmdQueue ожидающих командных запросов,
        \$poolInfo
        <li>Файловая система Пул-а сейчас составляет \$Info{DUlastValue}%
            (\$DUlastTime), сегодняшний максимум \$Info{DUDailyMax}% (\$DUmaxTime)
            однако вчера этот показатель был \$Info{DUDailyMaxPrev}%.
    </ul>
</ul>
EOF

$Lang{BackupPC_Server_Status} = <<EOF;
\${h1(qq{$Lang{H_BackupPC_Server_Status}})}

<p>
\$generalInfo

\${h2("Работы выполняемые в данный момент")}
<p>
<table class="tableStnd" border cellspacing="1" cellpadding="3">
<tr class="tableheader"><td> Сервер </td>
    <td> Тип </td>
    <td> Пользователь </td>
    <td> Время запуска </td>
    <td> Комманда </td>
    <td align="center"> PID </td>
    <td align="center"> Xfer PID </td>
    </tr>
\$jobStr
</table>
<p>

\${h2("Сбои требующие внимания!")}
<p>
<table class="tableStnd" border cellspacing="1" cellpadding="3">
<tr class="tableheader"><td align="center"> Сервер </td>
    <td align="center"> Тип </td>
    <td align="center"> Пользователь </td>
    <td align="center"> Последняя попытка </td>
    <td align="center"> Подробнее </td>
    <td align="center"> Время Ошибки </td>
    <td> Последняя ошибка (отличное от нет ping-а) </td></tr>
\$statusStr
</table>
EOF

# --------------------------------
$Lang{BackupPC__Server_Summary} = "BackupPC: Сводная информация по серверам";
$Lang{BackupPC__Archive} = "BackupPC: Архив";
$Lang{BackupPC_Summary} = <<EOF;

\${h1(qq{$Lang{BackupPC__Server_Summary}})}
<p>
<ul>
<li>Эта страница была сгенерирована в \$now.
<li>Файловая система Пул-а сейчас составляет \$Info{DUlastValue}%
    (\$DUlastTime), сегодняшний максимум \$Info{DUDailyMax}% (\$DUmaxTime)
    однако вчера этот показатель был \$Info{DUDailyMaxPrev}%.
</ul>
</p>

\${h2("Сервера с хорошими резервными копиями")}
<p>
\$hostCntGood серверов резервировано, из них:
<ul>
<li> \$fullTot полных резервных копий общим объемом \${fullSizeTot}Гб
     (до объединения и сжатия),
<li> \$incrTot разностных резервных копий общим объемом \${incrSizeTot}Гб
     (до объединения и сжатия).
</ul>
</p>
<table class="sortable" id="host_summary_backups" border cellpadding="3" cellspacing="1">
<tr class="tableheader"><td> Сервер </td>
    <td align="center"> Пользователь </td>
    <td align="center"> #ПОЛНЫЙ </td>
    <td align="center"> Полный возраст (дней) </td>
    <td align="center"> Полный размер (Гб) </td>
    <td align="center"> Скорост (Мб/с) </td>
    <td align="center"> #РАЗН. </td>
    <td align="center"> Разност. возраст (дней) </td>
    <td align="center"> Последнее резервирование (дней) </td>
    <td align="center"> Состояние </td>
    <td align="center"> ошибки #Передачи </td>
    <td align="center"> Последняя попытка </td></tr>
\$strGood
</table>
<br><br>
\${h2("Серверов без резервной копии")}
<p>
\$hostCntNone серверов без резервной копии.
<p>
<table class="sortable" id="host_summary_nobackups" border cellpadding="3" cellspacing="1">
<tr class="tableheader"><td> Сервер </td>
    <td align="center"> Пользователь </td>
    <td align="center"> #ПОЛНЫЙ </td>
    <td align="center"> Полный возраст (дней) </td>
    <td align="center"> Полный размер (Гб) </td>
    <td align="center"> Скорост (Мб/с) </td>
    <td align="center"> #РАЗН. </td>
    <td align="center"> Разност. возраст (дней) </td>
    <td align="center"> Последнее резервирование (дней) </td>
    <td align="center"> Состояние </td>
    <td align="center"> ошибки #Передачи </td>
    <td align="center"> Последняя попытка </td></tr>
\$strNone
</table>
EOF

$Lang{BackupPC_Archive} = <<EOF;
\${h1(qq{$Lang{BackupPC__Archive}})}
<script language="javascript" type="text/javascript">
<!--

    function checkAll(location)
    {
      for (var i=0;i<document.form1.elements.length;i++)
      {
        var e = document.form1.elements[i];
        if ((e.checked || !e.checked) && e.name != \'all\') {
            if (eval("document.form1."+location+".checked")) {
                e.checked = true;
            } else {
                e.checked = false;
            }
        }
      }
    }

    function toggleThis(checkbox)
    {
       var cb = eval("document.form1."+checkbox);
       cb.checked = !cb.checked;
    }

//-->
</script>

\$hostCntGood серверов резервировано с общим объемом \${fullSizeTot}GB
<p>
<form name="form1" method="post" action="\$MyURL">
<input type="hidden" name="fcbMax" value="\$checkBoxCnt">
<input type="hidden" name="type" value="1">
<input type="hidden" name="host" value="\${EscHTML(\$archHost)}">
<input type="hidden" name="action" value="Archive">
<table class="tableStnd" border cellpadding="3" cellspacing="1">
<tr class="tableheader"><td align=center> Сервер</td>
    <td align="center"> Пользователь </td>
    <td align="center"> Размер резервной копии </td>
\$strGood
\$checkAllHosts
</table>
</form>
<p>

EOF

$Lang{BackupPC_Archive2} = <<EOF;
\${h1(qq{$Lang{BackupPC__Archive}})}
About to archive the following hosts
<ul>
\$HostListStr
</ul>
<form action="\$MyURL" method="post">
\$hiddenStr
<input type="hidden" name="action" value="Archive">
<input type="hidden" name="host" value="\${EscHTML(\$archHost)}">
<input type="hidden" name="type" value="2">
<input type="hidden" value="0" name="archive_type">
<table class="tableStnd" border cellspacing="1" cellpadding="3">
\$paramStr
<tr>
    <td colspan=2><input type="submit" value="Start the Archive" name="ignore"></td>
</tr>
</form>
</table>
EOF

$Lang{BackupPC_Archive2_location} = <<EOF;
<tr>
    <td>Archive Location/Device</td>
    <td><input type="text" value="\$ArchiveDest" name="archive_device"></td>
</tr>
EOF

$Lang{BackupPC_Archive2_compression} = <<EOF;
<tr>
    <td>Compression</td>
    <td>
    <input type="radio" value="0" name="compression" \$ArchiveCompNone>None<br>
    <input type="radio" value="1" name="compression" \$ArchiveCompGzip>gzip<br>
    <input type="radio" value="2" name="compression" \$ArchiveCompBzip2>bzip2
    </td>
</tr>
EOF

$Lang{BackupPC_Archive2_parity} = <<EOF;
<tr>
    <td>Percentage of Parity Data (0 = disable, 5 = typical)</td>
    <td><input type="numeric" value="\$ArchivePar" name="par"></td>
</tr>
EOF

$Lang{BackupPC_Archive2_split} = <<EOF;
<tr>
    <td>Split output into</td>
    <td><input type="numeric" value="\$ArchiveSplit" name="splitsize">Megabytes</td>
</tr>
EOF

# -----------------------------------
$Lang{Pool_Stat} = <<EOF;
        <li>ПУЛ \${poolSize}GB включает в себя \$info->{"\${name}FileCnt"} файлов
            и \$info->{"\${name}DirCnt"} папок (на \$poolTime),
        <li>Хэширование ПУЛ-а дает \$info->{"\${name}FileCntRep"} повторений
            файлов с наидлиннейшей цепочкой \$info->{"\${name}FileRepMax"},
        <li>Ночная уборка удалила \$info->{"\${name}FileCntRm"} файлов в
            размере \${poolRmSize}Гб (around \$poolTime),
EOF

# --------------------------------
$Lang{BackupPC__Backup_Requested_on__host} = "BackupPC: Запрос на резервирование сервера  \$host";
# --------------------------------
$Lang{REPLY_FROM_SERVER} = <<EOF;
\${h1(\$str)}
<p>
Сервер ответил: \$reply
<p>
Вернуться на <a href="\$MyURL?host=\$host">основную страницу сервера \$host</a>.
EOF
# --------------------------------
$Lang{BackupPC__Start_Backup_Confirm_on__host} = "BackupPC: Подтвердите старт резервирования сервера \$host";
# --------------------------------
$Lang{Are_you_sure_start} = <<EOF;
\${h1("Вы уверены?")}
<p>
Вы запустили \$type резервирование на сервере \$host.

<form name="Confirm" action="\$MyURL" method="get">
<input type="hidden" name="host" value="\$host">
<input type="hidden" name="hostIP" value="\$ipAddr">
<input type="hidden" name="doit" value="1">
<input type="hidden" name="action" value="">
Do you really want to do this?
<input type="button" value="\$buttonText"
  onClick="document.Confirm.action.value='\$In{action}';
           document.Confirm.submit();">
<input type="submit" value="No" name="ignore">
</form>
EOF
# --------------------------------
$Lang{BackupPC__Stop_Backup_Confirm_on__host} = "BackupPC: Stop Backup Confirm on \$host";
# --------------------------------
$Lang{Are_you_sure_stop} = <<EOF;

\${h1("Are you sure?")}

<p>
You are about to stop/dequeue backups on \$host;

<form name="Confirm" action="\$MyURL" method="get">
<input type="hidden" name="host"   value="\$host">
<input type="hidden" name="doit"   value="1">
<input type="hidden" name="action" value="">
Also, please don\'t start another backup for
<input type="text" name="backoff" size="10" value="\$backoff"> hours.
<p>
Do you really want to do this?
<input type="button" value="\$buttonText"
  onClick="document.Confirm.action.value='\$In{action}';
           document.Confirm.submit();">
<input type="submit" value="No" name="ignore">
</form>

EOF
# --------------------------------
$Lang{Only_privileged_users_can_view_queues_} = "Только привелегированые пользователи могут видеть очередь.";
# --------------------------------
$Lang{Only_privileged_users_can_archive} = "Только привелегированые пользователи могут Архивировать.";
# --------------------------------
$Lang{BackupPC__Queue_Summary} = "BackupPC: Сводная информация по очереди";
# --------------------------------
$Lang{Backup_Queue_Summary} = <<EOF;
\${h1("Сводная информация по очередям резервного копирования")}
<br><br>
\${h2("Очередь резервирования пользователя")}
<p>
Следующие задачи пользователя поставлены в очередь:
</p>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td> Сервер </td>
    <td> Время постановки задачи </td>
    <td> Пользователь </td></tr>
\$strUser
</table>
<br><br>

\${h2("Очередь фоновых задач")}
<p>
Следующие фоновые задачи находятся в очереди:
</p>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td> Сервер </td>
    <td> Время постановки задачи </td>
    <td> Пользователь </td></tr>
\$strBg
</table>
<br><br>
\${h2("Очередб команд")}
<p>
Следующие команды находятся в очереди:
</p>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td> Сервер </td>
    <td> Время запуска команды </td>
    <td> Пользователь </td>
    <td> Команда </td></tr>
\$strCmd
</table>
EOF

# --------------------------------
$Lang{Backup_PC__Log_File__file} = "BackupPC: Файл \$file";
$Lang{Log_File__file__comment} = <<EOF;
\${h1("Файл \$file \$comment")}
<p>
EOF
# --------------------------------
$Lang{Contents_of_log_file} = <<EOF;
Содержимое файла <tt>\$file</tt> было изменено \$mtimeStr \$comment
EOF

# --------------------------------
$Lang{skipped__skipped_lines} = "[ Пропущено \$skipped строк журнала ]\n";
# --------------------------------
$Lang{_pre___Can_t_open_log_file__file} = "<pre>\nНе смог открыть файл журнала \$file\n";

# --------------------------------
$Lang{BackupPC__Log_File_History} = "BackupPC: Log File History";
$Lang{Log_File_History__hdr} = <<EOF;
\${h1("Log File History \$hdr")}
<p>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td align="center"> File </td>
    <td align="center"> Size </td>
    <td align="center"> Modification time </td></tr>
\$str
</table>
EOF

# -------------------------------
$Lang{Recent_Email_Summary} = <<EOF;
\${h1("Recent Email Summary (Reverse time order)")}
<p>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td align="center"> Recipient </td>
    <td align="center"> Host </td>
    <td align="center"> Time </td>
    <td align="center"> Subject </td></tr>
\$str
</table>
EOF
 

# ------------------------------
$Lang{Browse_backup__num_for__host} = "BackupPC: Отобразить резервную копию \$num сервера \$host";

# ------------------------------
$Lang{Restore_Options_for__host} = "BackupPC: Варианты восстановления сервера \$host";
$Lang{Restore_Options_for__host2} = <<EOF;
\${h1("Варианты восстановления сервера \$host")}
<p>
Вы выбрали следующие файлы/каталоги из папки \$share, резервной копии #\$num:
<ul>
\$fileListStr
</ul>
</p><p>
У Вас три варианта для восстановления этих файлов/каталогов.
Пожалуйста выбирите одну из нажеследующих.
</p>
\${h2("Вариант 1: Парямое восстановление")}
<p>
EOF

$Lang{Restore_Options_for__host_Option1} = <<EOF;
Вы можете начать восстановление, которое восстановит эти файлы/каталоги
напрямую на <b>\$directHost</b>.
</p><p>
<b>Предупреждение:</b> Все существующие файлы/каталоги будут перезаписаны!
</p>
<form action="\$MyURL" method="post" name="direct">
<input type="hidden" name="host" value="\${EscHTML(\$host)}">
<input type="hidden" name="num" value="\$num">
<input type="hidden" name="type" value="3">
\$hiddenStr
<input type="hidden" value="\$In{action}" name="action">
<table class="tableStnd" border="0">
<tr>
    <td>Восстановить файлы на сервер</td>
    <td><!--<input type="text" size="40" value="\${EscHTML(\$host)}"
	 name="hostDest">-->
	 <select name="hostDest" onChange="document.direct.shareDest.value=''">
	 \$hostDestSel
	 </select>
	 <script language="Javascript">
	 function myOpen(URL) {
		window.open(URL,'','width=500,height=400');
	 }
	 </script>
	 <!--<a href="javascript:myOpen('\$MyURL?action=findShares&host='+document.direct.hostDest.options.value)">Search for available shares (NOT IMPLEMENTED)</a>--></td>
</tr><tr>
    <td>Восстановить файлы в папку</td>
    <td><input type="text" size="40" value="\${EscHTML(\$share)}"
	 name="shareDest"></td>
</tr><tr>
    <td>Восстановить файлы начиная с каталога<br>(относительно заданной паки)</td>
    <td valign="top"><input type="text" size="40" maxlength="256"
	value="\${EscHTML(\$pathHdr)}" name="pathHdr"></td>
</tr><tr>
    <td><input type="submit" value="Start Restore" name="ignore"></td>
</table>
</form>
EOF

$Lang{Restore_Options_for__host_Option1_disabled} = <<EOF;
Прямое восстановление было отключено для сервера \${EscHTML(\$hostDest)}.
Пожалуйста выберите другие варианты восстановления.
EOF

# ------------------------------
$Lang{Option_2__Download_Zip_archive} = <<EOF;
<p>
\${h2("Вариант 2: Скачать в виде Zip-архива")}
<p>
Вы можете скачать Zip-архив содержащий все выбранные Вами файлы/каталоги.
А затем пользуясь архиватором таким как WinZip посмотреть его содержимое или распаковать.
</p><p>
<b>Предупреждение:</b> в зависимости от того какие файлы/каталоги Вы выбрали,
данный архим может быть достаточно объемным. Операция может занять много времени
на создание и передачу архива, и Вам потребуется достаточно места на локальном диске 
что бы сохранить его.
</p>
<form action="\$MyURL" method="post">
<input type="hidden" name="host" value="\${EscHTML(\$host)}">
<input type="hidden" name="num" value="\$num">
<input type="hidden" name="type" value="2">
\$hiddenStr
<input type="hidden" value="\$In{action}" name="action">
<input type="checkbox" value="1" name="relative" checked> Make archive relative
to \${EscHTML(\$pathHdr eq "" ? "/" : \$pathHdr)}
(otherwise archive will contain full paths).
<br>
Compression (0=off, 1=fast,...,9=best)
<input type="text" size="6" value="5" name="compressLevel">
<br>
<input type="submit" value="Download Zip File" name="ignore">
</form>
EOF

# ------------------------------

$Lang{Option_2__Download_Zip_archive2} = <<EOF;
<p>
\${h2("Option 2: Download Zip archive")}
<p>
Archive::Zip is not installed so you will not be able to download a
zip archive.
Please ask your system adminstrator to install Archive::Zip from
<a href="http://www.cpan.org">www.cpan.org</a>.
</p>
EOF


# ------------------------------
$Lang{Option_3__Download_Zip_archive} = <<EOF;
\${h2("Option 3: Download Tar archive")}
<p>
You can download a Tar archive containing all the files/directories you
have selected.  You can then use a local application, such as tar or
WinZip to view or extract any of the files.
</p><p>
<b>Warning:</b> depending upon which files/directories you have selected,
this archive might be very very large.  It might take many minutes to
create and transfer the archive, and you will need enough local disk
space to store it.
</p>
<form action="\$MyURL" method="post">
<input type="hidden" name="host" value="\${EscHTML(\$host)}">
<input type="hidden" name="num" value="\$num">
<input type="hidden" name="type" value="1">
\$hiddenStr
<input type="hidden" value="\$In{action}" name="action">
<input type="checkbox" value="1" name="relative" checked> Make archive relative
to \${EscHTML(\$pathHdr eq "" ? "/" : \$pathHdr)}
(otherwise archive will contain full paths).
<br>
<input type="submit" value="Download Tar File" name="ignore">
</form>
EOF


# ------------------------------
$Lang{Restore_Confirm_on__host} = "BackupPC: Restore Confirm on \$host";

$Lang{Are_you_sure} = <<EOF;
\${h1("Are you sure?")}
<p>
You are about to start a restore directly to the machine \$In{hostDest}.
The following files will be restored to share \$In{shareDest}, from
backup number \$num:
<p>
<table class="tableStnd" border>
<tr class="tableheader"><td>Original file/dir</td><td>Will be restored to</td></tr>
\$fileListStr
</table>

<form name="RestoreForm" action="\$MyURL" method="post">
<input type="hidden" name="host" value="\${EscHTML(\$host)}">
<input type="hidden" name="hostDest" value="\${EscHTML(\$In{hostDest})}">
<input type="hidden" name="shareDest" value="\${EscHTML(\$In{shareDest})}">
<input type="hidden" name="pathHdr" value="\${EscHTML(\$In{pathHdr})}">
<input type="hidden" name="num" value="\$num">
<input type="hidden" name="type" value="4">
<input type="hidden" name="action" value="">
\$hiddenStr
Do you really want to do this?
<input type="button" value="\$Lang->{Restore}"
 onClick="document.RestoreForm.action.value='Restore';
          document.RestoreForm.submit();">
<input type="submit" value="No" name="ignore">
</form>
EOF


# --------------------------
$Lang{Restore_Requested_on__hostDest} = "BackupPC: Restore Requested on \$hostDest";
$Lang{Reply_from_server_was___reply} = <<EOF;
\${h1(\$str)}
<p>
Reply from server was: \$reply
<p>
Go back to <a href="\$MyURL?host=\$hostDest">\$hostDest home page</a>.
EOF

$Lang{BackupPC_Archive_Reply_from_server} = <<EOF;
\${h1(\$str)}
<p>
Reply from server was: \$reply
EOF


# -------------------------
$Lang{Host__host_Backup_Summary} = "BackupPC: Сводная информация по серверу \$host";

$Lang{Host__host_Backup_Summary2} = <<EOF;
\${h1("Сводная информация по серверу \$host")}
<p>
\$warnStr
<ul>
\$statusStr
</ul>
</p>
\${h2("Возможные действия")}
<p>
<form name="StartStopForm" action="\$MyURL" method="get">
<input type="hidden" name="host"   value="\$host">
<input type="hidden" name="action" value="">
\$startIncrStr
<input type="button" value="\$Lang->{Start_Full_Backup}"
 onClick="document.StartStopForm.action.value='Start_Full_Backup';
          document.StartStopForm.submit();">
<input type="button" value="\$Lang->{Stop_Dequeue_Backup}"
 onClick="document.StartStopForm.action.value='Stop_Dequeue_Backup';
          document.StartStopForm.submit();">
</form>
</p>
\${h2("Сводная информация по резервным копиям")}
<p>
Для того, что бы посмотреть или восстановить файлы из резервной копии щелкните мышью по номеру резервной копии.
</p>
<table class="tableStnd" border cellspacing="1" cellpadding="3">
<tr class="tableheader"><td align="center"> Рез.копия# </td>
    <td align="center"> Тип </td>
    <td align="center"> Наполненный </td>
    <td align="center"> Уровень </td>
    <td align="center"> Дата начала </td>
    <td align="center"> Продолжительность (мин.) </td>
    <td align="center"> Возраст (дней) </td>
    <td align="center"> Путь до рез.копии </td>
</tr>
\$str
</table>
<p>

\$restoreStr
</p>
<br><br>
\${h2("Сыодная таблица ошибок передачи")}
<br><br>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td align="center"> Рез.копия# </td>
    <td align="center"> Тип </td>
    <td align="center"> Журналы </td>
    <td align="center"> #Ошибок передачи </td>
    <td align="center"> #плохих файлов</td>
    <td align="center"> #плохих каталогов</td>
    <td align="center"> #ошибок архивации </td>
</tr>
\$errStr
</table>
<br><br>

\${h2("Сводная таблица дублирования файлов по Размеру/кол-ву")}
<p>
Существующие файлы это те, что уже находятся в резервном ПУЛ-е; новые файлы
это файлы добавленные в ПУЛ.</br>
Пустые файлы и Ошибки SMB не отражаются на числе файлов.
</p>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td colspan="2" bgcolor="#ffffff"></td>
    <td align="center" colspan="3"> ИТОГО </td>
    <td align="center" colspan="2"> Существующих файлов </td>
    <td align="center" colspan="2"> Новых файлов </td>
</tr>
<tr class="tableheader">
    <td align="center"> Рез.копия# </td>
    <td align="center"> Тип </td>
    <td align="center"> #Файлов </td>
    <td align="center"> Размер (Мб) </td>
    <td align="center"> Мб/с. </td>
    <td align="center"> #Файлов </td>
    <td align="center"> Размер (Мб) </td>
    <td align="center"> #Файлов </td>
    <td align="center"> Размер (Мб) </td>
</tr>
\$sizeStr
</table>
<br><br>

\${h2("Сводная таблицы сжатия")}
<p>
Эффективность сжатия файлов находящихся в ПУЛ-е и вновь добавленных файлов.
</p>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td colspan="3" bgcolor="#ffffff"></td>
    <td align="center" colspan="3"> Существующие фалы </td>
    <td align="center" colspan="3"> Новые файлы </td>
</tr>
<tr class="tableheader"><td align="center"> Рез.копия# </td>
    <td align="center"> Тип </td>
    <td align="center"> Уровень сжатия </td>
    <td align="center"> Размер (Мб.) </td>
    <td align="center"> Сжатый размер (Мб) </td>
    <td align="center"> Сжатие (%) </td>
    <td align="center"> Размер (Мб.) </td>
    <td align="center"> Сжатый размер (Мб) </td>
    <td align="center"> Сжатие (%) </td>
</tr>
\$compStr
</table>
<br><br>
EOF

$Lang{Host__host_Archive_Summary} = "BackupPC: Host \$host Archive Summary";
$Lang{Host__host_Archive_Summary2} = <<EOF;
\${h1("Host \$host Archive Summary")}
<p>
\$warnStr
<ul>
\$statusStr
</ul>

\${h2("User Actions")}
<p>
<form name="StartStopForm" action="\$MyURL" method="get">
<input type="hidden" name="archivehost" value="\$host">
<input type="hidden" name="host" value="\$host">
<input type="hidden" name="action" value="">
<input type="button" value="\$Lang->{Start_Archive}"
 onClick="document.StartStopForm.action.value='Start_Archive';
          document.StartStopForm.submit();">
<input type="button" value="\$Lang->{Stop_Dequeue_Archive}"
 onClick="document.StartStopForm.action.value='Stop_Dequeue_Archive';
          document.StartStopForm.submit();">
</form>

\$ArchiveStr

EOF

# -------------------------
$Lang{Error} = "BackupPC: Ошибка";
$Lang{Error____head} = <<EOF;
\${h1("Error: \$head")}
<p>\$mesg</p>
EOF

# -------------------------
$Lang{NavSectionTitle_} = "Сервер BackupPC";

# -------------------------
$Lang{Backup_browse_for__host} = <<EOF;
\${h1("Backup browse for \$host")}

<script language="javascript" type="text/javascript">
<!--

    function checkAll(location)
    {
      for (var i=0;i<document.form1.elements.length;i++)
      {
        var e = document.form1.elements[i];
        if ((e.checked || !e.checked) && e.name != \'all\') {
            if (eval("document.form1."+location+".checked")) {
            	e.checked = true;
            } else {
            	e.checked = false;
            }
        }
      }
    }
    
    function toggleThis(checkbox)
    {
       var cb = eval("document.form1."+checkbox);
       cb.checked = !cb.checked;	
    }

//-->
</script>

<form name="form0" method="post" action="\$MyURL">
<input type="hidden" name="num" value="\$num">
<input type="hidden" name="host" value="\$host">
<input type="hidden" name="share" value="\${EscHTML(\$share)}">
<input type="hidden" name="action" value="browse">
<ul>
<li> You are browsing backup #\$num, which started around \$backupTime
        (\$backupAge days ago),
\$filledBackup
<li> Enter directory: <input type="text" name="dir" size="50" maxlength="4096" value="\${EscHTML(\$dir)}"> <input type="submit" value="\$Lang->{Go}" name="Submit">
<li> Click on a directory below to navigate into that directory,
<li> Click on a file below to restore that file,
<li> You can view the backup <a href="\$MyURL?action=dirHistory&host=\${EscURI(\$host)}&share=\$shareURI&dir=\$pathURI">history</a> of the current directory.
</ul>
</form>

\${h2("Contents of \${EscHTML(\$dirDisplay)}")}
<form name="form1" method="post" action="\$MyURL">
<input type="hidden" name="num" value="\$num">
<input type="hidden" name="host" value="\$host">
<input type="hidden" name="share" value="\${EscHTML(\$share)}">
<input type="hidden" name="fcbMax" value="\$checkBoxCnt">
<input type="hidden" name="action" value="Restore">
<br>
<table width="100%">
<tr><td valign="top" width="30%">
    <table align="left" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
    \$dirStr
    </table>
</td><td width="3%">
</td><td valign="top">
    <br>
        <table border width="100%" align="left" cellpadding="3" cellspacing="1">
        \$fileHeader
        \$topCheckAll
        \$fileStr
        \$checkAll
        </table>
    </td></tr></table>
<br>
<!--
This is now in the checkAll row
<input type="submit" name="Submit" value="Restore selected files">
-->
</form>
EOF

# ------------------------------
$Lang{DirHistory_backup_for__host} = "BackupPC: Directory backup history for \$host";

#
# These two strings are used to build the links for directories and
# file versions.  Files are appended with a version number.
#
$Lang{DirHistory_dirLink}  = "dir";
$Lang{DirHistory_fileLink} = "v";

$Lang{DirHistory_for__host} = <<EOF;
\${h1("Directory backup history for \$host")}
<p>
This display shows each unique version of files across all
the backups:
<ul>
<li> Click on a backup number to return to the backup browser,
<li> Click on a directory link (\$Lang->{DirHistory_dirLink}) to navigate
     into that directory,
<li> Click on a file version link (\$Lang->{DirHistory_fileLink}0,
     \$Lang->{DirHistory_fileLink}1, ...) to download that file,
<li> Files with the same contents between different backups have the same
     version number,
<li> Files or directories not present in a particular backup have an
     empty box.
<li> Files shown with the same version might have different attributes.
     Select the backup number to see the file attributes.
</ul>

\${h2("History of \${EscHTML(\$dirDisplay)}")}

<br>
<table border cellspacing="2" cellpadding="3">
<tr class="fviewheader"><td>Backup number</td>\$backupNumStr</tr>
<tr class="fviewheader"><td>Backup time</td>\$backupTimeStr</tr>
\$fileStr
</table>
EOF

# ------------------------------
$Lang{Restore___num_details_for__host} = "BackupPC: Restore #\$num details for \$host";

$Lang{Restore___num_details_for__host2} = <<EOF;
\${h1("Restore #\$num Details for \$host")}
<p>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="90%">
<tr><td class="tableheader"> Number </td><td class="border"> \$Restores[\$i]{num} </td></tr>
<tr><td class="tableheader"> Requested by </td><td class="border"> \$RestoreReq{user} </td></tr>
<tr><td class="tableheader"> Request time </td><td class="border"> \$reqTime </td></tr>
<tr><td class="tableheader"> Result </td><td class="border"> \$Restores[\$i]{result} </td></tr>
<tr><td class="tableheader"> Error Message </td><td class="border"> \$Restores[\$i]{errorMsg} </td></tr>
<tr><td class="tableheader"> Source host </td><td class="border"> \$RestoreReq{hostSrc} </td></tr>
<tr><td class="tableheader"> Source backup num </td><td class="border"> \$RestoreReq{num} </td></tr>
<tr><td class="tableheader"> Source share </td><td class="border"> \$RestoreReq{shareSrc} </td></tr>
<tr><td class="tableheader"> Destination host </td><td class="border"> \$RestoreReq{hostDest} </td></tr>
<tr><td class="tableheader"> Destination share </td><td class="border"> \$RestoreReq{shareDest} </td></tr>
<tr><td class="tableheader"> Start time </td><td class="border"> \$startTime </td></tr>
<tr><td class="tableheader"> Duration </td><td class="border"> \$duration min </td></tr>
<tr><td class="tableheader"> Number of files </td><td class="border"> \$Restores[\$i]{nFiles} </td></tr>
<tr><td class="tableheader"> Total size </td><td class="border"> \${MB} MB </td></tr>
<tr><td class="tableheader"> Transfer rate </td><td class="border"> \$MBperSec MB/sec </td></tr>
<tr><td class="tableheader"> TarCreate errors </td><td class="border"> \$Restores[\$i]{tarCreateErrs} </td></tr>
<tr><td class="tableheader"> Xfer errors </td><td class="border"> \$Restores[\$i]{xferErrs} </td></tr>
<tr><td class="tableheader"> Xfer log file </td><td class="border">
<a href="\$MyURL?action=view&type=RestoreLOG&num=\$Restores[\$i]{num}&host=\$host">View</a>,
<a href="\$MyURL?action=view&type=RestoreErr&num=\$Restores[\$i]{num}&host=\$host">Errors</a>
</tr></tr>
</table>
</p>
\${h1("File/Directory list")}
<p>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="100%">
<tr class="tableheader"><td>Original file/dir</td><td>Restored to</td></tr>
\$fileListStr
</table>
EOF

# ------------------------------
$Lang{Archive___num_details_for__host} = "BackupPC: Archive #\$num details for \$host";

$Lang{Archive___num_details_for__host2 } = <<EOF;
\${h1("Archive #\$num Details for \$host")}
<p>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr><td class="tableheader"> Number </td><td class="border"> \$Archives[\$i]{num} </td></tr>
<tr><td class="tableheader"> Requested by </td><td class="border"> \$ArchiveReq{user} </td></tr>
<tr><td class="tableheader"> Request time </td><td class="border"> \$reqTime </td></tr>
<tr><td class="tableheader"> Result </td><td class="border"> \$Archives[\$i]{result} </td></tr>
<tr><td class="tableheader"> Error Message </td><td class="border"> \$Archives[\$i]{errorMsg} </td></tr>
<tr><td class="tableheader"> Start time </td><td class="border"> \$startTime </td></tr>
<tr><td class="tableheader"> Duration </td><td class="border"> \$duration min </td></tr>
<tr><td class="tableheader"> Xfer log file </td><td class="border">
<a href="\$MyURL?action=view&type=ArchiveLOG&num=\$Archives[\$i]{num}&host=\$host">View</a>,
<a href="\$MyURL?action=view&type=ArchiveErr&num=\$Archives[\$i]{num}&host=\$host">Errors</a>
</tr></tr>
</table>
<p>
\${h1("Host list")}
<p>
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td>Host</td><td>Backup Number</td></tr>
\$HostListStr
</table>
EOF

# -----------------------------------
$Lang{Email_Summary} = "BackupPC: Email Summary";

# -----------------------------------
#  !! ERROR messages !!
# -----------------------------------
$Lang{BackupPC__Lib__new_failed__check_apache_error_log} = "BackupPC::Lib->new failed: check apache error_log\n";
$Lang{Wrong_user__my_userid_is___} =  
              "Wrong user: my userid is \$>, instead of \$uid"
            . "(\$Conf{BackupPCUser})\n";
# $Lang{Only_privileged_users_can_view_PC_summaries} = "Only privileged users can view PC summaries.";
$Lang{Only_privileged_users_can_stop_or_start_backups} = 
                  "Only privileged users can stop or start backups on"
		. " \${EscHTML(\$host)}.";
$Lang{Invalid_number__num} = "Invalid number \$num";
$Lang{Unable_to_open__file__configuration_problem} = "Unable to open \$file: configuration problem?";
$Lang{Only_privileged_users_can_view_log_or_config_files} = "Only privileged users can view log or config files.";
$Lang{Only_privileged_users_can_view_log_files} = "Only privileged users can view log files.";
$Lang{Only_privileged_users_can_view_email_summaries} = "Only privileged users can view email summaries.";
$Lang{Only_privileged_users_can_browse_backup_files} = "Only privileged users can browse backup files"
                . " for host \${EscHTML(\$In{host})}.";
$Lang{Empty_host_name} = "Empty host name.";
$Lang{Directory___EscHTML} = "Directory \${EscHTML(\"\$TopDir/pc/\$host/\$num\")}"
		    . " is empty";
$Lang{Can_t_browse_bad_directory_name2} = "Can\'t browse bad directory name"
	            . " \${EscHTML(\$relDir)}";
$Lang{Only_privileged_users_can_restore_backup_files} = "Only privileged users can restore backup files"
                . " for host \${EscHTML(\$In{host})}.";
$Lang{Bad_host_name} = "Bad host name \${EscHTML(\$host)}";
$Lang{You_haven_t_selected_any_files__please_go_Back_to} = "You haven\'t selected any files; please go Back to"
                . " select some files.";
$Lang{You_haven_t_selected_any_hosts} = "You haven\'t selected any hosts; please go Back to"
                . " select some hosts.";
$Lang{Nice_try__but_you_can_t_put} = "Nice try, but you can\'t put \'..\' in any of the file names";
$Lang{Host__doesn_t_exist} = "Host \${EscHTML(\$In{hostDest})} doesn\'t exist";
$Lang{You_don_t_have_permission_to_restore_onto_host} = "You don\'t have permission to restore onto host"
		    . " \${EscHTML(\$In{hostDest})}";
$Lang{Can_t_open_create__openPath} = "Can\'t open/create "
		. "\${EscHTML(\"\$openPath\")}";
$Lang{Only_privileged_users_can_restore_backup_files2} = "Only privileged users can restore backup files"
                . " for host \${EscHTML(\$host)}.";
$Lang{Empty_host_name} = "Empty host name";
$Lang{Unknown_host_or_user} = "Unknown host or user \${EscHTML(\$host)}";
$Lang{Only_privileged_users_can_view_information_about} = "Only privileged users can view information about"
                . " host \${EscHTML(\$host)}." ;
$Lang{Only_privileged_users_can_view_archive_information} = "Only privileged users can view archive information.";
$Lang{Only_privileged_users_can_view_restore_information} = "Only privileged users can view restore information.";
$Lang{Restore_number__num_for_host__does_not_exist} = "Restore number \$num for host \${EscHTML(\$host)} does"
	        . " not exist.";
$Lang{Archive_number__num_for_host__does_not_exist} = "Archive number \$num for host \${EscHTML(\$host)} does"
                . " not exist.";
$Lang{Can_t_find_IP_address_for} = "Can\'t find IP address for \${EscHTML(\$host)}";
$Lang{host_is_a_DHCP_host} = <<EOF;
\$host is a DHCP host, and I don\'t know its IP address.  I checked the
netbios name of \$ENV{REMOTE_ADDR}\$tryIP, and found that that machine
is not \$host.
<p>
Until I see \$host at a particular DHCP address, you can only
start this request from the client machine itself.
EOF

# ------------------------------------
# !! Server Mesg !!
# ------------------------------------

$Lang{Backup_requested_on_DHCP__host} = "Backup requested on DHCP \$host (\$In{hostIP}) by"
		                      . " \$User from \$ENV{REMOTE_ADDR}";
$Lang{Backup_requested_on__host_by__User} = "Backup requested on \$host by \$User";
$Lang{Backup_stopped_dequeued_on__host_by__User} = "Backup stopped/dequeued on \$host by \$User";
$Lang{Restore_requested_to_host__hostDest__backup___num} = "Restore requested to host \$hostDest, backup #\$num,"
	     . " by \$User from \$ENV{REMOTE_ADDR}";
$Lang{Archive_requested} = "Archive requested by \$User from \$ENV{REMOTE_ADDR}";

# -------------------------------------------------
# ------- Stuff that was forgotten ----------------
# -------------------------------------------------

$Lang{Status} = "Ссостояние сервера BackupPC";
$Lang{PC_Summary} = "Сводная информация";
$Lang{LOG_file} = "Файл Журнала";
$Lang{LOG_files} = "файлЫ Журналов";
$Lang{Old_LOGs} = "Старые Журналы";
$Lang{Email_summary} = "Сводка последних Email";
$Lang{Config_file} = "Конфигурационный файл";
# $Lang{Hosts_file} = "Hosts file";
$Lang{Current_queues} = "Текущие очереди";
$Lang{Documentation} = "Документация";

#$Lang{Host_or_User_name} = "<small>Host or User name:</small>";
$Lang{Go} = "Вреред";
$Lang{Hosts} = "Сервера";
$Lang{Select_a_host} = "Выберите сервер...";

$Lang{There_have_been_no_archives} = "<h2> Архивация не проводилась </h2>\n";
$Lang{This_PC_has_never_been_backed_up} = "<h2> Данный сервер не резервировался ни разу!! </h2>\n";
$Lang{This_PC_is_used_by} = "<li>Данный сервер администрируется \${UserLink(\$user)}";

$Lang{Extracting_only_Errors} = "(Extracting only Errors)";
$Lang{XferLOG} = "XferLOG";
$Lang{Errors}  = "Ошибки";

# ------------
$Lang{Last_email_sent_to__was_at___subject} = <<EOF;
<li>Последнее электронное письмо послано \${UserLink(\$user)} \$mailTime. Тема письма "\$subj".
EOF
# ------------
$Lang{The_command_cmd_is_currently_running_for_started} = <<EOF;
<li>The command \$cmd is currently running for \$host, started \$startTime.
EOF

# -----------
$Lang{Host_host_is_queued_on_the_background_queue_will_be_backed_up_soon} = <<EOF;
<li>Host \$host is queued on the background queue (will be backed up soon).
EOF

# ----------
$Lang{Host_host_is_queued_on_the_user_queue__will_be_backed_up_soon} = <<EOF;
<li>Host \$host is queued on the user queue (will be backed up soon).
EOF

# ---------
$Lang{A_command_for_host_is_on_the_command_queue_will_run_soon} = <<EOF;
<li>A command for \$host is on the command queue (will run soon).
EOF

# --------
$Lang{Last_status_is_state_StatusHost_state_reason_as_of_startTime} = <<EOF;
<li>Последнее состояние <font color="red"><b>\"\$Lang->{\$StatusHost{state}}\"\$reason</b></font> на момент \$startTime.
EOF

# --------
$Lang{Last_error_is____EscHTML_StatusHost_error} = <<EOF;
<li>Последняя ошибка \"\${EscHTML(\$StatusHost{error})}\".
EOF

# ------
$Lang{Pings_to_host_have_failed_StatusHost_deadCnt__consecutive_times} = <<EOF;
<li>Отклик командой ping от сервера \$host не был получен \$StatusHost{deadCnt} раз подряд.
EOF

# -----
$Lang{Prior_to_that__pings} = "До этого, отклики по команде ping";

# -----
$Lang{priorStr_to_host_have_succeeded_StatusHostaliveCnt_consecutive_times} = <<EOF;
<li>\$priorStr до \$host успешно получены \$StatusHost{aliveCnt} раз подряд.
EOF

$Lang{Because__host_has_been_on_the_network_at_least__Conf_BlackoutGoodCnt_consecutive_times___} = <<EOF;
<li>Т.к. сервер \$host был доступен по сети как минимум \$Conf{BlackoutGoodCnt}
раз подряд, он НЕ будет резервироваться \$blackoutStr.
EOF

$Lang{__time0_to__time1_on__days} = "с \$t0 по \$t1 в \$days";

$Lang{Backups_are_deferred_for_hours_hours_change_this_number} = <<EOF;
<li>Backups are deferred for \$hours hours
(<a href=\"\$MyURL?action=Stop_Dequeue_Backup&host=\$host\">change this number</a>).
EOF

$Lang{tryIP} = " and \$StatusHost{dhcpHostIP}";

# $Lang{Host_Inhost} = "Host \$In{host}";

$Lang{checkAll} = <<EOF;
<tr><td class="fviewborder">
<input type="checkbox" name="allFiles" onClick="return checkAll('allFiles');">&nbsp;Select all
</td><td colspan="5" align="center" class="fviewborder">
<input type="submit" name="Submit" value="Restore selected files">
</td></tr>
EOF

$Lang{checkAllHosts} = <<EOF;
<tr><td class="fviewborder">
<input type="checkbox" name="allFiles" onClick="return checkAll('allFiles');">&nbsp;Select all
</td><td colspan="2" align="center" class="fviewborder">
<input type="submit" name="Submit" value="Archive selected hosts">
</td></tr>
EOF

$Lang{fileHeader} = <<EOF;
    <tr class="fviewheader"><td align=center> Name</td>
       <td align="center"> Type</td>
       <td align="center"> Mode</td>
       <td align="center"> #</td>
       <td align="center"> Size</td>
       <td align="center"> Date modified</td>
    </tr>
EOF

$Lang{Home} = "Home";
$Lang{Browse} = "Browse backups";
$Lang{Last_bad_XferLOG} = "Last bad XferLOG";
$Lang{Last_bad_XferLOG_errors_only} = "Last bad XferLOG (errors&nbsp;only)";

$Lang{This_display_is_merged_with_backup} = <<EOF;
<li> This display is merged with backup #\$numF.
EOF

$Lang{Visit_this_directory_in_backup} = <<EOF;
<li> Select the backup you wish to view: <select onChange="window.location=this.value">\$otherDirs </select>
EOF

$Lang{Restore_Summary} = <<EOF;
\${h2("Restore Summary")}
<p>
Click on the restore number for more details.
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td align="center"> Restore# </td>
    <td align="center"> Result </td>
    <td align="right"> Start Date</td>
    <td align="right"> Dur/mins</td>
    <td align="right"> #files </td>
    <td align="right"> MB </td>
    <td align="right"> #tar errs </td>
    <td align="right"> #xferErrs </td>
</tr>
\$restoreStr
</table>
<p>
EOF

$Lang{Archive_Summary} = <<EOF;
\${h2("Archive Summary")}
<p>
Click on the archive number for more details.
<table class="tableStnd" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td align="center"> Archive# </td>
    <td align="center"> Result </td>
    <td align="right"> Start Date</td>
    <td align="right"> Dur/mins</td>
</tr>
\$ArchiveStr
</table>
<p>
EOF

$Lang{BackupPC__Documentation} = "BackupPC: Документация";

$Lang{No} = "Да";
$Lang{Yes} = "Нет";

$Lang{The_directory_is_empty} = <<EOF;
<tr><td bgcolor="#ffffff">The directory \${EscHTML(\$dirDisplay)} is empty
</td></tr>
EOF

#$Lang{on} = "on";
$Lang{off} = "Выкл.";

$Lang{backupType_full}    = "Полный";
$Lang{backupType_incr}    = "Разностный";
$Lang{backupType_partial} = "Частичный";

$Lang{failed} = "не смогла";
$Lang{success} = "успешно";
$Lang{and} = "и";

# ------
# Hosts states and reasons
$Lang{Status_idle} = "бездействует";
$Lang{Status_backup_starting} = "начинается резервирование";
$Lang{Status_backup_in_progress} = "резервирование в процессе";
$Lang{Status_restore_starting} = "начинается восстановление";
$Lang{Status_restore_in_progress} = "восстановление в процессе";
$Lang{Status_link_pending} = "link pending";
$Lang{Status_link_running} = "link running";

$Lang{Reason_backup_done}    = "сделано";
$Lang{Reason_restore_done}   = "восстановление завершено";
$Lang{Reason_archive_done}   = "архивация завершена";
$Lang{Reason_nothing_to_do}  = "бездействует";
$Lang{Reason_backup_failed}  = "резервирование не удалось";
$Lang{Reason_restore_failed} = "восстановление не удалось";
$Lang{Reason_archive_failed} = "архивация не удалась";
$Lang{Reason_no_ping}        = "сервер не отвечает на ping";
$Lang{Reason_backup_canceled_by_user}  = "резервирование отменено пользователем";
$Lang{Reason_restore_canceled_by_user} = "восстановление отменено пользователем";
$Lang{Reason_archive_canceled_by_user} = "архивация отменена пользователем";
$Lang{Disabled_OnlyManualBackups}  = "автоматика выключена";  
$Lang{Disabled_AllBackupsDisabled} = "отключено";                  


# ---------
# Email messages

# No backup ever
$Lang{EMailNoBackupEverSubj} = "BackupPC: no backups of \$host have succeeded";
$Lang{EMailNoBackupEverMesg} = <<'EOF';
To: $user$domain
cc:
Subject: $subj
$headers
Dear $userName,

Your PC ($host) has never been successfully backed up by our
PC backup software.  PC backups should occur automatically
when your PC is connected to the network.  You should contact
computer support if:

  - Your PC has been regularly connected to the network, meaning
    there is some configuration or setup problem preventing
    backups from occurring.

  - You don't want your PC backed up and you want these email
    messages to stop.

Otherwise, please make sure your PC is connected to the network
next time you are in the office.

Regards,
BackupPC Genie
http://backuppc.sourceforge.net
EOF

# No recent backup
$Lang{EMailNoBackupRecentSubj} = "BackupPC: no recent backups on \$host";
$Lang{EMailNoBackupRecentMesg} = <<'EOF';
To: $user$domain
cc:
Subject: $subj
$headers
Dear $userName,

Your PC ($host) has not been successfully backed up for $days days.
Your PC has been correctly backed up $numBackups times from $firstTime to $days days
ago.  PC backups should occur automatically when your PC is connected
to the network.

If your PC has been connected for more than a few hours to the
network during the last $days days you should contact IS to find
out why backups are not working.

Otherwise, if you are out of the office, there's not much you can
do, other than manually copying especially critical files to other
media.  You should be aware that any files you have created or
changed in the last $days days (including all new email and
attachments) cannot be restored if your PC disk crashes.

Regards,
BackupPC Genie
http://backuppc.sourceforge.net
EOF

# Old Outlook files
$Lang{EMailOutlookBackupSubj} = "BackupPC: Outlook files on \$host need to be backed up";
$Lang{EMailOutlookBackupMesg} = <<'EOF';
To: $user$domain
cc:
Subject: $subj
$headers
Dear $userName,

The Outlook files on your PC have $howLong.
These files contain all your email, attachments, contact and calendar           
information.  Your PC has been correctly backed up $numBackups times from
$firstTime to $lastTime days ago.  However, Outlook locks all its files when
it is running, preventing these files from being backed up.

It is recommended you backup the Outlook files when you are connected
to the network by exiting Outlook and all other applications, and,
using just your browser, go to this link:

    $CgiURL?host=$host               

Select "Start Incr Backup" twice to start a new incremental backup.
You can select "Return to $host page" and then hit "reload" to check
the status of the backup.  It should take just a few minutes to
complete.

Regards,
BackupPC Genie
http://backuppc.sourceforge.net
EOF

$Lang{howLong_not_been_backed_up} = "not been backed up successfully";
$Lang{howLong_not_been_backed_up_for_days_days} = "not been backed up for \$days days";

#######################################################################
# RSS strings
#######################################################################
$Lang{RSS_Doc_Title}       = "BackupPC Server";
$Lang{RSS_Doc_Description} = "RSS feed for BackupPC";
$Lang{RSS_Host_Summary}    = <<EOF;
Full Count: \$fullCnt;
Full Age/days: \$fullAge;
Full Size/GB: \$fullSize;
Speed MB/sec: \$fullRate;
Incr Count: \$incrCnt;
Incr Age/Days: \$incrAge;
State: \$host_state;
Last Attempt: \$host_last_attempt;
EOF

#######################################################################
# Configuration editor strings
#######################################################################

$Lang{Only_privileged_users_can_edit_config_files} = "Only privileged users can edit configuation settings.";
$Lang{CfgEdit_Edit_Config} = "Редактировать конфиг";
$Lang{CfgEdit_Edit_Hosts}  = "Редактировать Список Серверов";

$Lang{CfgEdit_Title_Server} = "Сервер";
$Lang{CfgEdit_Title_General_Parameters} = "Основные Параметры";
$Lang{CfgEdit_Title_Wakeup_Schedule} = "Wakeup Schedule";
$Lang{CfgEdit_Title_Concurrent_Jobs} = "Паралельные Работы";
$Lang{CfgEdit_Title_Pool_Filesystem_Limits} = "Ограничения файловой системы ПУЛ-а";
$Lang{CfgEdit_Title_Other_Parameters} = "Другие Параметры";
$Lang{CfgEdit_Title_Remote_Apache_Settings} = "Настройки Apache";
$Lang{CfgEdit_Title_Program_Paths} = "Пути программ";
$Lang{CfgEdit_Title_Install_Paths} = "Пути инсталляции";
$Lang{CfgEdit_Title_Email} = "Email";
$Lang{CfgEdit_Title_Email_settings} = "Настройки Email";
$Lang{CfgEdit_Title_Email_User_Messages} = "Email сообщения пользователя";
$Lang{CfgEdit_Title_CGI} = "CGI";
$Lang{CfgEdit_Title_Admin_Privileges} = "Административные привелегии";
$Lang{CfgEdit_Title_Page_Rendering} = "Рендеринг страницы";
$Lang{CfgEdit_Title_Paths} = "Пути";
$Lang{CfgEdit_Title_User_URLs} = " URL-ы пользователя";
$Lang{CfgEdit_Title_User_Config_Editing} = "Редактирование конфигурации пользователя";
$Lang{CfgEdit_Title_Xfer} = "Xfer";
$Lang{CfgEdit_Title_Xfer_Settings} = "Xfer Settings";
$Lang{CfgEdit_Title_Ftp_Settings} = "FTP Settings";
$Lang{CfgEdit_Title_Smb_Settings} = "Smb Settings";
$Lang{CfgEdit_Title_Tar_Settings} = "Tar Settings";
$Lang{CfgEdit_Title_Rsync_Settings} = "Rsync Settings";
$Lang{CfgEdit_Title_Rsyncd_Settings} = "Rsyncd Settings";
$Lang{CfgEdit_Title_Archive_Settings} = "Archive Settings";
$Lang{CfgEdit_Title_Include_Exclude} = "Include/Exclude";
$Lang{CfgEdit_Title_Smb_Paths_Commands} = "Smb Paths/Commands";
$Lang{CfgEdit_Title_Tar_Paths_Commands} = "Tar Paths/Commands";
$Lang{CfgEdit_Title_Rsync_Paths_Commands_Args} = "Rsync Paths/Commands/Args";
$Lang{CfgEdit_Title_Rsyncd_Port_Args} = "Rsyncd Port/Args";
$Lang{CfgEdit_Title_Archive_Paths_Commands} = "Archive Paths/Commands";
$Lang{CfgEdit_Title_Schedule} = "Задания";
$Lang{CfgEdit_Title_Full_Backups} = "Полные резервные копии";
$Lang{CfgEdit_Title_Incremental_Backups} = "Разностные резервные копии";
$Lang{CfgEdit_Title_Blackouts} = "Не рабочее время";
$Lang{CfgEdit_Title_Other} = "Прочее";
$Lang{CfgEdit_Title_Backup_Settings} = "Настройки резервирования";
$Lang{CfgEdit_Title_Client_Lookup} = "Client Lookup";
$Lang{CfgEdit_Title_Other} = "Прочее";
$Lang{CfgEdit_Title_User_Commands} = "Пользовательские команды";
$Lang{CfgEdit_Title_Hosts} = "Сервера";

$Lang{CfgEdit_Hosts_Comment} = <<EOF;
Для добавления нового сервера, нажмите кнопку Добавить и затем введите
имя сервера. Для копирования одной конфигурации сервера на другую 
введите в поле имя сервера ИМЯ.НОВОГО.СЕРВЕРА=ИМЯ.КОПИРУЕМОГО.СЕРВЕРА.
Эта процедура перепишет весю конфигурацию для сервера ИМЯ.НОВОГО.СЕРВЕРА
даже если данная конфигурация еже была.
Для удаления сервера нажмите на кнопку Удалить.
Все операции (удаления, добавления, копирования) не меняют конфигурацию
до тех пор пока не будет нажата кнопка Сохранить.
Ни какой файл конфигурации не удаляется ели вы нажмете на кнопку Удалить.
Так что если Вы нечаянно удалили конфигурацию сервера - просто добавьте его
снова.
Для полного удаления конфигурации Вам необходимо удалить файлы вручную
из папки  \$topDir/pc/ИМЯ.СЕРВЕРА
EOF

$Lang{CfgEdit_Header_Main} = <<EOF;
\${h1("Редактор основной конфигурации")}
EOF

$Lang{CfgEdit_Header_Host} = <<EOF;
\${h1("Редактор конфигурации сервера \$host")}
<p>
Заметка: Отметьте галочкой Изменено, если Вы хотите внести изменения в параметр только в конфигурации для данного сервера.
<p>
EOF

$Lang{CfgEdit_Button_Save}     = "Сохранить";
$Lang{CfgEdit_Button_Insert}   = "Вставить";
$Lang{CfgEdit_Button_Delete}   = "Удалить";
$Lang{CfgEdit_Button_Add}      = "Добавить";
$Lang{CfgEdit_Button_Override} = "Изменено";
$Lang{CfgEdit_Button_New_Key}  = "Новый параметр";

$Lang{CfgEdit_Error_No_Save}
            = "Ошибка: Не сохранено из-за ошиб(ок)ки";
$Lang{CfgEdit_Error__must_be_an_integer}
            = "Ошибка: переменная \$var должна быть целым";
$Lang{CfgEdit_Error__must_be_real_valued_number}
            = "Ошибка: переменная \$var должна быть вещественная";
$Lang{CfgEdit_Error__entry__must_be_an_integer}
            = "Ошибка: переменная \$var входящая в \$k должна быть целым";
$Lang{CfgEdit_Error__entry__must_be_real_valued_number}
            = "Ошибка: переменная \$var входящая в \$k должна быть вещественным числом";
$Lang{CfgEdit_Error__must_be_executable_program}
            = "Ошибка: переменная \$var должна бысодержать реальный путь";
$Lang{CfgEdit_Error__must_be_valid_option}
            = "Ошибка: переменная \$var должна содержать допустимый вариант";
$Lang{CfgEdit_Error_Copy_host_does_not_exist}
            = "Копируемая конфигурация сервера \$copyHost не найдена; создана конфигурацияс именем сервера \$fullHost.  Удалите этоу конфигурация если это не то, чего Вы хотели.";

$Lang{CfgEdit_Log_Copy_host_config}
            = "Пользователь \$User сделал копию конфигурации сервера \$fromHost на конфигурацию сервера \$host\n";
$Lang{CfgEdit_Log_Delete_param}
            = "Пользователь \$User удалил \$p из \$conf\n";
$Lang{CfgEdit_Log_Add_param_value}
            = "Пользователь \$User добавил \$p в \$conf, установив в \$value\n";
$Lang{CfgEdit_Log_Change_param_value}
            = "\$User changed \$p in \$conf to \$valueNew from \$valueOld\n";
$Lang{CfgEdit_Log_Host_Delete}
            = "\$User deleted host \$host\n";
$Lang{CfgEdit_Log_Host_Change}
            = "\$User host \$host changed \$key from \$valueOld to \$valueNew\n";
$Lang{CfgEdit_Log_Host_Add}
            = "\$User added host \$host: \$value\n";
  
#end of ru.pm
