/*
 * Copyright 2005-2010 The Kuali Foundation
 * 
 * Licensed under the Educational Community License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.opensource.org/licenses/ecl1.php
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.kuali.kra.common.committee.document.authorization;

import org.kuali.kra.common.committee.bo.Committee;
import org.kuali.kra.common.committee.bo.CommitteeSchedule;

/**
 * A Committee Task is a task that performs an action against a
 * Committee.  To assist authorization, the Committee is available.
 * 
 * This extension is for checking authorization for the schedules
 * both the committee and schedule are needed to do this.
 * 
 */
public abstract class CommitteeScheduleTask<CMT extends Committee<CMT, ?, CS>, 
                                            CS extends CommitteeSchedule<CS, CMT, ?, ?>> 
    
                                            extends CommitteeTask<CMT> {

    protected CS schedule;
    
    public CommitteeScheduleTask(String taskGroupName, String taskName, CMT committee, CS schedule) {
        super(taskGroupName, taskName, committee);
        this.schedule = schedule;
    }

    public CS getCommitteeSchedule() {
        return schedule;
    }
    
}
