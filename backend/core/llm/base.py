from abc import ABC, abstractmethod
from typing import Dict, List

class LLMBase(ABC):
    """大模型基类，统一调用接口"""
    def __init__(self, model_path: str, quantization: str = "INT4"):
        self.model_path = model_path
        self.quantization = quantization
        self.model = None
        self.tokenizer = None
        self._load_model()

    @abstractmethod
    def _load_model(self):
        """加载模型（子类实现）"""
        pass

    @abstractmethod
    def invoke(self, prompt: str, history: List[Dict] = None) -> str:
        """调用模型生成回答
        :param prompt: 提示词
        :param history: 对话历史 [{"role": "user/assistant", "content": "..."}]
        :return: 生成的回答
        """
        pass

# 注册模型映射
LLM_REGISTRY = {}
def register_llm(model_name: str):
    def decorator(cls):
        LLM_REGISTRY[model_name] = cls
        return cls
    return decorator

# 加载默认模型
def load_llm(model_name: str, model_path: str, quantization: str) -> LLMBase:
    if model_name not in LLM_REGISTRY:
        raise ValueError(f"不支持的模型：{model_name}，支持的模型：{list(LLM_REGISTRY.keys())}")
    return LLM_REGISTRY[model_name](model_path, quantization)
