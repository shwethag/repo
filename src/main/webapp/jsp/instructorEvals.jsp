<%@ page import="teammates.common.util.Const"%>
<%@ page import="teammates.common.util.TimeHelper"%>
<%@ page import="teammates.common.datatransfer.CourseAttributes"%>
<%@ page import="teammates.common.datatransfer.EvaluationAttributes"%>
<%@ page import="teammates.common.datatransfer.EvaluationDetailsBundle"%>
<%@ page import="teammates.common.datatransfer.EvaluationStats"%>
<%@ page import="teammates.common.util.FieldValidator"%>
<%@ page import="teammates.ui.controller.InstructorEvalPageData"%>
<%
	InstructorEvalPageData data = (InstructorEvalPageData)request.getAttribute("data");
%>
<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" href="/favicon.png">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Teammates - Instructor</title>
	<link rel="stylesheet" href="/stylesheets/common.css" type="text/css" media="screen">
	<link rel="stylesheet" href="/stylesheets/instructorEval.css" type="text/css" media="screen">
	<link rel="stylesheet" href="/stylesheets/common-print.css" type="text/css" media="print">
    <link rel="stylesheet" href="/stylesheets/instructorEval-print.css" type="text/css" media="print">
	
	<script type="text/javascript" src="/js/googleAnalytics.js"></script>
	<script type="text/javascript" src="/js/jquery-minified.js"></script>
	<script type="text/javascript" src="/js/tooltip.js"></script>
	<script type="text/javascript" src="/js/date.js"></script>
	<script type="text/javascript" src="/js/CalendarPopup.js"></script>
	<script type="text/javascript" src="/js/AnchorPosition.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	
	<script type="text/javascript" src="/js/instructor.js"></script>
	<script type="text/javascript" src="/js/instructorEval.js"></script>
	<%
		if(data.newEvaluationToBeCreated==null){
	%>
	<script type="text/javascript">
		var doPageSpecificOnload = selectDefaultTimeOptions;
	</script>
	<%
		}
	%>
    <jsp:include page="../enableJS.jsp"></jsp:include>
</head>

<body>
	<div id="dhtmltooltip"></div>
	<div id="frameTop">
		<jsp:include page="<%=Const.ViewURIs.INSTRUCTOR_HEADER%>" />
	</div>

	<div id="frameBody">
		<div id="frameBodyWrapper">
			<div id="topOfPage"></div>
			<div id="headerOperation">
				<h1>Add New Evaluation</h1>
			</div>
			
			<p class="bold centeralign middlealign"><span style="padding-right: 10px">Session Type</span>
			<select style="width: 730px" name="feedbackchangetype"
									id="feedbackchangetype"
									onmouseover="ddrivetip('Select a different type of session here.')"
									onmouseout="hideddrivetip()" tabindex="0">
									<option value="<%=Const.ActionURIs.INSTRUCTOR_FEEDBACKS_PAGE%>">Class Feedback Session with customizable questions</option>
									<!-- <option value="TEAM">Team Feedback Session</option> -->
									<!-- <option value="PRIVATE">Private Feedback Session</option> -->
									<option value="<%=Const.ActionURIs.INSTRUCTOR_EVALS_PAGE%>" selected="selected">Standard Peer Evaluation Session</option>			
			</select></p>
			<br><br>
			<form method="post" action="<%=Const.ActionURIs.INSTRUCTOR_EVAL_ADD%>" name="form_addevaluation">
				<table class="inputTable" id="instructorEvaluationManagement">
					<tr>
						<td class="label bold" >Course ID:</td>
						<td><select name="<%=Const.ParamsNames.COURSE_ID%>"
									id="<%=Const.ParamsNames.COURSE_ID%>"
									onmouseover="ddrivetip('<%=Const.Tooltips.EVALUATION_INPUT_COURSE%>')"
									onmouseout="hideddrivetip()" tabindex="1">
										<%
											for(String opt: data.getCourseIdOptions()) out.println(opt);
										%>
							</select></td>
						<td class="label bold" >Opening time:</td>
						<td><input style="width: 100px;" type="text"
									name="<%=Const.ParamsNames.EVALUATION_START%>"
									id="<%=Const.ParamsNames.EVALUATION_START%>" 
									onclick ="cal.select(this,'<%=Const.ParamsNames.EVALUATION_START%>','dd/MM/yyyy')"
									onmouseover="ddrivetip('<%=Const.Tooltips.EVALUATION_INPUT_START%>')"
									onmouseout="hideddrivetip()"
									value="<%=(data.newEvaluationToBeCreated==null? TimeHelper.formatDate(TimeHelper.getNextHour()) : TimeHelper.formatDate(data.newEvaluationToBeCreated.startTime))%>"
									readonly="readonly" tabindex="3">
									@
							<select style="width: 70px;"
									name="<%=Const.ParamsNames.EVALUATION_STARTTIME%>"
									id="<%=Const.ParamsNames.EVALUATION_STARTTIME%>"
									tabindex="4">
										<%
											for(String opt: data.getTimeOptionsAsHtml(true)) out.println(opt);
										%>
							</select></td>
					</tr>
					<tr>
						<td class="label bold" >Evaluation name:</td>
						<td><input  type="text"
									name="<%=Const.ParamsNames.EVALUATION_NAME%>" id="<%=Const.ParamsNames.EVALUATION_NAME%>"
									onmouseover="ddrivetip('<%=Const.Tooltips.EVALUATION_INPUT_NAME%>')"
									onmouseout="hideddrivetip()" maxlength =<%=FieldValidator.EVALUATION_NAME_MAX_LENGTH%>
									value="<%if(data.newEvaluationToBeCreated!=null) out.print(InstructorEvalPageData.sanitizeForHtml(data.newEvaluationToBeCreated.name));%>"
									tabindex="2" placeholder="e.g. Midterm Evaluation"></td>
						<td class="label bold" >Closing time:</td>
						<td><input style="width: 100px;" type="text"
									name="<%=Const.ParamsNames.EVALUATION_DEADLINE%>" id="<%=Const.ParamsNames.EVALUATION_DEADLINE%>"
									onclick ="cal.select(this,'<%=Const.ParamsNames.EVALUATION_DEADLINE%>','dd/MM/yyyy')"
									onmouseover="ddrivetip('<%=Const.Tooltips.EVALUATION_INPUT_DEADLINE%>')"
									onmouseout="hideddrivetip()"
									value="<%=(data.newEvaluationToBeCreated==null? "" : TimeHelper.formatDate(data.newEvaluationToBeCreated.endTime))%>"
									readonly="readonly" tabindex="5">
									@
							<select style="width: 70px;"
									name="<%=Const.ParamsNames.EVALUATION_DEADLINETIME%>"
									id="<%=Const.ParamsNames.EVALUATION_DEADLINETIME%>"
									tabindex="6">
										<%
											for(String opt: data.getTimeOptionsAsHtml(false)) out.println(opt);
										%>
							</select></td>
					</tr>
					<tr>
						<td class="label bold">Peer feedback:</td>
						<td><input type="radio" name="<%=Const.ParamsNames.EVALUATION_COMMENTSENABLED%>"
									id="commentsstatus_enabled" value="true"
									<%if(data.newEvaluationToBeCreated==null || data.newEvaluationToBeCreated.p2pEnabled) out.print("checked=\"checked\"");%>
									onmouseover="ddrivetip('<%=Const.Tooltips.EVALUATION_INPUT_COMMENTSSTATUS%>')"
									onmouseout="hideddrivetip()">
							<label for="commentsstatus_enabled">Enabled</label>
							<input type="radio" name="<%=Const.ParamsNames.EVALUATION_COMMENTSENABLED%>"
									id="commentsstatus_disabled" value="false"
									<%if(data.newEvaluationToBeCreated!=null && !data.newEvaluationToBeCreated.p2pEnabled) out.print("checked=\"checked\"");%>
									onmouseover="ddrivetip('<%=Const.Tooltips.EVALUATION_INPUT_COMMENTSSTATUS%>')"
									onmouseout="hideddrivetip()">
							<label for="commentsstatus_disabled">Disabled</label>
						</td>
						<td class="label bold" >Time zone:</td>
						<td><select style="width: 100px;" name="<%=Const.ParamsNames.EVALUATION_TIMEZONE%>" id="<%=Const.ParamsNames.EVALUATION_TIMEZONE%>"
									onmouseover="ddrivetip('<%=Const.Tooltips.EVALUATION_INPUT_TIMEZONE%>')"
									onmouseout="hideddrivetip()" tabindex="7">
										<%
											for(String opt: data.getTimeZoneOptionsAsHtml()) out.println(opt);
										%>
							</select>
						</td>
					</tr>
					<tr>
					<td></td>
					<td></td>
					<td class="label bold" >Grace Period:</td>
					<td class="inputField">
						<select style="width: 70px;" name="<%=Const.ParamsNames.EVALUATION_GRACEPERIOD%>"
								id="<%=Const.ParamsNames.EVALUATION_GRACEPERIOD%>"
								onmouseover="ddrivetip('<%=Const.Tooltips.EVALUATION_INPUT_GRACEPERIOD%>')"
								onmouseout="hideddrivetip()" tabindex="7">
									<%
										for(String opt: data.getGracePeriodOptionsAsHtml()) out.println(opt);
									%>
						</select></td>
					</tr>
					<tr>
						<td class="label bold middlealign" >Instructions to students:</td>
						<td colspan="3">
						<table><tr><td>
							<%
								if(data.newEvaluationToBeCreated==null){
							%>
								<textarea rows="3" cols="90" class="textvalue" name="<%=Const.ParamsNames.EVALUATION_INSTRUCTIONS%>" id="<%=Const.ParamsNames.EVALUATION_INSTRUCTIONS%>"
										onmouseover="ddrivetip('<%=Const.Tooltips.EVALUATION_INPUT_INSTRUCTIONS%>')"
										onmouseout="hideddrivetip()" tabindex="8">Please submit your peer evaluation based on the overall contribution of your teammates so far.</textarea>
							<%
								} else {
							%>
								<textarea rows="3" cols="90" class="textvalue" name="<%=Const.ParamsNames.EVALUATION_INSTRUCTIONS%>" id="<%=Const.ParamsNames.EVALUATION_INSTRUCTIONS%>"
										onmouseover="ddrivetip('<%=Const.Tooltips.EVALUATION_INPUT_INSTRUCTIONS%>')"
										onmouseout="hideddrivetip()" tabindex="8"><%=InstructorEvalPageData.sanitizeForHtml(data.newEvaluationToBeCreated.instructions)%></textarea>
							<%
								}
							%>
							<p align=right><font color=grey>[maximum length = 500 characters]</font></p>
						</td></tr></table>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="centeralign">
							<input id="button_submit" type="submit" class="button"
									onclick="return checkAddEvaluation(this.form);"
									value="Create Evaluation" tabindex="9"></td>
					</tr>
				</table>
				<input type="hidden" name="<%=Const.ParamsNames.USER_ID%>" value="<%=data.account.googleId%>">
			</form>
			
			<br>
			<jsp:include page="<%=Const.ViewURIs.STATUS_MESSAGE%>" />
			<br>
			

			<table class="dataTable">
				<tr>
					<th class="leftalign color_white bold">
						<input class="buttonSortAscending" type="button" id="button_sortcourseid" 
								onclick="toggleSort(this,1)">Course ID</th>
					<th class="leftalign color_white bold">
						<input class="buttonSortNone" type="button" id="button_sortname"
								onclick="toggleSort(this,2)">Evaluation</th>
					<th class="centeralign color_white bold">Status</th>
					<th class="centeralign color_white bold"><span
						onmouseover="ddrivetip('<%=Const.Tooltips.EVALUATION_RESPONSE_RATE%>')"
						onmouseout="hideddrivetip()">Response Rate</span></th>
					<th class="centeralign color_white bold no-print">Action(s)</th>
				</tr>
				<%
					int evalIdx = -1;
																if (data.evaluations.size() > 0) {
																	for(EvaluationDetailsBundle edd: data.evaluations){ evalIdx++;
				%>
							<tr class="evaluations_row" id="evaluation<%=evalIdx%>">
								<td class="t_eval_coursecode"><%=edd.evaluation.courseId%></td>
								<td class="t_eval_name"><%=InstructorEvalPageData.sanitizeForHtml(edd.evaluation.name)%></td>
								<td class="t_eval_status centeralign"><span
									onmouseover="ddrivetip(' <%=InstructorEvalPageData.getInstructorHoverMessageForEval(edd.evaluation)%>')"
									onmouseout="hideddrivetip()"><%=InstructorEvalPageData.getInstructorStatusForEval(edd.evaluation)%></span></td>
								<td class="t_eval_response centeralign"><%=edd.stats.submittedTotal%>
									/ <%=edd.stats.expectedTotal%></td>
								<td class="centeralign no-print"><%=data.getInstructorEvaluationActions(edd.evaluation,evalIdx, false)%>
								</td>
							</tr>
						<%
							}
						%>
				<%
					} else {
				%>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				<%
					}
				%>
			</table>
			<br
			><br>
			<br>
			<%
				if(evalIdx==-1){
			%>
				No records found.<br>
				<br>
				<br>
			<%
				}
			%>
		</div>
	</div>

	<div id="frameBottom">
		<jsp:include page="<%=Const.ViewURIs.FOOTER%>" />
	</div>
</body>
</html>