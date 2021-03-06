/*
 * Copyright 2005-2014 The Kuali Foundation
 * 
 * Licensed under the Educational Community License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.osedu.org/licenses/ECL-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.kuali.coeus.common.impl.auth.task;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts.action.ActionForm;
import org.kuali.coeus.common.framework.auth.task.*;
import org.kuali.rice.core.api.resourceloader.GlobalResourceLoader;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Implementation of the Web Authorization Service.
 */
@Component("webAuthorizationService")
public class WebAuthorizationServiceImpl implements WebAuthorizationService, InitializingBean {

    @Value("#{webAuthorizerNames}")
    private Set<String> webAuthorizerNames = new HashSet<String>();

    @Autowired
    @Qualifier("taskAuthorizationService")
    private TaskAuthorizationService taskAuthorizationService;

    private List<WebAuthorizer> webAuthorizers = new ArrayList<WebAuthorizer>();
    
    /**
     * To determine if the user can execute the given Struts Action method, we will use
     * the Web Authorizers corresponding to the Struts Action classes.  We start with the
     * given Struts Action class and recursively move up the class hierarchy until we 
     * find a Web Authorizer that contains a entry for the given Struts Action method.
     * If we never find a Web Authorizer entry, the user is authorized by default.  If
     * an entry in a Web Authorizer is found, it's Task Factory is used to build a Task
     * and the Task Authorization is invoked to determine if the user can perform the
     * task.
     * 
     * @see org.kuali.coeus.common.framework.auth.task.WebAuthorizationService#isAuthorized(java.lang.String, java.lang.Class, java.lang.String,
     *      org.apache.struts.action.ActionForm, javax.servlet.http.HttpServletRequest)
     */
    public boolean isAuthorized(String userId, Class actionClass, String methodName, ActionForm form, HttpServletRequest request) {
        boolean isAuthorized = true;
        
        if (actionClass != null) {
            String classname = actionClass.getCanonicalName();
            
            WebAuthorizer webAuthorizer = getWebAuthorizer(classname);
            if (webAuthorizer == null) {
                isAuthorized = isAuthorized(userId, actionClass.getSuperclass(), methodName, form, request);
            } else {
                WebTaskFactory taskFactory = webAuthorizer.getTaskFactory(methodName);
                if (taskFactory == null) {
                    isAuthorized = isAuthorized(userId, actionClass.getSuperclass(), methodName, form, request);
                } else if (getTaskAuthorizationService() != null) {
                    Task task = taskFactory.createTask(form, request);
                    isAuthorized = getTaskAuthorizationService().isAuthorized(userId, task);
                }
            }
        }
        return isAuthorized;
    }

    /**
     * Get a Web Authorizer based upon the name of the Struts Action class.
     * @param classname the Struts Action classname
     * @return the corresponding Web Authorizer or null if not found
     */
    protected WebAuthorizer getWebAuthorizer(String classname) {
        for (WebAuthorizer webAuthorizer : getWebAuthorizers()) {
            if (StringUtils.equals(webAuthorizer.getClassname(), classname)) {
                return webAuthorizer;
            }
        }
        return null;
    }
    
    public List<WebAuthorizer> getWebAuthorizers() {
        if (webAuthorizers.size() != webAuthorizerNames.size()) {
            for (String webAuthorizerName : webAuthorizerNames) {
                final WebAuthorizer webAuthorizer = GlobalResourceLoader.getService(webAuthorizerName);
                if (webAuthorizer != null) {
                    webAuthorizers.add(webAuthorizer);
                }
            }
        }
        
        return webAuthorizers;
    }
    
    public void setWebAuthorizers(List<WebAuthorizer> webAuthorizers) {
        this.webAuthorizers = webAuthorizers;
    }
    
    public Set<String> getWebAuthorizerNames() {
        return webAuthorizerNames;
    }
    
    public void setWebAuthorizerNames(Set<String> webAuthorizerNames) {
        this.webAuthorizerNames = webAuthorizerNames;
    }

    public TaskAuthorizationService getTaskAuthorizationService() {
        return taskAuthorizationService;
    }

    public void setTaskAuthorizationService(TaskAuthorizationService taskAuthorizationService) {
        this.taskAuthorizationService = taskAuthorizationService;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        if (webAuthorizerNames == null || webAuthorizerNames.isEmpty()) {
            throw new IllegalStateException("webAuthorizerNames not set");
        }
    }

}