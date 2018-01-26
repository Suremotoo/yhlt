package com.xzb.showcase.system.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.CompanyPermissionDao;
import com.xzb.showcase.system.entity.CompanyEntity;
import com.xzb.showcase.system.entity.CompanyPermissionEntity;


/**
 * 公司数据权限
 * @author hubaojie
 */
@Component
@Transactional
/*@BusinessLog(service = "公司数据权限")*/
@DataPermission
public class CompanyPermissionService extends BaseService<CompanyPermissionEntity, CompanyPermissionDao> {
	/*@BusinessLog(operation = "维护角色资源的关系")*/
	public void savePermissionEntity(List<CompanyPermissionEntity> list, Long[] companyIds,Long id,Long typeId) {
		for (CompanyPermissionEntity entity: list) {
			dao.delete(entity.getId());
		}
		for (Long rightId : companyIds) {
			CompanyPermissionEntity entity = new CompanyPermissionEntity();
			CompanyEntity companyEntityLeft = new CompanyEntity();
			CompanyEntity companyEntityRight = new CompanyEntity();
			companyEntityLeft.setId(id);
 			entity.setCompanyPerEntity(companyEntityLeft);
 			companyEntityRight.setId(rightId);
			entity.setCompanyMappingEntity(companyEntityRight);
			entity.setTypeId(typeId);
			dao.save(entity);
		}
	}
}
