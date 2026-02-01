const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  
  try {
    // 1. 登录
    await page.goto('http://localhost:1024/login');
    await page.fill('input[placeholder="账号"]', 'huangfei');
    await page.fill('input[placeholder="密码"]', '123456');
    await page.click('button:has-text("登录")');
    await page.waitForTimeout(2000);
    
    // 2. 访问项目列表
    await page.goto('http://localhost:1024/efficiency/projects');
    await page.waitForTimeout(2000);
    
    const hasProjectList = await page.locator('text=项目列表').count() > 0;
    console.log('✓ 项目列表页面:', hasProjectList ? '存在' : '不存在');
    
    // 3. 检查是否有项目数据
    const projectRows = await page.locator('.el-table__body tr').count();
    console.log('✓ 项目数量:', projectRows);
    
    // 4. 进入第一个项目
    if (projectRows > 0) {
      await page.locator('.el-table__body tr').first().locator('button:has-text("进入项目")').click();
      await page.waitForTimeout(2000);
      
      // 5. 检查项目详情壳
      const hasProjectTitle = await page.locator('.project-title').count() > 0;
      console.log('✓ 项目详情壳:', hasProjectTitle ? '存在' : '不存在');
      
      // 6. 检查左侧菜单
      const menuItems = await page.locator('.shell-menu .el-menu-item').count();
      console.log('✓ 左侧菜单项数量:', menuItems);
      
      // 7. 检查 URL 是否包含 projectId
      const url = page.url();
      const hasProjectId = url.includes('/efficiency/project/');
      console.log('✓ URL 包含 projectId:', hasProjectId ? '是' : '否');
      console.log('  当前 URL:', url);
      
      // 8. 点击任务管理菜单
      const taskMenu = page.locator('.shell-menu .el-menu-item:has-text("任务管理")');
      if (await taskMenu.count() > 0) {
        await taskMenu.click();
        await page.waitForTimeout(2000);
        
        const hasTaskPage = await page.locator('text=任务管理').count() > 0;
        console.log('✓ 任务管理页面:', hasTaskPage ? '可访问' : '不可访问');
        
        // 检查任务列表是否有数据
        const taskRows = await page.locator('.el-table__body tr').count();
        console.log('✓ 任务数量:', taskRows);
      }
    }
    
    console.log('\n验证完成！');
  } catch (error) {
    console.error('验证失败:', error.message);
  } finally {
    await browser.close();
  }
})();
