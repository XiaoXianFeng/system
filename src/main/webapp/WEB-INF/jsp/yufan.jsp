<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="cache-control" content="max-age=0" />
        <meta http-equiv="cache-control" content="no-cache" />
        <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
        <meta http-equiv="pragma" content="no-cache" />
        
		<title>生产计划</title>

		<script src="<%=request.getContextPath()%>/resources/jquery/jquery-2.0.3.min.js"></script>
		
		<link href="<%=request.getContextPath()%>/resources/main.css" rel="stylesheet">
		<link href="<%=request.getContextPath()%>/resources/w3.css" rel="stylesheet">
		<!-- bootstrap -->
		<link href="<%=request.getContextPath()%>/resources/bootstrap300/css/bootstrap.css" rel="stylesheet">
		<script src="<%=request.getContextPath()%>/resources/bootstrap300/js/bootstrap.js"></script>
		
		<!-- X-editable -->
		<link href="<%=request.getContextPath()%>/resources/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet">
		<script src="<%=request.getContextPath()%>/resources/bootstrap3-editable/js/bootstrap-editable.min.js"></script>
		
		<!-- wysihtml5 -->
		
		<link href="<%=request.getContextPath()%>/resources/x-editable/inputs-ext/wysihtml5/bootstrap-wysihtml5-0.0.3/bootstrap-wysihtml5-0.0.3.css" rel="stylesheet">  
        <script src="<%=request.getContextPath()%>/resources/x-editable/inputs-ext/wysihtml5/bootstrap-wysihtml5-0.0.3/wysihtml5-0.3.0.min.js"></script>  
        <script src="<%=request.getContextPath()%>/resources/x-editable/inputs-ext/wysihtml5/bootstrap-wysihtml5-0.0.3/bootstrap-wysihtml5-0.0.3.min.js"></script>
        <script src="<%=request.getContextPath()%>/resources/x-editable/inputs-ext/wysihtml5/wysihtml5-0.0.3.js"></script>
		<script>
			$.fn.editable.defaults.mode = 'popup';
		
			$(document).ready(function() {
				$('.editable').editable();
			});
		</script>
	</head>
<body style=" width: 100%;">
		<jsp:include page="navi.jsp">
			<jsp:param name="page" value="home" />
		</jsp:include>

		<c:if test="${plan == null or not empty error}">
			<div class="w3-panel w3-red">
			    <h3>出错了</h3>
			    <p><c:out value="${error}"/></p>
			</div>
			<c:if test="${plan == null}">
			<a href="<%=request.getContextPath()%>/do/plan/list.html">返回</a>
			</c:if>
		</c:if>
		
		<c:if test="${plan != null}"></c:if>
		<c:if test="${not empty plan.message }">
			<div class="w3-panel w3-yellow">
			    <p><c:out value="${plan.message}"/></p>
			</div>
		</c:if>
					<h3 align="center">生产计划通知书</h3>
	<table border="1" style="margin-left: auto;margin-right: auto; width:80%">	
		<tfoot align="center">
				<tr>
					<td colspan="13">
						<table style="border:0; width:100%; height:100%">
							<tr>
								<th style="width:80px">制表</th>
								<td style="width:160px">${plan.creator.username}</td>
								<th style="width:80px">审核</th>
								<td style="width:160px">
									<c:if test="${plan.reviewStatus == 'REJECTED'  or plan.reviewStatus == 'APPROVED'}">
									<div class="stamp stamp-${plan.reviewStatus}">
										<span><fmt:formatDate value="${plan.reviewDate}" pattern="yyyy-MM-dd" /></span>
										<span><c:out value="${plan.reviewer.userDispName}"></c:out></span>
									</div>
									</c:if>
								</td>
								<th style="width:80px">承认</th>
								<td style="width:160px">
									<c:if test="${plan.approveStatus == 'REJECTED'  or plan.approveStatus == 'APPROVED'}">
									<div class="stamp stamp-${plan.approveStatus}">
										<span><fmt:formatDate value="${plan.reviewDate}" pattern="yyyy-MM-dd" /></span>
										<span><c:out value="${plan.approver.userDispName}"></c:out></span>
									</div>
									</c:if>
								</td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
		    	<tr>
		        	<td colspan="13">
		        		<c:if test="${plan.status == 'CREATING' }">
		        		<form name="form" method="POST" action="<%=request.getContextPath()%>/do/plan/submitReview.html">
		        			<input type="hidden" name="planId" value="${plan.planId}">
		        			<input type="submit" value="提交审核"/>
		        		</form>
		        		</c:if>
		        		
		        		<c:if test="${plan.status == 'REVIEWING' }">
		        		<form name="form" method="POST" action="<%=request.getContextPath()%>/do/plan/review.html">
		        			<input type="hidden" name="planId" value="${plan.planId}">
		        			<input type="submit" name="action" value="发回修改"/>
		        			<input type="submit" name="action" value="通过审核"/>
		        		</form>
		        		</c:if>
		        		
		        		<c:if test="${plan.status == 'APPROVING' }">
		        		<form name="form" method="POST" action="<%=request.getContextPath()%>/do/plan/approve.html">
		        			<input type="hidden" name="planId" value="${plan.planId}">
		        			<input type="submit" name="action" value="发回修改"/>
		        			<input type="submit" name="action" value="承认"/>
		        		</form>
		        		</c:if>
		        		<c:if test="${plan.status == 'APPROVED' }">
		        		
		        		</c:if>
		        	</td>
		      	</tr>
		    </tfoot>
		    <tbody>
		<tr>
			<td colspan="2">客户名称:</td>
			<td colspan="4" style="width:200px" align="left"><div style="width:200px; text-align:left;  word-break: break-all;"><a href="#" id="customer" data-type="text" data-pk="customer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入客户名称">
				<c:out value="${plan.customer}"/>
				</a>
				</div>
				<script>
				$('#customer').editable({
						placement: 'bottom'
				});
				</script>
			</td>
			<td colspan="2" style="width:100px">销    售：</td>
			<td colspan="4" style="width:200px" align="left"><div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="saleType" data-type="checklist" data-pk="saleType" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="选择销售"></a></div> 
				<script>
					$(function() {
						$('#saleType').editable({
							value : [${plan.planItems['saleType'].itemValue}],
							source : [ {
								value : 1,
								text : '内销'
							}, {
								value : 2,
								text : '外销'
							}],
							placement: 'bottom',
							display:function(value, sourceData){
								var html = [], checked = $.fn.editableutils.itemsByValue(value, sourceData);
								if (checked.length) {
							    	$.each(checked, function(i, v) {
							        	html.push($.fn.editableutils.escape(v.text));
							      	});
							      	$(this).html(html.join(', '));
							    } else {
							      	$(this).empty();
							    }
							}
						});
					});
				</script>
			</td>
		</tr>
		<tr>
			<td colspan="2">文件编号:</td>
			<td colspan="4"><c:out value="${plan.notifyNo}"/></td>
			<td colspan="2">日    期：</td>
			<td colspan="4"><fmt:formatDate value="${plan.createDate}" pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<td rowspan = "18" width=10%px>生产资料(无请填写/)</td>
			<td colspan = "2" width=15%px>产品名称 </td>
			<td colspan = "4" width=25%px>产品型号 </td>
			<td colspan = "4" width=25%px>PCB 版本号 </td>
			<td colspan = "2" width=25%px>产品P/N (PCBA料号)</td>
		</tr>
		<tr>
			<td colspan = "2"><a href="#" class="editable" id="productName" data-type="text" data-pk="productName" 
				data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品名称">
				<c:out value="${plan.planItems['productName'].itemValue}"/>
			</a></td>
			<td colspan = "4">
				<a href="#" class="editable" id="productModel" data-type="text" data-pk="productModel" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品型号">
					<c:out value="${plan.planItems['productModel'].itemValue}"/>
				</a>
			</td>
			<td colspan = "4">
				<a href="#" class="editable" id="pcbVer" data-type="text" data-pk="pcbVer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入PCB版本号 ">
					<c:out value="${plan.planItems['pcbVer'].itemValue}"/>
				</a>
			</td>
			<td colspan = "2">
				<a href="#" class="editable" id="productPN" data-type="text" data-pk="productPN" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品P/N">
					<c:out value="${plan.planItems['productPN'].itemValue}"/>
				</a>
			</td>
			
		</tr>
		<tr>
			<td colspan = "2">类别</td>
			<td colspan="10"><a href="#" id="category" data-type="checklist" data-pk="category" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入类别"></a>
				<script>
					$(function() {
						$('#category').editable({
							value : [${plan.planItems['category'].itemValue}],
							source : [ {
								value : 1,
								text : 'SMT'
							}, {
								value : 2,
								text : '插件'
							}, {
								value : 3,
								text : '组装'
							}, {
								value : 4,
								text : '其他'
							}],
							display:function(value, sourceData){
								var html = [], checked = $.fn.editableutils.itemsByValue(value, sourceData);
								if (checked.length) {
							    	$.each(checked, function(i, v) {
							        	html.push($.fn.editableutils.escape(v.text));
							      	});
							      	$(this).html(html.join(', '));
							    } else {
							      	$(this).empty();
							    }
							}
						});
					});
				</script>
			</td>
			
		</tr>
		<tr>
			<td colspan = "2">贴片BOM</td>
			<td colspan="8">
				<a href="#" id="bom" data-type="textarea" data-pk="bom" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品P/N"><c:out value="${plan.planItems['bom'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#bom').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '贴片BOM',
				        rows: 2
				    });
				});
				</script>
			</td>
			<td rowspan ="9" colspan = "2">
				<a href="#" id="custel" data-type="textarea" data-pk="custel" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入客户信息"><c:out value="${plan.planItems['custel'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#custel').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '客户信息',
				        rows: 2
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td colspan = "2">SMT资料包</td>
			<td colspan="8"><a href="#" id="smtDocPackage" data-type="textarea" data-pk="smtDocPackage" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品P/N"><c:out value="${plan.planItems['smtDocPackage'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#smtDocPackage').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: 'SMT资料包',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td colspan = "2">软件版本号</td>
			<td colspan = "8"><a href="#" id="softwareVer" data-type="textarea" data-pk="softwareVer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入软件版本号"><c:out value="${plan.planItems['softwareVer'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#softwareVer').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '软件版本号',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td colspan = "2">下载工具</td>
			<td colspan = "8"><a href="#" id="download_tool" data-type="textarea" data-pk="download_tool" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入下载工具"><c:out value="${plan.planItems['download_tool'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#download_tool').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '下载工具',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td colspan = "2">写号工具</td>
			<td colspan = "8"><a href="#" id="writer_sn_tool" data-type="textarea" data-pk="writer_sn_tool" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入写号工具"><c:out value="${plan.planItems['writer_sn_tool'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#writer_sn_tool').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '写号工具',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td colspan = "2">校准工具</td>
			<td colspan = "8"><a href="#" id="jiaozhun_tool" data-type="textarea" data-pk="jiaozhun_tool" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入校准工具"><c:out value="${plan.planItems['jiaozhun_tool'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#jiaozhun_tool').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '校准工具',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td colspan = "2">校准文件</td>
			<td colspan = "8"><a href="#" id="jiaozhun_file" data-type="textarea" data-pk="jiaozhun_file" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入校准文件"><c:out value="${plan.planItems['jiaozhun_file'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#jiaozhun_file').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '校准文件',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td colspan = "2">check工具</td>
			<td colspan = "8"><a href="#" id="check_tool" data-type="textarea" data-pk="check_tool" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入check工具"><c:out value="${plan.planItems['check_tool'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#check_tool').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: 'check工具',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td colspan = "2">测试流程要求</td>
			<td colspan="8"><a href="#" id="test_request" data-type="textarea" data-pk="test_request" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入测试流程要求"><c:out value="${plan.planItems['test_request'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#test_request').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '测试流程要求',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<th rowspan = "6">测试频段</th>
			<td>GSM</td>
			<td colspan = "10">
				<a href="#" class="editable" id="gsm_number" data-type="text" data-pk="gsm_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入GSM频段">
					<c:out value="${plan.planItems['gsm_number'].itemValue}"/>
				</a>
			</td>
		</tr>
		<tr>
			<td>CDMA</td>
			<td colspan = "10">
				<a href="#" class="editable" id="cdma_number" data-type="text" data-pk="cdma_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入CDMA频段">
					<c:out value="${plan.planItems['cdma_number'].itemValue}"/>
				</a>
			</td>
		</tr>
		<tr>
			<td>WCDMA</td>
			<td colspan = "10">
				<a href="#" class="editable" id="wcdma_number" data-type="text" data-pk="wcdma_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入WCDMA频段">
					<c:out value="${plan.planItems['wcdma_number'].itemValue}"/>
				</a>
			</td>
		</tr>
		<tr>
			<td>TDSCDMA</td>
			<td colspan = "10">
				<a href="#" class="editable" id="tdscdma_number" data-type="text" data-pk="tdscdma_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入TDSCDMA频段">
					<c:out value="${plan.planItems['tdscdma_number'].itemValue}"/>
				</a>
			</td>
		</tr>
		<tr>
			<td>TDD-LTE</td>
			<td colspan = "10">
				<a href="#" class="editable" id="tdd-lte_number" data-type="text" data-pk="tdd-lte_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入TDD-LTE频段">
					<c:out value="${plan.planItems['tdd-lte_number'].itemValue}"/>
				</a>
			</td>
		</tr>
		<tr>
			<td>FDD-LTE</td>
			<td colspan = "10">
				<a href="#" class="editable" id="fdd-lte_number" data-type="text" data-pk="fdd-lte_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入FDD-LTE频段">
					<c:out value="${plan.planItems['fdd-lte_number'].itemValue}"/>
				</a>
			</td>
		</tr>
		<tr>
			<td>绿色产品生产要求<br/>（必选）</td>
			<td colspan = "12">工艺要求：<div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="fabrication" data-type="checklist" data-pk="fabrication" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="工艺要求"></a></div> 
				<script>
					$(function() {
						$('#fabrication').editable({
							value : [${plan.planItems['fabrication'].itemValue}],
							source : [ {
								value : 1,
								text : '无铅工艺'
							}, {
								value : 2,
								text : '有铅工艺'
							}, {
								value : 3,
								text : 'ROHS工艺'
							}, {
								value : 4,
								text : '点胶工艺(CPU,MEMORY)'
							}, {
								value : 5,
								text : '其他要求(氮气)'
							}],
							placement: 'bottom',
							display:function(value, sourceData){
								var html = [], checked = $.fn.editableutils.itemsByValue(value, sourceData);
								if (checked.length) {
							    	$.each(checked, function(i, v) {
							        	html.push($.fn.editableutils.escape(v.text));
							      	});
							      	$(this).html(html.join(', '));
							    } else {
							      	$(this).empty();
							    }
							}
						});
					});
				</script></td>
		</tr>
		
		<tr>
			<td>生产性质（必选）</td>
			<td colspan = "12"><div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="manufactureType" data-type="checklist" data-pk="manufactureType" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="生产性质"></a></div> 
				<script>
					$(function() {
						$('#manufactureType').editable({
							value : [${plan.planItems['manufactureType'].itemValue}],
							source : [ {
								value : 1,
								text : '量产'
							}, {
								value : 2,
								text : '试产(小批量设计验证)'
							}, {
								value : 3,
								text : '返工'
							}],
							placement: 'bottom',
							display:function(value, sourceData){
								var html = [], checked = $.fn.editableutils.itemsByValue(value, sourceData);
								if (checked.length) {
							    	$.each(checked, function(i, v) {
							        	html.push($.fn.editableutils.escape(v.text));
							      	});
							      	$(this).html(html.join(', '));
							    } else {
							      	$(this).empty();
							    }
							}
						});
					});
				</script></td>
		</tr>
		<tr>
			<td>委托加工方</td>
			<td colspan = "2">订单批量</td>
			<td colspan = "4">要求出货数量</td>
			<td colspan = "4">预计生产日期</td>
			<td colspan = "2">预计交货日期</td>
		</tr>
		<tr>
			<td rowspan = "2">
				<a href="#" class="editable" id="producer" data-type="text" data-pk="producter" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入委托加工方">
					<c:out value="${plan.planItems['producer'].itemValue}"/>
				</a>
			</td>
			<td colspan = "2" rowspan = "2">
				<a href="#" class="editable" id="dingdan_total" data-type="text" data-pk="dingdan_total" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入订单批量">
					<c:out value="${plan.planItems['dingdan_total'].itemValue}"/>
				</a>
			</td>
			<th colspan = "2">客户需求</th>
			<th colspan = "2">研发需求</th>
			<td colspan = "4">
				<a href="#" class="editable" id="manufactureDate" data-type="date" data-pk="manufactureDate" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入预计生产日期">
					<c:out value="${plan.planItems['manufactureDate'].itemValue}"/>
				</a>
			</td>
			<td colspan = "2">
				<a href="#" class="editable" id="completeDate" data-type="date" data-pk="completeDate" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入预计交货日期">
					<c:out value="${plan.planItems['completeDate'].itemValue}"/>
				</a>
			</td>
		</tr>
		<tr>
			<td colspan = "2">
				<a href="#" class="editable" id="customer_total" data-type="text" data-pk="customer_total" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入客户需求">
					<c:out value="${plan.planItems['customer_total'].itemValue}"/>
				</a>
			</td>
			<td colspan = "2">
				<a href="#" class="editable" id="yanfa_total" data-type="text" data-pk="yanfa_total" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入研发需求">
					<c:out value="${plan.planItems['yanfa_total'].itemValue}"/>
				</a>
			</td>
			<td colspan = "4"></td>
			<td colspan = "2"></td>
		</tr>
		<tr>
			<td rowspan = "3">客户确认</td>
			<th rowspan = "3">标记</th>
			<td>主板S/N</td>
			<td colspan = "6">
							<a href="#" class="editable" id="zhuban_sn" data-type="text" data-pk="zhuban_sn" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入主板S/N">
					<c:out value="${plan.planItems['zhuban_sn'].itemValue}"/>
				</a>
			</td>
			<td colspan = "2">MAC地址</td>
			<td colspan = "2">
				<a href="#" class="editable" id="mac_address" data-type="text" data-pk="mac_address" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入MAC地址">
									<c:out value="${plan.planItems['mac_address'].itemValue}"/>
				</a>
			</td>
		</tr>
		<tr>
			<td>IMEI</td>
			<td colspan = "6">
				<a href="#" class="editable" id="imei" data-type="text" data-pk="imei" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入IMEI">
					<c:out value="${plan.planItems['imei'].itemValue}"/>
				</a>
			</td>
			<td colspan = "2">MEID</td>
			<td colspan = "2">
				<a href="#" class="editable" id="meid" data-type="text" data-pk="meid" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入MEID">
					<c:out value="${plan.planItems['meid'].itemValue}"/>
				</a>
			</td>
		<tr>
			<td colspan = "11"> </td>
		</tr>
		<tr>
			<td>备注</td>
			<td colspan = "12" >
				<div id="comments" data-type="wysihtml5" data-pk="comments">
					<c:out value="${plan.planItems['comments'].itemValue}" escapeXml="false"/>
				</div>
				<script>
					$('#comments').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '备注',
				        wysihtml5:{
				        	"font-styles": true, //Font styling, e.g. h1, h2, etc. Default true
				        	"emphasis": true, //Italics, bold, etc. Default true
				        	"lists": true, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
				        	"html": false, //Button which allows you to edit the generated HTML. Default false
				        	"link": false, //Button to insert a link. Default true
				        	"image": false, //Button to insert an image. Default true,
				        	"color": true //Button to change color of font 
				        }
				    });
				</script>
			</td>
		</tr>
		<tr>
			<th rowspan = "4">会签</th>
			<td colspan = "8">项目部:</td>
			<td colspan = "4">硬件基带,射频:</td>
		</tr>
		<tr>
			<td colspan = "8">软件部:</td>
			<td colspan = "4">软测部:</td>
		</tr>
		<tr>
			<td colspan = "8">运营部:</td>
			<td colspan = "4">结构部:</td>
		</tr>
		<tr>
			<td colspan = "8">销售部:</td>
			<td colspan = "4">研发总监:</td>
		</tr>
		</tbody>
	</table>
	<table style="border-top-width: 0px;　border-right-width: 1px;　border-bottom-width: 1px;　border-left-width: 1px; margin-left: auto;margin-right: auto; width:80%; border-collapse: collapse">
	</table>	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>