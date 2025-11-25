<template>
  <div class="dashboard-container">
    <!-- 顶部导航栏 -->
    <nav class="navbar">
      <div class="navbar-brand">
        <div class="logo">
          <i class="fas fa-chart-network"></i>
          <h1>先锋互联</h1>
        </div>
      </div>
      <div class="navbar-menu">
        <a href="#" class="navbar-item active">
          <i class="fas fa-home"></i>
          <span>主页</span>
        </a>
        <a href="#" class="navbar-item">
          <i class="fas fa-sitemap"></i>
          <span>公司架构</span>
        </a>
        <a href="#" class="navbar-item">
          <i class="fas fa-users"></i>
          <span>客户</span>
        </a>
      </div>
      <div class="navbar-user">
        <div class="user-info">
          <div class="user-avatar">
            <i class="fas fa-user-circle"></i>
          </div>
          <span class="user-name">管理员</span>
        </div>
      </div>
    </nav>

    <!-- 主要内容区域 -->
    <main class="main-content">
      <!-- 页面标题和日期 -->
      <div class="page-header">
        <div class="header-content">
          <h2 class="page-title">数据概览</h2>
          <p class="page-subtitle">实时监控业务关键指标</p>
        </div>
        <div class="date-selector">
          <span class="current-date">{{ currentDate }}</span>
          <button class="date-btn">
            <i class="fas fa-calendar-alt"></i>
            选择日期
          </button>
        </div>
      </div>
      
      <!-- 指标卡片区域 -->
      <div class="metrics-section">
        <h3 class="section-title">核心指标</h3>
        <div class="metrics-grid">
          <div class="metric-card">
            <div class="metric-header">
              <div class="metric-icon customer-icon">
                <i class="fas fa-user-plus"></i>
              </div>
              <div class="trend-indicator positive">
                <i class="fas fa-arrow-up"></i>
                12%
              </div>
            </div>
            <div class="metric-content">
              <h3 class="metric-value">36人</h3>
              <p class="metric-label">昨日新增客户</p>
              <div class="metric-footer">
                <span class="metric-compare">较前日增加4人</span>
              </div>
            </div>
          </div>
          
          <div class="metric-card">
            <div class="metric-header">
              <div class="metric-icon order-icon">
                <i class="fas fa-clipboard-list"></i>
              </div>
              <div class="trend-indicator positive">
                <i class="fas fa-arrow-up"></i>
                8%
              </div>
            </div>
            <div class="metric-content">
              <h3 class="metric-value">48例</h3>
              <p class="metric-label">昨日跟进订单</p>
              <div class="metric-footer">
                <span class="metric-compare">较前日增加3例</span>
              </div>
            </div>
          </div>
          
          <div class="metric-card">
            <div class="metric-header">
              <div class="metric-icon opportunity-icon">
                <i class="fas fa-chart-line"></i>
              </div>
              <div class="trend-indicator negative">
                <i class="fas fa-arrow-down"></i>
                5%
              </div>
            </div>
            <div class="metric-content">
              <h3 class="metric-value">8例</h3>
              <p class="metric-label">昨日挖掘商机</p>
              <div class="metric-footer">
                <span class="metric-compare">较前日减少1例</span>
              </div>
            </div>
          </div>

          <div class="metric-card">
            <div class="metric-header">
              <div class="metric-icon revenue-icon">
                <i class="fas fa-dollar-sign"></i>
              </div>
              <div class="trend-indicator positive">
                <i class="fas fa-arrow-up"></i>
                15%
              </div>
            </div>
            <div class="metric-content">
              <h3 class="metric-value">¥128,560</h3>
              <p class="metric-label">本月累计收入</p>
              <div class="metric-footer">
                <span class="metric-compare">同比增长22%</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 图表区域 -->
      <div class="charts-section">
        <div class="charts-grid">
          <!-- 柱形图 -->
          <div class="chart-card large-card">
            <div class="chart-header">
              <h3 class="chart-title">月度订单统计</h3>
              <div class="chart-controls">
                <div class="chart-legend">
                  <span class="legend-item">
                    <span class="legend-color new-orders"></span>
                    新增订单
                  </span>
                  <span class="legend-item">
                    <span class="legend-color completed-orders"></span>
                    完成订单
                  </span>
                </div>
                <select class="time-filter">
                  <option>本月</option>
                  <option>本季度</option>
                  <option>本年度</option>
                </select>
              </div>
            </div>
            <div class="chart-container">
              <div class="bar-chart">
                <div class="bar-chart-container">
                  <div class="bar-chart-y-axis">
                    <div class="y-label">100</div>
                    <div class="y-label">75</div>
                    <div class="y-label">50</div>
                    <div class="y-label">25</div>
                    <div class="y-label">0</div>
                  </div>
                  <div class="bar-chart-bars">
                    <div v-for="(month, index) in barChartData" :key="index" class="bar-group">
                      <div class="bars">
                        <div 
                          class="bar new-orders-bar" 
                          :style="{ height: month.newOrders + '%' }"
                        >
                          <div class="bar-value">{{ month.newOrdersValue }}</div>
                        </div>
                        <div 
                          class="bar completed-orders-bar" 
                          :style="{ height: month.completedOrders + '%' }"
                        >
                          <div class="bar-value">{{ month.completedOrdersValue }}</div>
                        </div>
                      </div>
                      <div class="bar-label">{{ month.name }}</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 折线图 -->
          <div class="chart-card large-card">
            <div class="chart-header">
              <h3 class="chart-title">客户增长趋势</h3>
              <div class="chart-controls">
                <div class="chart-legend">
                  <span class="legend-item">
                    <span class="legend-color customer-growth"></span>
                    客户数量
                  </span>
                </div>
                <select class="time-filter">
                  <option>近6个月</option>
                  <option>近12个月</option>
                  <option>自定义</option>
                </select>
              </div>
            </div>
            <div class="chart-container">
              <div class="line-chart">
                <div class="line-chart-container">
                  <svg class="line-chart-svg" viewBox="0 0 500 250">
                    <!-- 网格线 -->
                    <line x1="0" y1="50" x2="500" y2="50" class="grid-line" />
                    <line x1="0" y1="100" x2="500" y2="100" class="grid-line" />
                    <line x1="0" y1="150" x2="500" y2="150" class="grid-line" />
                    <line x1="0" y1="200" x2="500" y2="200" class="grid-line" />
                    
                    <!-- 折线 -->
                    <polyline 
                      :points="lineChartPoints" 
                      class="line-chart-path"
                    />
                    
                    <!-- 数据点 -->
                    <circle 
                      v-for="(point, index) in lineChartData" 
                      :key="index"
                      :cx="point.x" 
                      :cy="point.y" 
                      r="5" 
                      class="data-point"
                    />
                    
                    <!-- 数据标签 -->
                    <text 
                      v-for="(point, index) in lineChartData" 
                      :key="'label-' + index"
                      :x="point.x" 
                      :y="point.y - 15" 
                      class="data-label"
                    >
                      {{ point.value }}
                    </text>
                    
                    <!-- X轴标签 -->
                    <text 
                      v-for="(point, index) in lineChartData" 
                      :key="'xlabel-' + index"
                      :x="point.x" 
                      y="240" 
                      class="axis-label"
                    >
                      {{ point.month }}
                    </text>
                  </svg>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 小型图表和列表 -->
        <div class="secondary-charts">
          <!-- 环形图 -->
          <div class="chart-card">
            <div class="chart-header">
              <h3 class="chart-title">客户分布</h3>
            </div>
            <div class="chart-container">
              <div class="pie-chart">
                <div class="pie-segment new-customers"></div>
                <div class="pie-segment active-customers"></div>
                <div class="pie-segment vip-customers"></div>
                <div class="pie-center">
                  <div class="pie-total">856</div>
                  <div class="pie-label">总客户数</div>
                </div>
              </div>
              <div class="pie-legend">
                <div class="pie-legend-item">
                  <span class="legend-color new-customers-color"></span>
                  <span>新客户 (25%)</span>
                </div>
                <div class="pie-legend-item">
                  <span class="legend-color active-customers-color"></span>
                  <span>活跃客户 (60%)</span>
                </div>
                <div class="pie-legend-item">
                  <span class="legend-color vip-customers-color"></span>
                  <span>VIP客户 (15%)</span>
                </div>
              </div>
            </div>
          </div>

          <!-- 最近活动 -->
          <div class="chart-card">
            <div class="chart-header">
              <h3 class="chart-title">最近活动</h3>
              <button class="view-all-btn">查看全部</button>
            </div>
            <div class="activity-list">
              <div v-for="(activity, index) in recentActivities" :key="index" class="activity-item">
                <div class="activity-icon" :class="activity.type">
                  <i :class="activity.icon"></i>
                </div>
                <div class="activity-content">
                  <p class="activity-text">{{ activity.text }}</p>
                  <span class="activity-time">{{ activity.time }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script>
export default {
  name: 'DashboardHome',
  data() {
    return {
      currentDate: '2024年1月15日',
      // 柱形图数据
      barChartData: [
        { name: '1月', newOrders: 60, newOrdersValue: 60, completedOrders: 45, completedOrdersValue: 45 },
        { name: '2月', newOrders: 75, newOrdersValue: 75, completedOrders: 60, completedOrdersValue: 60 },
        { name: '3月', newOrders: 50, newOrdersValue: 50, completedOrders: 40, completedOrdersValue: 40 },
        { name: '4月', newOrders: 80, newOrdersValue: 80, completedOrders: 65, completedOrdersValue: 65 },
        { name: '5月', newOrders: 65, newOrdersValue: 65, completedOrders: 55, completedOrdersValue: 55 },
        { name: '6月', newOrders: 90, newOrdersValue: 90, completedOrders: 75, completedOrdersValue: 75 }
      ],
      // 折线图数据
      lineChartData: [
        { month: '1月', value: 45, x: 60, y: 200 },
        { month: '2月', value: 52, x: 140, y: 185 },
        { month: '3月', value: 48, x: 220, y: 195 },
        { month: '4月', value: 65, x: 300, y: 160 },
        { month: '5月', value: 72, x: 380, y: 145 },
        { month: '6月', value: 80, x: 460, y: 130 }
      ],
      // 最近活动数据
      recentActivities: [
        { type: 'order', icon: 'fas fa-shopping-cart', text: '新订单 #2845 已创建', time: '10分钟前' },
        { type: 'customer', icon: 'fas fa-user-plus', text: '新客户 "科技公司" 已注册', time: '25分钟前' },
        { type: 'payment', icon: 'fas fa-credit-card', text: '付款 #3821 已成功处理', time: '1小时前' },
        { type: 'support', icon: 'fas fa-headset', text: '客户支持工单 #572 已解决', time: '2小时前' }
      ]
    }
  },
  computed: {
    // 生成折线图的路径点
    lineChartPoints() {
      return this.lineChartData.map(point => `${point.x},${point.y}`).join(' ');
    }
  }
}
</script>

<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
}

.dashboard-container {
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #e4e8ed 100%);
}

/* 导航栏样式 */
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 2rem;
  background-color: #fff;
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
  position: sticky;
  top: 0;
  z-index: 100;
}

.logo {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.logo i {
  font-size: 1.8rem;
  color: #3498db;
}

.navbar-brand h1 {
  color: #2c3e50;
  font-size: 1.5rem;
  font-weight: 700;
}

.navbar-menu {
  display: flex;
  gap: 2rem;
}

.navbar-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  text-decoration: none;
  color: #7f8c8d;
  font-weight: 500;
  padding: 0.75rem 1rem;
  border-radius: 8px;
  transition: all 0.3s;
}

.navbar-item:hover {
  color: #3498db;
  background-color: #f8f9fa;
}

.navbar-item.active {
  color: #3498db;
  background-color: #e3f2fd;
}

.navbar-user {
  display: flex;
  align-items: center;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.5rem 1rem;
  border-radius: 8px;
  transition: background-color 0.3s;
}

.user-info:hover {
  background-color: #f8f9fa;
}

.user-avatar i {
  font-size: 2rem;
  color: #7f8c8d;
}

.user-name {
  font-weight: 500;
  color: #2c3e50;
}

/* 主内容区域 */
.main-content {
  padding: 2rem;
  max-width: 1400px;
  margin: 0 auto;
}

/* 页面标题区域 */
.page-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  margin-bottom: 2rem;
  padding-bottom: 1.5rem;
  border-bottom: 1px solid #e0e6ed;
}

.header-content {
  flex: 1;
}

.page-title {
  color: #2c3e50;
  font-size: 2.2rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
}

.page-subtitle {
  color: #7f8c8d;
  font-size: 1.1rem;
}

.date-selector {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.current-date {
  font-weight: 600;
  color: #2c3e50;
}

.date-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: #fff;
  border: 1px solid #e0e6ed;
  border-radius: 8px;
  color: #5a67d8;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s;
}

.date-btn:hover {
  background: #f7fafc;
  border-color: #5a67d8;
}

/* 指标区域 */
.metrics-section {
  margin-bottom: 2.5rem;
}

.section-title {
  color: #2c3e50;
  font-size: 1.4rem;
  font-weight: 600;
  margin-bottom: 1.5rem;
  padding-left: 0.5rem;
  border-left: 4px solid #3498db;
}

.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.5rem;
}

.metric-card {
  background: #fff;
  border-radius: 12px;
  padding: 1.75rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
  transition: all 0.3s ease;
  border: 1px solid #f0f0f0;
}

.metric-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
}

.metric-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 1.5rem;
}

.metric-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 60px;
  height: 60px;
  border-radius: 12px;
  font-size: 1.5rem;
  color: white;
}

.customer-icon {
  background: linear-gradient(135deg, #3498db, #2980b9);
}

.order-icon {
  background: linear-gradient(135deg, #9b59b6, #8e44ad);
}

.opportunity-icon {
  background: linear-gradient(135deg, #2ecc71, #27ae60);
}

.revenue-icon {
  background: linear-gradient(135deg, #e74c3c, #c0392b);
}

.trend-indicator {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  padding: 0.4rem 0.75rem;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 600;
}

.trend-indicator.positive {
  background: #e8f5e8;
  color: #27ae60;
}

.trend-indicator.negative {
  background: #fde8e8;
  color: #e74c3c;
}

.metric-content {
  flex: 1;
}

.metric-value {
  font-size: 2.2rem;
  font-weight: 700;
  color: #2c3e50;
  margin-bottom: 0.5rem;
  line-height: 1;
}

.metric-label {
  color: #7f8c8d;
  font-size: 1rem;
  margin-bottom: 1rem;
}

.metric-footer {
  border-top: 1px solid #f0f0f0;
  padding-top: 1rem;
}

.metric-compare {
  font-size: 0.85rem;
  color: #a0aec0;
}

/* 图表区域 */
.charts-section {
  margin-bottom: 2rem;
}

.charts-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1.5rem;
  margin-bottom: 1.5rem;
}

.secondary-charts {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 1.5rem;
}

.chart-card {
  background: #fff;
  border-radius: 12px;
  padding: 1.75rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
  border: 1px solid #f0f0f0;
}

.chart-card.large-card {
  min-height: 400px;
}

.chart-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}

.chart-title {
  color: #2c3e50;
  font-size: 1.3rem;
  font-weight: 600;
}

.chart-controls {
  display: flex;
  align-items: center;
  gap: 1.5rem;
}

.chart-legend {
  display: flex;
  gap: 1rem;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.85rem;
  color: #7f8c8d;
}

.legend-color {
  width: 12px;
  height: 12px;
  border-radius: 2px;
}

.new-orders {
  background-color: #3498db;
}

.completed-orders {
  background-color: #2ecc71;
}

.customer-growth {
  background-color: #9b59b6;
}

.time-filter {
  padding: 0.5rem 1rem;
  border: 1px solid #e0e6ed;
  border-radius: 6px;
  background: #fff;
  color: #4a5568;
  font-size: 0.9rem;
}

.view-all-btn {
  padding: 0.5rem 1rem;
  background: transparent;
  border: 1px solid #e0e6ed;
  border-radius: 6px;
  color: #5a67d8;
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.3s;
}

.view-all-btn:hover {
  background: #5a67d8;
  color: #fff;
}

/* 柱形图样式 */
.bar-chart-container {
  display: flex;
  height: 300px;
  position: relative;
}

.bar-chart-y-axis {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding-right: 1rem;
  margin-right: 1rem;
  border-right: 1px solid #e0e0e0;
  height: 250px;
}

.y-label {
  font-size: 0.8rem;
  color: #7f8c8d;
  text-align: right;
}

.bar-chart-bars {
  display: flex;
  justify-content: space-around;
  align-items: flex-end;
  flex: 1;
  padding: 0 1rem;
}

.bar-group {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 80px;
}

.bars {
  display: flex;
  align-items: flex-end;
  gap: 8px;
  height: 250px;
  width: 100%;
  position: relative;
}

.bar {
  width: 28px;
  border-radius: 4px 4px 0 0;
  transition: all 0.3s ease;
  position: relative;
  display: flex;
  justify-content: center;
}

.bar:hover {
  opacity: 0.8;
  transform: scaleY(1.05);
}

.bar-value {
  position: absolute;
  top: -25px;
  font-size: 0.8rem;
  font-weight: 600;
  color: #2c3e50;
}

.new-orders-bar {
  background: linear-gradient(to top, #3498db, #5dade2);
}

.completed-orders-bar {
  background: linear-gradient(to top, #2ecc71, #58d68d);
}

.bar-label {
  margin-top: 1rem;
  font-size: 0.9rem;
  color: #7f8c8d;
  font-weight: 500;
}

/* 折线图样式 */
.line-chart-container {
  height: 300px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.line-chart-svg {
  width: 100%;
  height: 250px;
}

.grid-line {
  stroke: #e0e0e0;
  stroke-width: 1;
}

.line-chart-path {
  fill: none;
  stroke: url(#lineGradient);
  stroke-width: 3;
  stroke-linecap: round;
  stroke-linejoin: round;
}

.data-point {
  fill: #9b59b6;
  stroke: #fff;
  stroke-width: 2;
  transition: all 0.3s ease;
}

.data-point:hover {
  r: 7;
  fill: #8e44ad;
}

.data-label {
  font-size: 11px;
  fill: #9b59b6;
  text-anchor: middle;
  font-weight: 600;
}

.axis-label {
  font-size: 11px;
  fill: #7f8c8d;
  text-anchor: middle;
}

/* 环形图样式 */
.pie-chart {
  position: relative;
  width: 160px;
  height: 160px;
  border-radius: 50%;
  background: conic-gradient(
    #3498db 0% 25%,
    #2ecc71 25% 85%,
    #9b59b6 85% 100%
  );
  margin: 0 auto 1.5rem;
}

.pie-center {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100px;
  height: 100px;
  background: white;
  border-radius: 50%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.pie-total {
  font-size: 1.5rem;
  font-weight: 700;
  color: #2c3e50;
}

.pie-label {
  font-size: 0.8rem;
  color: #7f8c8d;
}

.pie-legend {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.pie-legend-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  font-size: 0.9rem;
  color: #2c3e50;
}

.new-customers-color {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: #3498db;
}

.active-customers-color {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: #2ecc71;
}

.vip-customers-color {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: #9b59b6;
}

/* 活动列表样式 */
.activity-list {
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
}

.activity-item {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1rem;
  border-radius: 8px;
  transition: background-color 0.3s;
}

.activity-item:hover {
  background: #f8f9fa;
}

.activity-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border-radius: 8px;
  font-size: 1rem;
  color: white;
  flex-shrink: 0;
}

.activity-icon.order {
  background: #3498db;
}

.activity-icon.customer {
  background: #2ecc71;
}

.activity-icon.payment {
  background: #9b59b6;
}

.activity-icon.support {
  background: #e74c3c;
}

.activity-content {
  flex: 1;
}

.activity-text {
  color: #2c3e50;
  font-weight: 500;
  margin-bottom: 0.25rem;
}

.activity-time {
  font-size: 0.8rem;
  color: #7f8c8d;
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .main-content {
    padding: 1.5rem;
  }
  
  .charts-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .navbar {
    flex-direction: column;
    padding: 1rem;
    gap: 1rem;
  }
  
  .navbar-menu {
    gap: 1rem;
  }
  
  .main-content {
    padding: 1rem;
  }
  
  .page-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }
  
  .metrics-grid {
    grid-template-columns: 1fr;
  }
  
  .secondary-charts {
    grid-template-columns: 1fr;
  }
  
  .chart-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }
  
  .chart-controls {
    width: 100%;
    justify-content: space-between;
  }
  
  .bar-chart-bars {
    padding: 0 0.5rem;
  }
  
  .bar-group {
    width: 50px;
  }
  
  .bar {
    width: 20px;
  }
}
</style>