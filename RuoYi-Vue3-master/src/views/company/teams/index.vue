<template>
  <div class="app-container">
    <!-- 导航栏 -->
    <nav class="navbar">
      <div class="navbar-brand">
        <div class="logo">
          <i class="fas fa-sitemap"></i>
          <h1>部门管理</h1>
        </div>
      </div>
    </nav>

    <!-- 主要内容区域 -->
    <main class="main-content">
      <!-- 页面标题和操作栏 -->
      <div class="page-header">
        <div class="header-content">
          <h2 class="page-title">部门管理</h2>
          <p class="page-subtitle">管理系统组织架构</p>
        </div>
        <div class="actions">
          <button class="btn btn-primary" @click="handleAdd">
            <i class="fas fa-plus"></i>
            新增公司
          </button>
          <button class="btn btn-outline" @click="toggleExpandAll">
            <i class="fas" :class="isExpandAll ? 'fa-compress' : 'fa-expand'"></i>
            {{ isExpandAll ? "折叠全部" : "展开全部" }}
          </button>
          <button class="btn btn-outline" @click="toggleSearch">
            <i class="fas" :class="showSearch ? 'fa-search-minus' : 'fa-search'"></i>
            {{ showSearch ? "隐藏搜索" : "显示搜索" }}
          </button>
        </div>
      </div>

      <!-- 查询条件 -->
      <div v-show="showSearch" class="query-card">
        <div class="query-row">
          <div class="query-group">
            <label class="query-label">部门名称</label>
            <input
              type="text"
              v-model="queryParams.deptName"
              placeholder="请输入部门名称"
              class="query-input"
              @keyup.enter="handleQuery"
            />
          </div>
          <div class="query-group">
            <label class="query-label">状态</label>
            <select v-model="queryParams.status" class="query-select">
              <option value="">全部状态</option>
              <option v-for="dict in sys_normal_disable" :key="dict.value" :value="dict.value">
                {{ dict.label }}
              </option>
            </select>
          </div>
          <div class="query-actions">
            <button class="btn btn-primary" @click="handleQuery">
              <i class="fas fa-search"></i>
              搜索
            </button>
            <button class="btn btn-outline" @click="resetQuery">
              <i class="fas fa-redo"></i>
              重置
            </button>
          </div>
        </div>
      </div>

      <!-- 部门列表 -->
      <div class="content-card">
        <div class="table-container">
          <div v-if="refreshTable && !loading" class="dept-tree">
            <!-- 第一级部门（公司） -->
            <div v-for="dept in deptList" :key="dept.deptId" class="dept-tree-item">
              <div class="dept-item">
                <div class="dept-item-main">
                  <div class="dept-item-content">
                    <div
                      v-if="dept.children && dept.children.length > 0"
                      class="dept-icon"
                      @click="toggleDeptExpand(dept.deptId)"
                    >
                      <i :class="dept._expanded ? 'fas fa-folder-open' : 'fas fa-folder'"></i>
                    </div>
                    <div v-else class="dept-icon">
                      <i class="fas fa-folder"></i>
                    </div>

                    <div class="dept-info">
                      <div class="dept-name">
                        {{ dept.deptName }}
                        <span class="order-num">排序：{{ dept.orderNum }}</span>
                      </div>
                      <div class="dept-details">
                        <span class="status-badge" :class="dept.status === '0' ? 'active' : 'inactive'">
                          {{ getStatusText(dept.status) }}
                        </span>
                        <span class="create-time">创建：{{ formatTime(dept.createTime) }}</span>
                      </div>
                    </div>
                  </div>

                  <div class="dept-actions">
                    <button class="btn-action detail" @click="handleDetail(dept)">
                      <i class="fas fa-info-circle"></i>
                      详情
                    </button>
                    <button class="btn-action edit" @click="handleUpdate(dept)">
                      <i class="fas fa-edit"></i>
                      修改
                    </button>
                    <button class="btn-action add" @click="handleAdd(dept)">
                      <i class="fas fa-plus"></i>
                      新增子部门
                    </button>
                    <button v-if="dept.parentId != 0" class="btn-action delete" @click="handleDelete(dept)">
                      <i class="fas fa-trash"></i>
                      删除
                    </button>
                  </div>
                </div>
              </div>

              <!-- 第二级部门 -->
              <div
                v-if="dept.children && dept.children.length > 0 && dept._expanded"
                class="dept-children"
                style="margin-left: 3rem;"
              >
                <div v-for="child in dept.children" :key="child.deptId" class="dept-child-item">
                  <div class="dept-item">
                    <div class="dept-item-main">
                      <div class="dept-item-content">
                        <div
                          v-if="child.children && child.children.length > 0"
                          class="dept-icon"
                          @click="toggleDeptExpand(child.deptId)"
                        >
                          <i :class="child._expanded ? 'fas fa-folder-open' : 'fas fa-folder'"></i>
                        </div>
                        <div v-else class="dept-icon">
                          <i class="fas fa-folder"></i>
                        </div>

                        <div class="dept-info">
                          <div class="dept-name">
                            {{ child.deptName }}
                            <span class="order-num">排序：{{ child.orderNum }}</span>
                          </div>
                          <div class="dept-details">
                            <span class="status-badge" :class="child.status === '0' ? 'active' : 'inactive'">
                              {{ getStatusText(child.status) }}
                            </span>
                            <span class="create-time">创建：{{ formatTime(child.createTime) }}</span>
                          </div>
                        </div>
                      </div>

                      <div class="dept-actions">
                        <button class="btn-action detail" @click="handleDetail(child)">
                          <i class="fas fa-info-circle"></i>
                          详情
                        </button>
                        <button class="btn-action edit" @click="handleUpdate(child)">
                          <i class="fas fa-edit"></i>
                          修改
                        </button>
                        <button class="btn-action add" @click="handleAdd(child)">
                          <i class="fas fa-plus"></i>
                          新增子部门
                        </button>
                        <button class="btn-action delete" @click="handleDelete(child)">
                          <i class="fas fa-trash"></i>
                          删除
                        </button>
                      </div>
                    </div>
                  </div>

                  <!-- 第三级部门 -->
                  <div
                    v-if="child.children && child.children.length > 0 && child._expanded"
                    class="dept-children"
                    style="margin-left: 3rem; border-left: 2px dashed #e8e8e8; padding-left: 1.5rem;"
                  >
                    <div v-for="grandChild in child.children" :key="grandChild.deptId" class="dept-child-item">
                      <div class="dept-item">
                        <div class="dept-item-main">
                          <div class="dept-item-content">
                            <div class="dept-icon">
                              <i class="fas fa-folder"></i>
                            </div>
                            <div class="dept-info">
                              <div class="dept-name">
                                {{ grandChild.deptName }}
                                <span class="order-num">排序：{{ grandChild.orderNum }}</span>
                              </div>
                              <div class="dept-details">
                                <span class="status-badge" :class="grandChild.status === '0' ? 'active' : 'inactive'">
                                  {{ getStatusText(grandChild.status) }}
                                </span>
                                <span class="create-time">创建：{{ formatTime(grandChild.createTime) }}</span>
                              </div>
                            </div>
                          </div>

                          <div class="dept-actions">
                            <button class="btn-action detail" @click="handleDetail(grandChild)">
                              <i class="fas fa-info-circle"></i>
                              详情
                            </button>
                            <button class="btn-action edit" @click="handleUpdate(grandChild)">
                              <i class="fas fa-edit"></i>
                              修改
                            </button>
                            <button class="btn-action add" @click="handleAdd(grandChild)">
                              <i class="fas fa-plus"></i>
                              新增子部门
                            </button>
                            <button class="btn-action delete" @click="handleDelete(grandChild)">
                              <i class="fas fa-trash"></i>
                              删除
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- /第三级 -->
                </div>
              </div>
              <!-- /第二级 -->
            </div>
          </div>

          <!-- 加载状态 -->
          <div v-if="loading" class="loading-state">
            <div class="loading-spinner">
              <i class="fas fa-spinner fa-spin"></i>
            </div>
            <p>正在加载部门数据...</p>
          </div>

          <!-- 空状态 -->
          <div v-if="!loading && deptList.length === 0" class="empty-state">
            <i class="fas fa-sitemap empty-icon"></i>
            <p>暂无部门数据</p>
            <button class="btn btn-outline mt-3" @click="handleAdd">
              <i class="fas fa-plus"></i>
              立即创建部门
            </button>
          </div>
        </div>
      </div>
    </main>

    <!-- 添加或修改部门弹窗 -->
    <div v-if="open" class="modal-overlay" @click="cancel">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3>{{ title }}</h3>
          <button class="close-btn" @click="cancel">
            <i class="fas fa-times"></i>
          </button>
        </div>

        <div class="modal-body">
          <form @submit.prevent="submitForm" class="dept-form">
            <!-- 上级部门选择 -->
            <div class="form-group">
              <label class="form-label required">上级部门</label>
              <div class="tree-select">
                <input
                  type="text"
                  :value="getDeptName(form.parentId)"
                  readonly
                  class="form-input"
                  placeholder="选择上级部门"
                  @click="toggleTreeSelect"
                />
                <button type="button" class="tree-select-toggle" @click="toggleTreeSelect">
                  <i class="fas" :class="showTreeSelect ? 'fa-chevron-up' : 'fa-chevron-down'"></i>
                </button>

                <div v-show="showTreeSelect" class="tree-select-dropdown" @click.stop>
                  <div class="tree-search">
                    <input type="text" v-model="treeSearch" placeholder="搜索部门" class="tree-search-input" />
                  </div>

                  <div class="tree-list">
                    <div
                      v-for="dept in filteredDeptOptions"
                      :key="dept.deptId"
                      class="tree-item"
                      :class="{ 'tree-item-root': String(dept.deptId) === '0' }"
                      :style="{ 'padding-left': `${(dept.level || 0) * 18 + 12}px` }"
                      @click="selectDept(dept)"
                    >
                      <i class="fas" :class="String(dept.deptId) === '0' ? 'fa-home' : 'fa-folder'"></i>
                      <span>{{ dept.deptName }}</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="input-hint">ancestors：{{ form.ancestors || "-" }}</div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label required">部门名称</label>
                <input type="text" v-model="form.deptName" placeholder="请输入部门名称" class="form-input" required />
              </div>

              <div class="form-group">
                <label class="form-label required">显示排序</label>
                <input
                  type="number"
                  v-model.number="form.orderNum"
                  placeholder="系统将自动建议排序"
                  min="0"
                  class="form-input"
                  :readonly="!!form.deptId"
                  required
                />
                <div class="input-hint">提示：新增时自动按同级最大+1建议；编辑时保持只读更贴近自动维护</div>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label">负责人</label>
                <select v-model="form.leaderId" class="form-input">
                  <option value="">请选择负责人</option>
                  <option v-for="u in leaderOptions" :key="u.userId" :value="u.userId">
                    {{ u.nickName || u.userName }}（{{ u.userName }} / ID: {{ u.userId }}）
                  </option>
                </select>
                <div class="input-hint" v-if="leaderLoading">负责人列表加载中...</div>
              </div>

              <div class="form-group">
                <label class="form-label">联系电话</label>
                <input
                  type="tel"
                  v-model="form.phone"
                  placeholder="请输入联系电话"
                  class="form-input"
                  maxlength="11"
                  pattern="^1[3|4|5|6|7|8|9][0-9]\d{8}$"
                />
                <div class="input-hint">11位手机号码</div>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label">邮箱</label>
                <input type="email" v-model="form.email" placeholder="请输入邮箱" class="form-input" maxlength="50" />
              </div>

              <div class="form-group">
                <label class="form-label">部门状态</label>
                <div class="status-radio-group">
                  <label v-for="dict in sys_normal_disable" :key="dict.value" class="status-radio">
                    <input type="radio" v-model="form.status" :value="dict.value" class="radio-input" />
                    <span class="radio-label">{{ dict.label }}</span>
                  </label>
                </div>
              </div>
            </div>

            <!-- 备注 -->
            <div class="form-group">
              <label class="form-label">备注</label>
              <textarea v-model="form.remark" placeholder="请输入备注" class="form-textarea" rows="3" maxlength="500"></textarea>
            </div>

            <div class="form-actions">
              <button type="button" class="btn btn-outline" @click="cancel">取消</button>
              <button type="submit" class="btn btn-primary">{{ form.deptId ? "确认修改" : "确认添加" }}</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- 删除确认弹窗 -->
    <div v-if="showDeleteConfirm" class="modal-overlay" @click="cancelDelete">
      <div class="modal-content confirm-modal" @click.stop>
        <div class="modal-header">
          <h3><i class="fas fa-exclamation-triangle text-warning"></i> 确认删除</h3>
          <button class="close-btn" @click="cancelDelete">
            <i class="fas fa-times"></i>
          </button>
        </div>

        <div class="modal-body">
          <div class="confirm-content">
            <i class="fas fa-trash-alt confirm-icon"></i>
            <p class="confirm-message">
              确定要删除部门 <strong>"{{ deleteDeptName }}"</strong> 吗？
            </p>
            <p class="confirm-warning">删除后，该部门下的所有子部门和相关员工信息将无法恢复！</p>
          </div>

          <div class="confirm-actions">
            <button type="button" class="btn btn-outline" @click="cancelDelete">取消</button>
            <button type="button" class="btn btn-danger" @click="confirmDelete">确认删除</button>
          </div>
        </div>
      </div>
    </div>

    <!-- ✅ FIX 1：把“详情弹窗”从 app-container 外面移进来，保证 template 单根 -->
    <!-- 详情弹窗：显示备注 + 负责人信息 -->
    <div v-if="detailVisible" class="modal-overlay" @click="closeDetail">
      <div class="modal-content detail-modal" @click.stop>
        <div class="modal-header">
          <h3>
            <i class="fas fa-info-circle"></i>
            部门详情
          </h3>
          <button class="close-btn" @click="closeDetail">
            <i class="fas fa-times"></i>
          </button>
        </div>

        <div class="modal-body">
          <div v-if="detailLoading" class="loading-state" style="padding: 2rem;">
            <div class="loading-spinner">
              <i class="fas fa-spinner fa-spin"></i>
            </div>
            <p>正在加载详情...</p>
          </div>

          <div v-else class="detail-body">
            <div class="detail-grid">
              <div class="detail-item">
                <div class="detail-label">名称</div>
                <div class="detail-value">{{ detailDeptName || "-" }}</div>
              </div>

              <div class="detail-item">
                <div class="detail-label">负责人</div>
                <div class="detail-value">
                  {{ detailLeader || "（未设置）" }}
                  <span v-if="detailLeaderId" class="detail-sub">ID: {{ detailLeaderId }}</span>
                </div>
              </div>

              <div class="detail-item">
                <div class="detail-label">电话</div>
                <div class="detail-value">{{ detailPhone || "-" }}</div>
              </div>

              <div class="detail-item">
                <div class="detail-label">邮箱</div>
                <div class="detail-value detail-email" :title="detailEmail || ''">
                  {{ detailEmail || "-" }}
                </div>
              </div>

              <div class="detail-item detail-span-2">
                <div class="detail-label">备注</div>
                <div class="detail-value detail-remark">
                  {{ detailRemark && detailRemark.trim() ? detailRemark : "（无备注）" }}
                </div>
              </div>
            </div>

            <div class="form-actions" style="margin-top: 1.5rem;">
              <button type="button" class="btn btn-primary" @click="closeDetail">确认</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- ✅ /FIX 1 -->
  </div>
</template>

<script setup>
import {
  ref,
  reactive,
  toRefs,
  computed,
  nextTick,
  getCurrentInstance,
  onMounted,
  onActivated,
  onDeactivated,
} from "vue";
import request from "@/utils/request";
import useUserStore from "@/store/modules/user";

const { proxy } = getCurrentInstance();
const { sys_normal_disable } = proxy.useDict("sys_normal_disable");

/* =========================
   Teams API（你确认可用）
   - 列表：GET    /company/teams/list
   - 新增：POST   /company/teams/add
   - 修改：PUT    /company/teams/update（若 405 自动降级 POST）
   - 详情：GET    /company/teams/{id}   （避免 /detail /get /index 触发 Long 转换错误）
   - 删除：DELETE /company/teams/{ids}  （后端提示参数名 ids 且类型 Long[]）
   ========================= */
const apiTeamsList = (params) => request({ url: "/company/teams/list", method: "get", params });

const apiTeamsGetById = (id) => request({ url: `/company/teams/${id}`, method: "get" });

async function apiTeamsAdd(data) {
  try {
    return await request({ url: "/company/teams/add", method: "post", data });
  } catch (e) {
    const status = e?.response?.status;
    const msg = e?.response?.data?.msg || e?.message || "";
    if (status === 405 || String(msg).includes("POST") || String(msg).includes("not supported")) {
      return await request({ url: "/company/teams/add", method: "put", data });
    }
    throw e;
  }
}

async function apiTeamsUpdate(data) {
  try {
    return await request({ url: "/company/teams/update", method: "put", data });
  } catch (e) {
    const status = e?.response?.status;
    const msg = e?.response?.data?.msg || e?.message || "";
    if (status === 405 || String(msg).includes("PUT") || String(msg).includes("not supported")) {
      return await request({ url: "/company/teams/update", method: "post", data });
    }
    throw e;
  }
}

/** 删除：支持单个/多个 id（后端 Long[] ids：/company/teams/1 或 /company/teams/1,2,3） */
async function apiTeamsDelete(ids) {
  const idsStr = Array.isArray(ids) ? ids.join(",") : String(ids);
  return request({ url: `/company/teams/${idsStr}`, method: "delete" });
}

/* ---------------- 负责人下拉：从公司人员拉取 ---------------- */
const listLeaderUsers = (params) => request({ url: "/company/staff/list", method: "get", params });

const leaderOptions = ref([]);
const leaderLoading = ref(false);
const leaderLoaded = ref(false);

async function loadLeaderOptions() {
  leaderLoading.value = true;
  try {
    const res = await listLeaderUsers({ pageNum: 1, pageSize: 9999 });
    const rows = res?.rows || res?.data?.rows || res?.data?.data?.rows || [];
    leaderOptions.value = rows.map((u) => ({
      userId: u.userId,
      userName: u.userName,
      nickName: u.nickName,
      email: u.email,
      phonenumber: u.phonenumber,
      phone: u.phonenumber,
    }));
  } finally {
    leaderLoading.value = false;
  }
}

async function ensureLeaderOptions() {
  if (leaderLoaded.value) return;
  await loadLeaderOptions();
  leaderLoaded.value = true;
}

/* ---------------- 当前用户ID ---------------- */
const userStore = useUserStore();
const currentUserId = computed(() => userStore?.userId ?? userStore?.user?.userId ?? userStore?.id);

/* ---------------- 响应式数据 ---------------- */
const deptList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const title = ref("");
const deptOptions = ref([]);
const isExpandAll = ref(true);
const refreshTable = ref(true);
const showTreeSelect = ref(false);
const treeSearch = ref("");

const showDeleteConfirm = ref(false);
const deleteIds = ref(null); // 注意：改成 ids（不是 userId）
const deleteDeptName = ref("");

const data = reactive({
  form: {
    deptId: undefined,
    parentId: undefined,
    ancestors: "0",
    deptName: undefined,
    orderNum: 0,
    userId: undefined,
    leaderId: undefined,
    leader: undefined,
    phone: undefined,
    email: undefined,
    remark: "",
    status: "0",
  },
  queryParams: {
    deptName: undefined,
    status: undefined,
  },
});

const { queryParams, form } = toRefs(data);

/* =========================
   工具：兼容不同后端返回结构 + 字段归一化 + buildTree
   ========================= */

function pickArrayFromResponse(res) {
  if (!res) return [];
  if (Array.isArray(res)) return res;

  const r = res?.data ?? res;
  if (Array.isArray(r)) return r;
  if (Array.isArray(r?.data)) return r.data;
  if (Array.isArray(r?.rows)) return r.rows;
  if (Array.isArray(r?.list)) return r.list;
  if (Array.isArray(r?.records)) return r.records;
  return [];
}

/** 把 teams 的字段统一映射成页面用的 dept* 字段（避免树组不起来） */
function normalizeTeam(raw) {
  const deptId = raw?.deptId ?? raw?.teamId ?? raw?.id;
  const parentId = raw?.parentId ?? raw?.pid ?? raw?.parent_id ?? raw?.pId ?? 0;

  return {
    ...raw,
    deptId,
    parentId: Number(parentId ?? 0),
    deptName: raw?.deptName ?? raw?.teamName ?? raw?.name ?? "",
    orderNum: Number(raw?.orderNum ?? raw?.order ?? raw?.sort ?? 0),
    status: raw?.status != null ? String(raw.status) : "0",
    createTime: raw?.createTime ?? raw?.create_time,
    remark: raw?.remark ?? "",
    ancestors: raw?.ancestors ?? raw?.ancestor ?? null,
    leaderId: raw?.leaderId ?? raw?.leader_id ?? null,
    leader: raw?.leader ?? "",
    phone: raw?.phone ?? raw?.phonenumber ?? "",
    email: raw?.email ?? "",
    userId: raw?.userId ?? null, // 保留原字段（不再用于删除）
  };
}

function normalizeTree(nodes) {
  return (nodes || []).map((n) => {
    const nn = normalizeTeam(n);
    if (Array.isArray(n.children)) nn.children = normalizeTree(n.children);
    return nn;
  });
}

/** 从扁平数组构建树：children 挂载到 parent */
function buildTreeFromFlat(list) {
  const nodes = (list || [])
    .map(normalizeTeam)
    .filter((x) => x.deptId !== undefined && x.deptId !== null);

  const map = new Map();
  nodes.forEach((n) => map.set(Number(n.deptId), { ...n, children: [] }));

  const roots = [];
  map.forEach((node) => {
    const pid = Number(node.parentId ?? 0);
    if (pid !== 0 && map.has(pid)) {
      map.get(pid).children.push(node);
    } else {
      roots.push(node);
    }
  });

  const sortRec = (arr) => {
    arr.sort((a, b) => Number(a.orderNum ?? 0) - Number(b.orderNum ?? 0));
    arr.forEach((x) => x.children?.length && sortRec(x.children));
  };
  sortRec(roots);

  return roots;
}

function toTree(list) {
  if (!list || !list.length) return [];
  const hasChildren = list.some((x) => Array.isArray(x?.children) && x.children.length > 0);
  return hasChildren ? normalizeTree(list) : buildTreeFromFlat(list);
}

/* ---------------- 列表加载（树） ---------------- */
async function getList() {
  loading.value = true;
  try {
    const res = await apiTeamsList(queryParams.value);
    const rawList = pickArrayFromResponse(res);
    const tree = toTree(rawList);

    const initExpandStatus = (depts) =>
      (depts || []).map((d) => ({
        ...d,
        _expanded: isExpandAll.value,
        children: d.children?.length ? initExpandStatus(d.children) : d.children,
      }));

    deptList.value = initExpandStatus(tree);
  } finally {
    loading.value = false;
  }
}

/* ✅ FIX 2：避免切走/切回时 refreshTable 卡死为 false 导致“空白” */
onActivated(() => {
  if (!refreshTable.value) refreshTable.value = true;
});
onDeactivated(() => {
  if (!refreshTable.value) refreshTable.value = true;
});
/* ✅ /FIX 2 */

/* ---------------- 辅助：状态/时间 ---------------- */
function getStatusText(status) {
  const dict = sys_normal_disable.value?.find((item) => item.value === status);
  return dict?.label || "未知";
}

function formatTime(time) {
  if (!time) return "-";
  return new Date(time).toLocaleString("zh-CN", {
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  });
}

/* ---------------- 上级部门：树选择 + ancestors ---------------- */
function findDeptById(depts, id) {
  const target = Number(id);
  for (const d of depts || []) {
    if (Number(d.deptId) === target) return d;
    const child = findDeptById(d.children, target);
    if (child) return child;
  }
  return null;
}

function buildAncestors(parentId) {
  const pid = Number(parentId ?? 0);
  if (pid === 0) return "0";
  const parent = findDeptById(deptOptions.value, pid);
  if (parent && parent.ancestors) return `${parent.ancestors},${pid}`;
  return `0,${pid}`;
}

function getDeptName(deptId) {
  const id = Number(deptId ?? 0);
  if (id === 0) return "顶级部门";
  const found = findDeptById(deptOptions.value, id);
  return found?.deptName || "";
}

function toggleTreeSelect() {
  showTreeSelect.value = !showTreeSelect.value;
  if (!showTreeSelect.value) treeSearch.value = "";
}

function flattenDeptOptions(nodes, level = 0, arr = []) {
  (nodes || []).forEach((n) => {
    arr.push({
      deptId: n.deptId,
      deptName: n.deptName,
      parentId: n.parentId ?? 0,
      level,
      ancestors: n.ancestors,
    });
    if (n.children?.length) flattenDeptOptions(n.children, level + 1, arr);
  });
  return arr;
}

const flatDeptOptions = computed(() => {
  const root = [{ deptId: 0, deptName: "顶级部门", parentId: -1, level: 0, ancestors: "0" }];
  return root.concat(flattenDeptOptions(deptOptions.value, 1, []));
});

const filteredDeptOptions = computed(() => {
  const term = (treeSearch.value || "").trim().toLowerCase();
  if (!term) return flatDeptOptions.value;
  return flatDeptOptions.value.filter((d) => {
    if (String(d.deptId) === "0") return true;
    return String(d.deptName || "").toLowerCase().includes(term);
  });
});

function suggestOrderNum(pid) {
  const parentId = Number(pid ?? 0);

  const findNode = (nodes) => {
    for (const n of nodes || []) {
      if (Number(n.deptId) === parentId) return n;
      const found = findNode(n.children);
      if (found) return found;
    }
    return null;
  };

  const siblings = parentId === 0 ? deptList.value || [] : findNode(deptList.value)?.children || [];
  const maxVal = (siblings || []).reduce((m, c) => Math.max(m, Number(c.orderNum ?? 0)), -1);
  return Math.max(0, maxVal + 1);
}

function selectDept(dept) {
  const pid = Number(dept.deptId);
  form.value.parentId = pid;
  form.value.ancestors = buildAncestors(pid);

  if (!form.value.deptId) {
    form.value.orderNum = suggestOrderNum(pid);
  }

  showTreeSelect.value = false;
  treeSearch.value = "";
}

/* ---------------- 弹窗：reset/cancel ---------------- */
function reset() {
  form.value = {
    deptId: undefined,
    parentId: undefined,
    ancestors: "0",
    deptName: undefined,
    orderNum: 0,
    userId: undefined,
    leaderId: undefined,
    leader: undefined,
    phone: undefined,
    email: undefined,
    remark: "",
    status: "0",
  };
}

function cancel() {
  open.value = false;
  reset();
  showTreeSelect.value = false;
  treeSearch.value = "";
}

/* ---------------- 搜索/重置 ---------------- */
function handleQuery() {
  getList();
}

function resetQuery() {
  queryParams.value.deptName = "";
  queryParams.value.status = "";
  handleQuery();
}

function toggleSearch() {
  showSearch.value = !showSearch.value;
}

/* ---------------- 展开/折叠 ---------------- */
function toggleDeptExpand(deptId) {
  const target = Number(deptId);

  const toggle = (depts) => {
    for (const dept of depts || []) {
      if (Number(dept.deptId) === target) {
        dept._expanded = !dept._expanded;
        return true;
      }
      if (dept.children?.length) {
        if (toggle(dept.children)) return true;
      }
    }
    return false;
  };

  toggle(deptList.value);
  refreshTable.value = false;
  nextTick(() => (refreshTable.value = true));
}

function toggleExpandAll() {
  isExpandAll.value = !isExpandAll.value;

  const setAllExpand = (depts, expand) => {
    (depts || []).forEach((dept) => {
      dept._expanded = expand;
      if (dept.children?.length) setAllExpand(dept.children, expand);
    });
  };

  setAllExpand(deptList.value, isExpandAll.value);
  refreshTable.value = false;
  nextTick(() => (refreshTable.value = true));
}

/* ---------------- deptOptions 加载 ---------------- */
async function loadDeptOptions() {
  const res = await apiTeamsList({});
  const raw = pickArrayFromResponse(res);
  deptOptions.value = toTree(raw);
}

/* ---------------- 新增/修改 ---------------- */
const DEFAULT_COMPANY_PARENT_ID = 110;

async function handleAdd(row) {
  reset();
  await ensureLeaderOptions();
  await loadDeptOptions();

  if (row === undefined) {
    const exists = findDeptById(deptOptions.value, DEFAULT_COMPANY_PARENT_ID);
    const pid = exists ? DEFAULT_COMPANY_PARENT_ID : 0;
    form.value.parentId = pid;
    form.value.ancestors = buildAncestors(pid);
    form.value.orderNum = suggestOrderNum(pid);
  } else {
    const pid = Number(row.deptId);
    form.value.parentId = pid;
    form.value.ancestors = buildAncestors(pid);
    form.value.orderNum = suggestOrderNum(pid);
  }

  open.value = true;
  title.value = "添加部门";
}

async function handleUpdate(row) {
  reset();
  await ensureLeaderOptions();
  await loadDeptOptions();

  let d = {};
  try {
    const res = await apiTeamsGetById(row.deptId ?? row.id ?? row.teamId);
    d = res?.data ?? res?.data?.data ?? res ?? {};
  } catch (e) {
    d = row || {};
  }

  d = normalizeTeam(d);

  let lid = d.leaderId;
  if (!lid && d.leader) {
    const hit = leaderOptions.value.find((u) => (u.nickName || u.userName) === String(d.leader));
    if (hit) lid = hit.userId;
  }

  form.value = {
    deptId: d.deptId ?? row.deptId,
    parentId: Number(d.parentId ?? row.parentId ?? 0),
    ancestors: d.ancestors || buildAncestors(Number(d.parentId ?? row.parentId ?? 0)),
    deptName: d.deptName || row.deptName || "",
    orderNum: Number(d.orderNum ?? row.orderNum ?? 0),
    userId: d.userId ?? row.userId ?? currentUserId.value,
    leaderId: lid ?? "",
    leader: d.leader != null ? String(d.leader) : "",
    phone: d.phone || row.phone || "",
    email: d.email || row.email || "",
    remark: d.remark || row.remark || "",
    status: d.status != null ? String(d.status) : String(row.status ?? "0"),
  };

  open.value = true;
  title.value = "修改部门";
}

/* ---------------- 提交 ---------------- */
async function submitForm() {
  if (!form.value.deptName || !form.value.deptName.trim()) {
    alert("部门名称不能为空！");
    return;
  }
  if (form.value.parentId === undefined || form.value.parentId === null) {
    alert("请选择上级部门！");
    return;
  }
  if (form.value.orderNum === undefined || form.value.orderNum === null || Number(form.value.orderNum) < 0) {
    alert("排序必须大于等于0！");
    return;
  }

  const submitData = { ...form.value };

  submitData.parentId = Number(submitData.parentId ?? 0);
  submitData.orderNum = Number(submitData.orderNum ?? 0);
  submitData.status = Number(submitData.status ?? 0);

  submitData.ancestors = buildAncestors(submitData.parentId);
  submitData.userId = currentUserId.value ?? submitData.userId;

  submitData.leaderId = submitData.leaderId ? Number(submitData.leaderId) : null;
  if (submitData.leaderId) {
    const u = leaderOptions.value.find((x) => Number(x.userId) === submitData.leaderId);
    submitData.leader = u ? u.nickName || u.userName || "" : submitData.leader || "";
  } else {
    submitData.leader = submitData.leader ? String(submitData.leader) : null;
  }

  submitData.remark = String(submitData.remark ?? "");

  console.log("提交payload=", JSON.parse(JSON.stringify(submitData)));

  try {
    if (submitData.deptId !== undefined && submitData.deptId !== null) {
      await apiTeamsUpdate(submitData);
      alert("修改成功！");
    } else {
      await apiTeamsAdd(submitData);
      alert("新增成功！");
    }
    open.value = false;
    await getList();
  } catch (err) {
    alert((submitData.deptId ? "修改失败：" : "新增失败：") + (err?.response?.data?.msg || err?.message || "未知错误"));
  }
}

/* ---------------- 删除（修复：用 deptId/id，不用 userId） ---------------- */
function resolveDeleteId(row) {
  return row?.deptId ?? row?.id ?? row?.teamId ?? null;
}

function handleDelete(row) {
  const id = resolveDeleteId(row);
  if (!id) {
    alert("删除失败：该记录缺少 deptId/id/teamId，无法调用 /company/teams/{ids} 删除接口");
    return;
  }
  deleteIds.value = id; // 单删直接存一个 id
  deleteDeptName.value = row?.deptName || "";
  showDeleteConfirm.value = true;
}

async function confirmDelete() {
  if (!deleteIds.value) {
    alert("删除失败：ids 为空");
    return;
  }

  try {
    await apiTeamsDelete(deleteIds.value); // DELETE /company/teams/{ids}
    alert("删除成功！");
    showDeleteConfirm.value = false;
    deleteIds.value = null;
    deleteDeptName.value = "";
    await getList();
  } catch (err) {
    alert("删除失败：" + (err?.response?.data?.msg || err?.message || "未知错误"));
    showDeleteConfirm.value = false;
  }
}

function cancelDelete() {
  showDeleteConfirm.value = false;
  deleteIds.value = null;
  deleteDeptName.value = "";
}

/* ---------------- 详情 ---------------- */
const detailVisible = ref(false);
const detailLoading = ref(false);
const detailDeptName = ref("");
const detailRemark = ref("");
const detailLeader = ref("");
const detailLeaderId = ref(null);
const detailPhone = ref("");
const detailEmail = ref("");

async function handleDetail(row) {
  detailVisible.value = true;
  detailLoading.value = true;

  detailDeptName.value = row?.deptName || "";
  detailRemark.value = String(row?.remark ?? "");
  detailLeader.value = String(row?.leader ?? "");
  detailLeaderId.value = row?.leaderId ?? null;
  detailPhone.value = String(row?.phone ?? "");
  detailEmail.value = String(row?.email ?? "");

  try {
    const id = resolveDeleteId(row);
    if (!id) return;

    const res = await apiTeamsGetById(id);
    const dept = normalizeTeam(res?.data ?? res?.data?.data ?? res ?? {});

    detailDeptName.value = dept?.deptName || detailDeptName.value;
    detailLeader.value = String(dept?.leader ?? detailLeader.value ?? "");
    detailLeaderId.value = dept?.leaderId ?? detailLeaderId.value ?? null;
    detailPhone.value = String(dept?.phone ?? detailPhone.value ?? "");
    detailEmail.value = String(dept?.email ?? detailEmail.value ?? "");

    const r = dept?.remark;
    if (r !== undefined && r !== null && String(r).trim() !== "") {
      detailRemark.value = String(r);
    }
  } catch (e) {
    console.error("加载详情失败:", e);
  } finally {
    detailLoading.value = false;
  }
}

function closeDetail() {
  detailVisible.value = false;
  detailLoading.value = false;
  detailDeptName.value = "";
  detailRemark.value = "";
  detailLeader.value = "";
  detailLeaderId.value = null;
  detailPhone.value = "";
  detailEmail.value = "";
}

/* ---------------- 初始化 ---------------- */
onMounted(async () => {
  await getList();
  await ensureLeaderOptions();
});
</script>

<style scoped>
/* 复用基础样式 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Segoe UI", "Microsoft YaHei", sans-serif;
}

.app-container {
  min-height: 100vh;
  background-color: #f5f7fa;
}

/* 导航栏 */
.navbar {
  display: flex;
  justify-content: center;
  padding: 1rem 2rem;
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
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
  color: #1890ff;
}

.navbar-brand h1 {
  font-size: 1.5rem;
  color: #2c3e50;
  font-weight: 700;
}

/* 主内容区域 */
.main-content {
  padding: 1.5rem;
  max-width: 1400px;
  margin: 0 auto;
}

/* 页面标题 */
.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}

.page-title {
  font-size: 1.8rem;
  color: #2c3e50;
  font-weight: 700;
  margin-bottom: 0.25rem;
}

.page-subtitle {
  font-size: 1rem;
  color: #7f8c8d;
}

.actions {
  display: flex;
  gap: 1rem;
}

/* 按钮样式 */
.btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.6rem 1.2rem;
  border: none;
  border-radius: 6px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s;
  font-size: 0.85rem;
}

.btn-primary {
  background-color: #1890ff;
  color: #fff;
}

.btn-primary:hover {
  background-color: #40a9ff;
  box-shadow: 0 2px 8px rgba(24, 144, 255, 0.3);
}

.btn-outline {
  background-color: transparent;
  border: 1px solid #d9d9d9;
  color: #595959;
}

.btn-outline:hover {
  border-color: #1890ff;
  color: #1890ff;
}

.btn-danger {
  background-color: #ff4d4f;
  color: #fff;
}

.btn-danger:hover {
  background-color: #ff7875;
  box-shadow: 0 2px 8px rgba(255, 77, 79, 0.3);
}

/* 查询卡片 */
.query-card {
  background-color: #fff;
  border-radius: 8px;
  padding: 1.5rem;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  margin-bottom: 1.5rem;
}

.query-row {
  display: flex;
  align-items: flex-end;
  gap: 1.5rem;
  flex-wrap: wrap;
}

.query-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  min-width: 200px;
  flex: 1;
  max-width: 300px;
}

.query-label {
  font-size: 0.9rem;
  color: #2c3e50;
  font-weight: 500;
}

.query-input,
.query-select {
  padding: 0.6rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  font-size: 0.85rem;
  transition: border-color 0.3s;
}

.query-input:focus,
.query-select:focus {
  outline: none;
  border-color: #1890ff;
  box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.1);
}

.query-actions {
  display: flex;
  gap: 0.75rem;
  margin-left: auto;
  margin-bottom: 0.6rem;
}

/* 内容卡片 */
.content-card {
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  overflow: hidden;
  min-height: 300px;
}

/* 部门树样式 */
.dept-tree {
  padding: 1rem;
}

.dept-tree-item {
  margin-bottom: 0.5rem;
}

.dept-item {
  border: 1px solid #e8e8e8;
  border-radius: 8px;
  margin-bottom: 0.5rem;
  transition: all 0.3s;
  background-color: #fff;
}

.dept-item:hover {
  border-color: #1890ff;
  box-shadow: 0 2px 8px rgba(24, 144, 255, 0.1);
}

.dept-item-main {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 1.5rem;
}

.dept-item-content {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex: 1;
}

.dept-icon {
  width: 36px;
  height: 36px;
  border-radius: 8px;
  background-color: #e6f7ff;
  color: #1890ff;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s;
  flex-shrink: 0;
}

.dept-icon:hover {
  background-color: #bae7ff;
}

.dept-info {
  flex: 1;
  min-width: 0;
}

.dept-name {
  font-size: 1rem;
  color: #2c3e50;
  font-weight: 600;
  margin-bottom: 0.25rem;
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.order-num {
  font-size: 0.85rem;
  color: #8c8c8c;
  font-weight: normal;
}

.dept-details {
  display: flex;
  gap: 1.5rem;
  align-items: center;
  flex-wrap: wrap;
}

.status-badge {
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 500;
  display: inline-block;
  white-space: nowrap;
}

.status-badge.active {
  background-color: #f6ffed;
  color: #52c41a;
  border: 1px solid #b7eb8f;
}

.status-badge.inactive {
  background-color: #fff2f0;
  color: #ff4d4f;
  border: 1px solid #ffccc7;
}

.create-time {
  font-size: 0.85rem;
  color: #8c8c8c;
  white-space: nowrap;
}

.dept-actions {
  display: flex;
  gap: 0.5rem;
  flex-shrink: 0;
}

.btn-action {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.4rem 0.8rem;
  border-radius: 4px;
  font-size: 0.8rem;
  font-weight: 500;
  cursor: pointer;
  border: none;
  min-width: 80px;
  justify-content: center;
  transition: all 0.3s;
  white-space: nowrap;
}

.btn-action.edit {
  background-color: #e6f7ff;
  color: #1890ff;
  border: 1px solid #91d5ff;
}

.btn-action.edit:hover {
  background-color: #bae7ff;
}

.btn-action.add {
  background-color: #f6ffed;
  color: #52c41a;
  border: 1px solid #b7eb8f;
}

.btn-action.add:hover {
  background-color: #d9f7be;
}

.btn-action.delete {
  background-color: #fff2f0;
  color: #ff4d4f;
  border: 1px solid #ffccc7;
}

.btn-action.delete:hover {
  background-color: #ffccc7;
}

.btn-action.detail {
  background-color: #f0f5ff;
  color: #2f54eb;
  border: 1px solid #adc6ff;
}

.btn-action.detail:hover {
  background-color: #d6e4ff;
}

.dept-children {
  margin-top: 0.5rem;
}

.dept-child-item {
  margin-top: 0.5rem;
}

/* 加载状态 */
.loading-state {
  padding: 3rem;
  text-align: center;
  color: #1890ff;
}

.loading-spinner {
  font-size: 2rem;
  margin-bottom: 1rem;
}

.loading-state p {
  font-size: 1rem;
  color: #8c8c8c;
}

/* 空状态 */
.empty-state {
  padding: 3rem 2rem;
  text-align: center;
  color: #bfbfbf;
}

.empty-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
  opacity: 0.3;
}

.empty-state p {
  font-size: 1rem;
  margin-bottom: 1.5rem;
}

.mt-3 {
  margin-top: 1rem;
}

/* 弹窗样式 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 1rem;
}

.modal-content {
  background-color: #fff;
  border-radius: 8px;
  width: 100%;
  max-width: 600px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.25rem 1.5rem;
  border-bottom: 1px solid #e8e8e8;
}

.modal-header h3 {
  font-size: 1.2rem;
  color: #2c3e50;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.text-warning {
  color: #faad14;
}

.close-btn {
  background: none;
  border: none;
  font-size: 1.1rem;
  color: #8c8c8c;
  cursor: pointer;
  padding: 0.4rem;
  border-radius: 4px;
  transition: all 0.3s;
}

.close-btn:hover {
  background-color: #f5f5f5;
  color: #595959;
}

.modal-body {
  padding: 1.5rem;
}

/* 确认弹窗 */
.confirm-modal {
  max-width: 450px;
}

.confirm-content {
  text-align: center;
  padding: 1rem 0 2rem;
}

.confirm-icon {
  font-size: 3rem;
  color: #ff4d4f;
  margin-bottom: 1rem;
  opacity: 0.8;
}

.confirm-message {
  font-size: 1rem;
  color: #2c3e50;
  margin-bottom: 1rem;
}

.confirm-message strong {
  color: #ff4d4f;
}

.confirm-warning {
  font-size: 0.9rem;
  color: #fa8c16;
  background-color: #fff7e6;
  padding: 0.75rem;
  border-radius: 6px;
  border: 1px solid #ffd591;
}

.confirm-actions {
  display: flex;
  gap: 1rem;
  justify-content: center;
}

/* 表单样式 */
.dept-form {
  margin-bottom: 0;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  margin-bottom: 1.5rem;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5rem;
  margin-bottom: 1.5rem;
}

.form-label {
  font-size: 0.9rem;
  color: #2c3e50;
  font-weight: 500;
}

.form-label.required::after {
  content: "*";
  color: #ff4d4f;
  margin-left: 4px;
}

.form-input {
  padding: 0.6rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  font-size: 0.85rem;
  transition: all 0.3s;
  width: 100%;
}

.form-input:focus {
  outline: none;
  border-color: #1890ff;
  box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.1);
}

.input-hint {
  font-size: 0.8rem;
  color: #8c8c8c;
  margin-top: 0.25rem;
}

.form-textarea {
  padding: 0.6rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  font-size: 0.85rem;
  transition: all 0.3s;
  width: 100%;
  resize: vertical;
  min-height: 90px;
}

.form-textarea:focus {
  outline: none;
  border-color: #1890ff;
  box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.1);
}

/* 树选择 */
.tree-select {
  position: relative;
}

.tree-item-root {
  font-weight: 600;
}

.tree-select-toggle {
  position: absolute;
  right: 0.5rem;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  color: #8c8c8c;
  cursor: pointer;
  padding: 0.25rem;
}

.tree-select-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background-color: #fff;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  z-index: 1000;
  max-height: 300px;
  overflow-y: auto;
  margin-top: 0.5rem;
}

.tree-search {
  padding: 0.75rem;
  border-bottom: 1px solid #f0f0f0;
}

.tree-search-input {
  padding: 0.5rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 4px;
  width: 100%;
  font-size: 0.85rem;
}

.tree-list {
  padding: 0.5rem 0;
}

.tree-item {
  padding: 0.5rem 1rem;
  cursor: pointer;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.tree-item:hover {
  background-color: #f5f5f5;
}

.tree-item i {
  color: #1890ff;
}

/* 状态单选组 */
.status-radio-group {
  display: flex;
  gap: 1.5rem;
  align-items: center;
}

.status-radio {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
}

.radio-input {
  width: 16px;
  height: 16px;
  cursor: pointer;
}

.radio-label {
  font-size: 0.9rem;
  color: #2c3e50;
}

.form-actions {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  margin-top: 2rem;
}

/* 详情弹窗：两列网格，避免重叠；邮箱不竖排 */
.detail-modal {
  max-width: 520px;
}

.detail-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 14px 24px;
}

.detail-item {
  display: grid;
  grid-template-columns: 80px 1fr;
  column-gap: 12px;
  align-items: start;
}

.detail-span-2 {
  grid-column: 1 / -1;
}

.detail-label {
  color: #8c8c8c;
  font-size: 0.9rem;
  line-height: 1.6;
  padding-top: 2px;
}

.detail-value {
  min-width: 0;
  color: #2c3e50;
  font-weight: 500;
  line-height: 1.6;
  word-break: normal;
  overflow-wrap: break-word;
}

.detail-sub {
  margin-left: 8px;
  color: #8c8c8c;
  font-weight: normal;
}

.detail-email {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.detail-remark {
  white-space: pre-wrap;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .navbar {
    padding: 1rem;
  }

  .detail-grid {
    grid-template-columns: 1fr;
  }

  .detail-span-2 {
    grid-column: auto;
  }

  .main-content {
    padding: 1rem;
  }

  .page-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }

  .actions {
    width: 100%;
    flex-wrap: wrap;
  }

  .btn {
    flex: 1;
    min-width: 120px;
    justify-content: center;
  }

  .query-row {
    flex-direction: column;
    align-items: stretch;
  }

  .query-group {
    max-width: 100%;
  }

  .query-actions {
    margin-left: 0;
    width: 100%;
    justify-content: flex-end;
  }

  .form-row {
    grid-template-columns: 1fr;
    gap: 1rem;
  }

  .dept-item-main {
    flex-direction: column;
    align-items: stretch;
    gap: 1rem;
  }

  .dept-actions {
    justify-content: flex-start;
    flex-wrap: wrap;
  }

  .btn-action {
    min-width: auto;
    flex: 1;
  }

  .dept-details {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }

  .dept-name {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }

  .order-num {
    margin-top: 0.25rem;
  }

  .modal-content {
    margin: 0.5rem;
  }

  .dept-children {
    margin-left: 1rem !important;
  }
}

@media (max-width: 480px) {
  .dept-actions {
    flex-direction: column;
  }

  .btn-action {
    width: 100%;
    justify-content: center;
  }

  .dept-item-main {
    padding: 0.75rem;
  }
}
</style>

<!-- 引入Font Awesome图标库 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" />
