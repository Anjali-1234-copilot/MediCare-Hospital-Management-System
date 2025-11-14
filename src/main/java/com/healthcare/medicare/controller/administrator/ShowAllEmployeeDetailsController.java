package com.healthcare.medicare.controller.administrator;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.healthcare.medicare.dao.LoginDao;
import com.healthcare.medicare.dao.administrator.AllEmployeeDetailsDao;
import com.healthcare.medicare.dao.administrator.EmployeeDetailsDao;
import com.healthcare.medicare.entity.Employee;

@Controller
public class ShowAllEmployeeDetailsController 
{
	@Autowired
	AllEmployeeDetailsDao dao1;
	@Autowired
	EmployeeDetailsDao dao2;
	@Autowired
	LoginDao infoLog;
	
	@RequestMapping("/allEmployeesView.html")
	public ModelAndView view()
	{
		ModelAndView mv= new ModelAndView();
		mv.setViewName("administrator/AllEmployeeDetailsView");
		mv.addObject("employees", dao1.getAllEmployees());
		return mv;
	}
	
	@RequestMapping(value = "/viewEmployee.html", method = RequestMethod.POST)
	public ModelAndView showEmployeeDetailsViewMethod(@RequestParam("eid")String eid)
	{
		try {
			infoLog.logActivities("in ShowAllEmployeeDetailsController-showEmployeeDetailsViewMethod: got "+eid);
			Employee l=(Employee) dao2.show(eid);
			if(! l.equals(null))
			{
				ModelAndView mv= new ModelAndView();
				mv.setViewName("administrator/EmployeeDetailsView");
				mv.addObject("employee",l);
				return mv;
			}
			else
			{
				throw new Exception();
			}
		}
		catch(Exception e)
		{
			infoLog.logActivities("in ShowAllEmployeeDetailsController-showEmployeeDetailsViewMethod: "+e);
			ModelAndView mv= new ModelAndView();
			mv.setViewName("failure");
			mv.addObject("error",e);
			return mv;
		}
	}
	
}
