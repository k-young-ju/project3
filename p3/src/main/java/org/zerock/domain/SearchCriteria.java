package org.zerock.domain;

import lombok.Data;

@Data
public class SearchCriteria extends Criteria{
	private String searchTitle;
	private String keyword;
}
