package com.xzb.showcase.base.tag;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.xzb.showcase.base.security.SessionSecurityConstants;
import com.xzb.showcase.base.util.Constants;
import com.xzb.showcase.base.util.ConstantsUtils;
import com.xzb.showcase.system.entity.UserRoleResourceEntity;

/**
 * JSP权限验证标签
 * 
 * @author admin
 * 
 */
@SuppressWarnings("serial")
public class PermissControl extends TagSupport {
	private String authorization;

	@SuppressWarnings("unchecked")
	public int doStartTag() throws JspException {
		List<String> resourceNameList = new ArrayList<String>();
		List<UserRoleResourceEntity> userRoleResourceEntityList = (List<UserRoleResourceEntity>) pageContext
				.getSession().getAttribute(SessionSecurityConstants.KEY_USER_RESOURCES);
		for (UserRoleResourceEntity userRoleResourceEntity : userRoleResourceEntityList) {
			if (userRoleResourceEntity.getType() == Constants.RESOURCE_TYPE_FCUNTION) {
				resourceNameList.add(userRoleResourceEntity.getDescription());
			}
		}

		if (resourceNameList.size() == 0) {
			return SKIP_BODY;
		}
		for (String permiss : resourceNameList) {
			if (authorization.equals(permiss)) {
				return EVAL_BODY_INCLUDE;
			}
		}

		return SKIP_BODY;
		// return EVAL_BODY_INCLUDE;
	}

	public int doEndTag() throws JspException {

		return EVAL_PAGE;
	}

	public String getAuthorization() {
		return authorization;
	}

	public void setAuthorization(String authorization) {
		this.authorization = authorization;
	}

}
